//! Types, rows, and unification.
//!
//! Type variables live in a union-find style table with Rémy levels for
//! generalization. Records and effects share one row representation: a
//! sorted list of labelled entries plus an optional tail variable. Tuples are
//! records with numeric labels, and unit is the empty closed record.

use std::cmp::Ordering;
use std::collections::{BTreeMap, HashMap, HashSet};

pub type TV = u32;

#[derive(Clone, Debug, PartialEq)]
pub enum Type {
    Var(TV),
    /// Type constructor applied to arguments (possibly none). Names are
    /// canonical (`std::List`).
    Con(String, Vec<Type>),
    /// Application with a non-constructor head (higher-kinded variables).
    App(Box<Type>, Vec<Type>),
    /// Function type with the effect row performed when it is applied.
    Fun(Box<Type>, Box<Type>, Row),
    Record(Row),
    /// Type-level natural number.
    Nat(u64),
}

#[derive(Clone, Debug, PartialEq, Default)]
pub struct Row {
    pub fields: Vec<(String, Type)>,
    pub tail: Option<TV>,
}

impl Row {
    pub fn closed(fields: Vec<(String, Type)>) -> Row {
        let mut r = Row { fields, tail: None };
        r.sort();
        r
    }

    pub fn empty() -> Row {
        Row::default()
    }

    pub fn sort(&mut self) {
        self.fields.sort_by(|a, b| label_cmp(&a.0, &b.0));
    }
}

/// Label order: numeric labels first (numerically), then names.
pub fn label_cmp(a: &str, b: &str) -> Ordering {
    match (a.parse::<u64>(), b.parse::<u64>()) {
        (Ok(x), Ok(y)) => x.cmp(&y),
        (Ok(_), Err(_)) => Ordering::Less,
        (Err(_), Ok(_)) => Ordering::Greater,
        _ => a.cmp(b),
    }
}

impl Type {
    pub fn con(name: &str) -> Type {
        Type::Con(name.to_string(), vec![])
    }

    pub fn unit() -> Type {
        Type::Record(Row::empty())
    }

    pub fn fun(a: Type, b: Type, eff: Row) -> Type {
        Type::Fun(Box::new(a), Box::new(b), eff)
    }

    pub fn tuple(items: Vec<Type>) -> Type {
        Type::Record(Row::closed(
            items
                .into_iter()
                .enumerate()
                .map(|(i, t)| (i.to_string(), t))
                .collect(),
        ))
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
    /// An ordinary type.
    Star,
    /// A record row tail.
    Row,
    /// An effect row tail.
    Eff,
}

#[derive(Clone, Debug)]
pub struct VarInfo {
    pub bound: Option<Type>,
    pub level: u32,
    pub kind: Kind,
    /// Rigid (skolem) variables cannot be bound; they carry the source name.
    pub rigid: Option<String>,
}

/// Declared nominal record: parameter template variables and field types.
#[derive(Clone, Debug)]
pub struct RecordTemplate {
    pub params: Vec<TV>,
    pub fields: Vec<(String, Type)>,
}

#[derive(Debug)]
pub enum UnifyError {
    Mismatch(Type, Type),
    Occurs(TV, Type),
    MissingLabel(String, Kind),
    LabelOnRigid(String),
    RigidRow,
}

#[derive(Default)]
pub struct TypeTable {
    pub vars: Vec<VarInfo>,
    pub records: HashMap<String, RecordTemplate>,
}

impl TypeTable {
    pub fn fresh(&mut self, kind: Kind, level: u32) -> TV {
        self.vars.push(VarInfo {
            bound: None,
            level,
            kind,
            rigid: None,
        });
        (self.vars.len() - 1) as TV
    }

    pub fn fresh_rigid(&mut self, kind: Kind, level: u32, name: &str) -> TV {
        let v = self.fresh(kind, level);
        self.vars[v as usize].rigid = Some(name.to_string());
        v
    }

    pub fn fresh_ty(&mut self, level: u32) -> Type {
        Type::Var(self.fresh(Kind::Star, level))
    }

    pub fn fresh_eff(&mut self, level: u32) -> Row {
        Row {
            fields: vec![],
            tail: Some(self.fresh(Kind::Eff, level)),
        }
    }

    pub fn is_rigid(&self, v: TV) -> bool {
        self.vars[v as usize].rigid.is_some()
    }

    fn bind(&mut self, v: TV, t: Type) {
        self.vars[v as usize].bound = Some(t);
    }

    /// Follow variable bindings at the head and normalize constructor
    /// applications.
    pub fn resolve(&self, t: &Type) -> Type {
        let mut t = t.clone();
        loop {
            match t {
                Type::Var(v) => match &self.vars[v as usize].bound {
                    Some(b) => t = b.clone(),
                    None => return t,
                },
                Type::App(head, args) => {
                    let h = self.resolve(&head);
                    match h {
                        Type::Con(n, mut a) => {
                            a.extend(args);
                            return Type::Con(n, a);
                        }
                        Type::App(h2, mut a) => {
                            a.extend(args);
                            return Type::App(h2, a);
                        }
                        other => return Type::App(Box::new(other), args),
                    }
                }
                _ => return t,
            }
        }
    }

    /// Flatten a row by following bound tail variables.
    pub fn flatten_row(&self, r: &Row) -> Row {
        let mut fields = r.fields.clone();
        let mut tail = r.tail;
        while let Some(v) = tail {
            match &self.vars[v as usize].bound {
                Some(Type::Record(r2)) => {
                    fields.extend(r2.fields.iter().cloned());
                    tail = r2.tail;
                }
                Some(other) => panic!("row variable bound to non-row {:?}", other),
                None => break,
            }
        }
        let mut row = Row { fields, tail };
        row.sort();
        row
    }

    /// Fully substitute bound variables.
    pub fn zonk(&self, t: &Type) -> Type {
        match self.resolve(t) {
            Type::Var(v) => Type::Var(v),
            Type::Con(n, args) => Type::Con(n, args.iter().map(|a| self.zonk(a)).collect()),
            Type::App(h, args) => Type::App(
                Box::new(self.zonk(&h)),
                args.iter().map(|a| self.zonk(a)).collect(),
            ),
            Type::Fun(a, b, e) => Type::Fun(
                Box::new(self.zonk(&a)),
                Box::new(self.zonk(&b)),
                self.zonk_row(&e),
            ),
            Type::Record(r) => Type::Record(self.zonk_row(&r)),
            Type::Nat(n) => Type::Nat(n),
        }
    }

    pub fn zonk_row(&self, r: &Row) -> Row {
        let r = self.flatten_row(r);
        Row {
            fields: r
                .fields
                .iter()
                .map(|(l, t)| (l.clone(), self.zonk(t)))
                .collect(),
            tail: r.tail,
        }
    }

    /// Collect unbound variables in order of first appearance.
    pub fn free_vars(&self, t: &Type, out: &mut Vec<TV>) {
        match self.resolve(t) {
            Type::Var(v) => {
                if !out.contains(&v) {
                    out.push(v)
                }
            }
            Type::Con(_, args) => args.iter().for_each(|a| self.free_vars(a, out)),
            Type::App(h, args) => {
                self.free_vars(&h, out);
                args.iter().for_each(|a| self.free_vars(a, out));
            }
            Type::Fun(a, b, e) => {
                self.free_vars(&a, out);
                self.free_vars(&b, out);
                self.free_vars_row(&e, out);
            }
            Type::Record(r) => self.free_vars_row(&r, out),
            Type::Nat(_) => {}
        }
    }

    pub fn free_vars_row(&self, r: &Row, out: &mut Vec<TV>) {
        let r = self.flatten_row(r);
        for (_, t) in &r.fields {
            self.free_vars(t, out);
        }
        if let Some(v) = r.tail {
            if !out.contains(&v) {
                out.push(v);
            }
        }
    }

    /// Occurs check plus level adjustment.
    fn occurs_adjust(&mut self, v: TV, t: &Type, level: u32) -> bool {
        let mut fv = Vec::new();
        self.free_vars(t, &mut fv);
        for w in fv {
            if w == v {
                return true;
            }
            let info = &mut self.vars[w as usize];
            if info.level > level {
                info.level = level;
            }
        }
        false
    }

    /// Substitute template variables.
    pub fn subst(t: &Type, map: &HashMap<TV, Type>) -> Type {
        match t {
            Type::Var(v) => map.get(v).cloned().unwrap_or(Type::Var(*v)),
            Type::Con(n, args) => Type::Con(
                n.clone(),
                args.iter().map(|a| Self::subst(a, map)).collect(),
            ),
            Type::App(h, args) => Type::App(
                Box::new(Self::subst(h, map)),
                args.iter().map(|a| Self::subst(a, map)).collect(),
            ),
            Type::Fun(a, b, e) => Type::Fun(
                Box::new(Self::subst(a, map)),
                Box::new(Self::subst(b, map)),
                Self::subst_row(e, map),
            ),
            Type::Record(r) => Type::Record(Self::subst_row(r, map)),
            Type::Nat(n) => Type::Nat(*n),
        }
    }

    pub fn subst_row(r: &Row, map: &HashMap<TV, Type>) -> Row {
        let mut fields: Vec<(String, Type)> = r
            .fields
            .iter()
            .map(|(l, t)| (l.clone(), Self::subst(t, map)))
            .collect();
        let mut tail = r.tail;
        if let Some(v) = r.tail {
            if let Some(rep) = map.get(&v) {
                match rep {
                    Type::Var(w) => tail = Some(*w),
                    Type::Record(r2) => {
                        fields.extend(r2.fields.iter().cloned());
                        tail = r2.tail;
                    }
                    _ => panic!("row substitution with non-row"),
                }
            }
        }
        let mut row = Row { fields, tail };
        row.sort();
        row
    }

    /// Expand a nominal record type to its closed structural row.
    pub fn expand_record(&self, name: &str, args: &[Type]) -> Option<Row> {
        let tpl = self.records.get(name)?;
        let map: HashMap<TV, Type> = tpl
            .params
            .iter()
            .cloned()
            .zip(args.iter().cloned())
            .collect();
        Some(Row::closed(
            tpl.fields
                .iter()
                .map(|(l, t)| (l.clone(), Self::subst(t, &map)))
                .collect(),
        ))
    }

    pub fn unify(&mut self, a: &Type, b: &Type) -> Result<(), UnifyError> {
        let a = self.resolve(a);
        let b = self.resolve(b);
        match (&a, &b) {
            (Type::Var(x), Type::Var(y)) if x == y => Ok(()),
            (Type::Var(x), _) if !self.is_rigid(*x) => self.bind_var(*x, &b),
            (_, Type::Var(y)) if !self.is_rigid(*y) => self.bind_var(*y, &a),
            (Type::Con(n, xs), Type::Con(m, ys)) if n == m && xs.len() == ys.len() => {
                for (x, y) in xs.iter().zip(ys) {
                    self.unify(x, y)?;
                }
                Ok(())
            }
            (Type::Con(n, xs), Type::Record(r)) | (Type::Record(r), Type::Con(n, xs))
                if self.records.contains_key(n) =>
            {
                let row = self.expand_record(n, xs).unwrap();
                self.unify_row(&row, r, Kind::Row)
            }
            (Type::Con(n, xs), Type::App(h, ys)) | (Type::App(h, ys), Type::Con(n, xs)) => {
                if ys.len() > xs.len() {
                    return Err(UnifyError::Mismatch(a.clone(), b.clone()));
                }
                let k = xs.len() - ys.len();
                self.unify(h, &Type::Con(n.clone(), xs[..k].to_vec()))?;
                for (x, y) in xs[k..].iter().zip(ys) {
                    self.unify(x, y)?;
                }
                Ok(())
            }
            (Type::App(h1, xs), Type::App(h2, ys)) if xs.len() == ys.len() => {
                self.unify(h1, h2)?;
                for (x, y) in xs.iter().zip(ys) {
                    self.unify(x, y)?;
                }
                Ok(())
            }
            (Type::Fun(a1, r1, e1), Type::Fun(a2, r2, e2)) => {
                self.unify(a1, a2)?;
                self.unify(r1, r2)?;
                self.unify_row(e1, e2, Kind::Eff)
            }
            (Type::Record(r1), Type::Record(r2)) => self.unify_row(r1, r2, Kind::Row),
            (Type::Nat(x), Type::Nat(y)) if x == y => Ok(()),
            _ => Err(UnifyError::Mismatch(a.clone(), b.clone())),
        }
    }

    fn bind_var(&mut self, v: TV, t: &Type) -> Result<(), UnifyError> {
        let level = self.vars[v as usize].level;
        if self.occurs_adjust(v, t, level) {
            return Err(UnifyError::Occurs(v, t.clone()));
        }
        self.bind(v, t.clone());
        Ok(())
    }

    pub fn unify_row(&mut self, r1: &Row, r2: &Row, kind: Kind) -> Result<(), UnifyError> {
        let r1 = self.flatten_row(r1);
        let r2 = self.flatten_row(r2);
        let m1: BTreeMap<&str, &Type> = r1.fields.iter().map(|(l, t)| (l.as_str(), t)).collect();
        let m2: BTreeMap<&str, &Type> = r2.fields.iter().map(|(l, t)| (l.as_str(), t)).collect();
        let mut only1 = Vec::new();
        let mut only2 = Vec::new();
        let mut common = Vec::new();
        for (l, t) in &r1.fields {
            match m2.get(l.as_str()) {
                Some(t2) => common.push((t.clone(), (*t2).clone())),
                None => only1.push((l.clone(), t.clone())),
            }
        }
        for (l, t) in &r2.fields {
            if !m1.contains_key(l.as_str()) {
                only2.push((l.clone(), t.clone()));
            }
        }
        for (a, b) in common {
            self.unify(&a, &b)?;
        }
        let missing = |only: &Vec<(String, Type)>| -> UnifyError {
            UnifyError::MissingLabel(only[0].0.clone(), kind)
        };
        match (r1.tail, r2.tail) {
            (None, None) => {
                if !only1.is_empty() {
                    return Err(missing(&only1));
                }
                if !only2.is_empty() {
                    return Err(missing(&only2));
                }
                Ok(())
            }
            (Some(t1), None) => {
                if !only1.is_empty() {
                    return Err(missing(&only1));
                }
                self.bind_row_tail(t1, only2, None)
            }
            (None, Some(t2)) => {
                if !only2.is_empty() {
                    return Err(missing(&only2));
                }
                self.bind_row_tail(t2, only1, None)
            }
            (Some(t1), Some(t2)) if t1 == t2 => {
                if !only1.is_empty() || !only2.is_empty() {
                    return Err(UnifyError::RigidRow);
                }
                Ok(())
            }
            (Some(t1), Some(t2)) => {
                let rig1 = self.is_rigid(t1);
                let rig2 = self.is_rigid(t2);
                match (rig1, rig2) {
                    (true, true) => Err(UnifyError::RigidRow),
                    (true, false) => {
                        if !only2.is_empty() {
                            return Err(UnifyError::LabelOnRigid(only2[0].0.clone()));
                        }
                        self.bind_row_tail(t2, only1, Some(t1))
                    }
                    (false, true) => {
                        if !only1.is_empty() {
                            return Err(UnifyError::LabelOnRigid(only1[0].0.clone()));
                        }
                        self.bind_row_tail(t1, only2, Some(t2))
                    }
                    (false, false) => {
                        let level = self.vars[t1 as usize]
                            .level
                            .min(self.vars[t2 as usize].level);
                        let k = self.vars[t1 as usize].kind;
                        let t3 = self.fresh(k, level);
                        self.bind_row_tail(t1, only2, Some(t3))?;
                        self.bind_row_tail(t2, only1, Some(t3))
                    }
                }
            }
        }
    }

    fn bind_row_tail(
        &mut self,
        v: TV,
        fields: Vec<(String, Type)>,
        tail: Option<TV>,
    ) -> Result<(), UnifyError> {
        if self.is_rigid(v) {
            if fields.is_empty() && tail.is_none() {
                return Err(UnifyError::RigidRow);
            }
            if !fields.is_empty() {
                return Err(UnifyError::LabelOnRigid(fields[0].0.clone()));
            }
            return Err(UnifyError::RigidRow);
        }
        let mut row = Row { fields, tail };
        row.sort();
        let t = Type::Record(row);
        self.bind_var(v, &t)
    }
}

/// Human-readable type printing with stable variable names.
pub struct Printer<'a> {
    pub table: &'a TypeTable,
    names: HashMap<TV, String>,
    counts: HashMap<TV, usize>,
    next: [usize; 3],
}

impl<'a> Printer<'a> {
    pub fn new(table: &'a TypeTable) -> Self {
        Printer {
            table,
            names: HashMap::new(),
            counts: HashMap::new(),
            next: [0; 3],
        }
    }

    /// Prepare for printing `ts` together (so shared variables get the same
    /// names and lone effect tails can be hidden).
    pub fn prepare(&mut self, ts: &[&Type]) {
        for t in ts {
            let z = self.table.zonk(t);
            self.count(&z);
        }
    }

    fn count(&mut self, t: &Type) {
        match t {
            Type::Var(v) => *self.counts.entry(*v).or_default() += 1,
            Type::Con(_, a) => a.iter().for_each(|x| self.count(x)),
            Type::App(h, a) => {
                self.count(h);
                a.iter().for_each(|x| self.count(x));
            }
            Type::Fun(a, b, e) => {
                self.count(a);
                self.count(b);
                self.count_row(e);
            }
            Type::Record(r) => self.count_row(r),
            Type::Nat(_) => {}
        }
    }

    fn count_row(&mut self, r: &Row) {
        for (_, t) in &r.fields {
            self.count(t);
        }
        if let Some(v) = r.tail {
            *self.counts.entry(v).or_default() += 1;
        }
    }

    fn var_name(&mut self, v: TV) -> String {
        if let Some(n) = &self.table.vars[v as usize].rigid {
            return n.clone();
        }
        if let Some(n) = self.names.get(&v) {
            return n.clone();
        }
        let kind = self.table.vars[v as usize].kind;
        let k = kind as usize;
        let i = self.next[k];
        self.next[k] += 1;
        let name = match kind {
            Kind::Star => {
                let letters = b"abcdfghijklmnopqstuvwxyz";
                let l = letters[i % letters.len()] as char;
                if i < letters.len() {
                    l.to_string()
                } else {
                    format!("{}{}", l, i / letters.len())
                }
            }
            Kind::Row | Kind::Eff => {
                let base = if kind == Kind::Row { "r" } else { "e" };
                if i == 0 {
                    base.to_string()
                } else {
                    format!("{}{}", base, i)
                }
            }
        };
        self.names.insert(v, name.clone());
        name
    }

    pub fn show(&mut self, t: &Type) -> String {
        let z = self.table.zonk(t);
        if self.counts.is_empty() {
            self.count(&z);
        }
        self.go(&z)
    }

    fn go(&mut self, t: &Type) -> String {
        match t {
            Type::Fun(a, b, e) => {
                let lhs = self.atom_or_paren(a, true);
                let rhs = self.go(b);
                let eff = self.effects(e);
                if eff.is_empty() {
                    format!("{} -> {}", lhs, rhs)
                } else {
                    format!("{} -> {} ! {}", lhs, rhs, eff)
                }
            }
            _ => self.atom(t),
        }
    }

    fn atom_or_paren(&mut self, t: &Type, fun_needs_paren: bool) -> String {
        match t {
            Type::Fun(..) if fun_needs_paren => format!("({})", self.go(t)),
            _ => self.atom(t),
        }
    }

    fn effects(&mut self, e: &Row) -> String {
        let labels: Vec<String> = e
            .fields
            .iter()
            .map(|(l, t)| match t {
                Type::Record(r) if r.fields.is_empty() && r.tail.is_none() => l.clone(),
                _ => format!("{}[{}]", l, self.go(t)),
            })
            .collect();
        let tail = match e.tail {
            Some(v) if self.counts.get(&v).copied().unwrap_or(0) > 1 || self.table.is_rigid(v) => {
                Some(self.var_name(v))
            }
            _ => None,
        };
        match (labels.is_empty(), tail) {
            (true, None) => String::new(),
            (true, Some(t)) => t,
            (false, None) => format!("{{{}}}", labels.join(", ")),
            (false, Some(t)) => format!("{{{} | {}}}", labels.join(", "), t),
        }
    }

    fn atom(&mut self, t: &Type) -> String {
        match t {
            Type::Var(v) => self.var_name(*v),
            Type::Con(n, args) => {
                let short = display_name(n);
                if args.is_empty() {
                    short
                } else {
                    let a: Vec<String> = args.iter().map(|x| self.go(x)).collect();
                    format!("{}[{}]", short, a.join(", "))
                }
            }
            Type::App(h, args) => {
                let h = self.atom(h);
                let a: Vec<String> = args.iter().map(|x| self.go(x)).collect();
                format!("{}[{}]", h, a.join(", "))
            }
            Type::Fun(..) => format!("({})", self.go(t)),
            Type::Nat(n) => n.to_string(),
            Type::Record(r) => {
                let is_tuple = r.tail.is_none()
                    && !r.fields.is_empty()
                    && r.fields.len() > 1
                    && r.fields
                        .iter()
                        .enumerate()
                        .all(|(i, (l, _))| *l == i.to_string());
                if r.fields.is_empty() && r.tail.is_none() {
                    return "()".into();
                }
                if is_tuple {
                    let items: Vec<String> = r.fields.iter().map(|(_, t)| self.go(t)).collect();
                    return format!("({})", items.join(", "));
                }
                let fs: Vec<String> = r
                    .fields
                    .iter()
                    .map(|(l, t)| format!("{}: {}", l, self.go(t)))
                    .collect();
                match r.tail {
                    Some(v) => format!("{{{} | {}}}", fs.join(", "), self.var_name(v)),
                    None => format!("{{{}}}", fs.join(", ")),
                }
            }
        }
    }
}

/// Strip the module prefix from a canonical name for display.
pub fn display_name(n: &str) -> String {
    match n.split_once("::") {
        Some((m, rest)) if m == "std" || m == "main" => rest.to_string(),
        Some((m, rest)) => format!("{}.{}", m, rest),
        None => n.to_string(),
    }
}

/// Set of variables, used for generalization bookkeeping.
pub type VarSet = HashSet<TV>;
