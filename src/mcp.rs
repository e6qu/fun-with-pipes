//! MCP servers (docs/mcp.md): the exported functions exposed as `mcp`
//! (`# expose: mcp`) are the tools of a stateless Model Context Protocol
//! server, version 2026-07-28 (`lib/mcp.fwp`). Like a REST server
//! (`src/rest.rs`), it is a generated `main` compiled with the program:
//! `fwp serve --mcp file.fwp` and `fwp build file.fwp --mcp`.
//!
//! A tool's arguments are a JSON object: the fields of its parameter
//! when it has one record parameter, else one member per parameter,
//! named by `# args:` (`input` for one parameter, `arg1`, `arg2`, ...
//! for several). Its result is the function's value, as text and as
//! `structuredContent` (`{"result": ...}` when it is not an object); an
//! `Error` effect or an `Err` is a result with `isError`. Input and
//! output schemas are the JSON Schemas of the types, as in OpenAPI
//! documents (`src/openapi.rs`).

use std::fmt::Write;
use std::path::Path;

use crate::driver::{Compilation, Failure};
use crate::ir::{Program, MT};
use crate::json::Json;
use crate::jsontype::{self, Shape};

/// The protocol version.
pub const VERSION: &str = "2026-07-28";

/// The generated `main` of an MCP server.
pub const ENTRY: &str = "main::fwp-mcp-main";

/// One tool: an exported function.
#[derive(Clone, Debug)]
pub struct Tool {
    pub function: String,
    /// The members of the arguments: none when the record parameter's
    /// fields are the arguments.
    pub params: Vec<String>,
    pub arity: usize,
    /// Whether the function returns a `Result` (`Err` is an error result).
    pub result: bool,
    /// Whether the structured result is `{"result": ...}`.
    pub wrap: bool,
    /// The tool as `tools/list` lists it.
    pub definition: Json,
}

/// The tools of a program: its exported functions exposed as `mcp`.
pub fn tools(prog: &Program) -> Result<Vec<Tool>, String> {
    prog.docs.check_expose()?;
    let mut out = Vec::new();
    for (name, fid) in &prog.exports {
        let f = &prog.funcs[*fid];
        if !crate::cli::is_command(name) || f.arity == 0 || !prog.docs.exposed(name, "mcp") {
            continue;
        }
        out.push(tool(prog, name, f.arity as usize, &f.ty)?);
    }
    if out.is_empty() {
        return Err(crate::cli::none_exposed("mcp", "an MCP tool"));
    }
    Ok(out)
}

fn is_object(t: &MT, prog: &Program) -> bool {
    matches!(
        jsontype::shape(t, prog),
        Shape::Record(..) | Shape::Unit | Shape::Map(..)
    )
}

/// A schema `{"$ref": "#/$defs/T", "$defs": ...}` as the schema of `T`
/// with the other definitions (MCP clients read the `properties` of an
/// input schema), and `{"type": "object"}` for `()`.
fn hoist(s: Json) -> Json {
    let Json::Obj(kv) = s else {
        return s;
    };
    let target = kv
        .iter()
        .find(|(k, _)| k == "$ref")
        .and_then(|(_, v)| v.as_str())
        .and_then(|r| r.strip_prefix("#/$defs/"))
        .map(str::to_string);
    let defs: Vec<(String, Json)> = kv
        .iter()
        .find(|(k, _)| k == "$defs")
        .map(|(_, d)| d.members().to_vec())
        .unwrap_or_default();
    let Some(name) = target else {
        return Json::Obj(kv);
    };
    let Some(Json::Obj(body)) = defs
        .iter()
        .find(|(n, _)| *n == name)
        .map(|(_, b)| b.clone())
    else {
        return Json::Obj(kv);
    };
    // the definition stays when other schemas refer to it
    let reference = format!("\"#/$defs/{}\"", name);
    let others: Vec<(String, Json)> = defs.into_iter().filter(|(n, _)| *n != name).collect();
    let used = Json::Obj(body.clone()).to_string().contains(&reference)
        || Json::Obj(others.clone()).to_string().contains(&reference);
    let mut out = body.clone();
    let mut defs = others;
    if used {
        defs.push((name, Json::Obj(body)));
    }
    if !defs.is_empty() {
        out.push(("$defs".into(), Json::Obj(defs)));
    }
    Json::Obj(out)
}

fn tool(prog: &Program, name: &str, arity: usize, ty: &MT) -> Result<Tool, String> {
    let (params, result) = ty.params(arity);
    let doc = prog.docs.funcs.get(name).cloned().unwrap_or_default();
    for p in &params {
        crate::rest::check_json(p, prog)
            .map_err(|e| format!("`{}` cannot be an MCP tool: its parameter: {}", name, e))?;
    }
    let (value, is_result) = match result {
        MT::Con(n, args) if n == "std::Result" && args.len() == 2 => (&args[0], true),
        t => (t, false),
    };
    crate::rest::check_json(value, prog)
        .map_err(|e| format!("`{}` cannot be an MCP tool: its result: {}", name, e))?;
    // the arguments: a record's fields, or one member per parameter
    let inline = doc.args.is_none() && arity == 1 && is_object(params[0], prog);
    let names: Vec<String> = match &doc.args {
        _ if inline => Vec::new(),
        Some(names) => {
            if names.len() != arity {
                return Err(format!(
                    "the `# args:` line of `{}` names {} argument{}, but it has {}",
                    name,
                    names.len(),
                    if names.len() == 1 { "" } else { "s" },
                    arity
                ));
            }
            names
                .iter()
                .map(|n| n.trim_end_matches("...").to_ascii_lowercase())
                .collect()
        }
        None if arity == 1 => vec!["input".into()],
        None => (1..=arity).map(|i| format!("arg{}", i)).collect(),
    };
    let input = if inline {
        hoist(crate::openapi::json_schema(prog, params[0]))
    } else {
        let props: Vec<(String, MT, String)> = names
            .iter()
            .zip(&params)
            .map(|(n, t)| (n.clone(), (*t).clone(), String::new()))
            .collect();
        crate::openapi::object_schema(prog, &props)
    };
    let wrap = !matches!(
        jsontype::shape(value, prog),
        Shape::Record(..) | Shape::Unit
    );
    let output = if wrap {
        crate::openapi::object_schema(prog, &[("result".into(), value.clone(), String::new())])
    } else {
        hoist(crate::openapi::json_schema(prog, value))
    };
    let mut def = vec![("name", Json::str(name))];
    let desc = doc.lines.join("\n").trim().to_string();
    if !desc.is_empty() {
        def.push(("description", Json::str(desc)));
    }
    def.push(("inputSchema", input));
    def.push(("outputSchema", output));
    // a function with no effects on the world reads it only
    let labels = prog
        .export_effects
        .get(name)
        .map(|(_, l)| l.clone())
        .unwrap_or_default();
    let pure = !labels
        .iter()
        .any(|l| matches!(l.as_str(), "IO" | "FileIO" | "Network" | "Async"));
    let mut hints = Vec::new();
    if pure {
        hints.push(("readOnlyHint", Json::Bool(true)));
        hints.push(("idempotentHint", Json::Bool(true)));
        hints.push(("openWorldHint", Json::Bool(false)));
    }
    if !hints.is_empty() {
        def.push(("annotations", Json::obj(hints)));
    }
    Ok(Tool {
        function: name.to_string(),
        params: names,
        arity,
        result: is_result,
        wrap,
        definition: Json::obj(def),
    })
}

/// The result of `server/discover`.
pub fn discover(prog: &Program, title: &str) -> Result<Json, String> {
    let version = crate::cli::version(prog)?.unwrap_or_else(|| "0.1.0".into());
    let mut out = vec![
        ("supportedVersions", Json::Arr(vec![Json::str(VERSION)])),
        (
            "capabilities",
            Json::obj(vec![("tools", Json::obj(vec![]))]),
        ),
        (
            "serverInfo",
            Json::obj(vec![
                ("name", Json::str(title)),
                ("version", Json::str(version)),
            ]),
        ),
    ];
    let desc = prog.docs.module.join("\n").trim().to_string();
    if !desc.is_empty() {
        out.push(("instructions", Json::str(desc)));
    }
    out.push(("resultType", Json::str("complete")));
    Ok(Json::obj(out))
}

/// The result of `tools/list`: the tools do not change while the server
/// runs, and are the same for every client.
pub fn tools_list(tools: &[Tool]) -> Json {
    Json::obj(vec![
        (
            "tools",
            Json::Arr(tools.iter().map(|t| t.definition.clone()).collect()),
        ),
        ("ttlMs", Json::Num(3_600_000.0)),
        ("cacheScope", Json::str("public")),
        ("resultType", Json::str("complete")),
    ])
}

/// The fwp source of the server's `main`.
pub fn server_source(tools: &[Tool], discover: &Json, list: &Json) -> String {
    let mut out = String::from("# generated by fwp for `--mcp` (src/mcp.rs)\n\n");
    let max = tools.iter().map(|t| t.arity).max().unwrap_or(0);
    crate::rest::uncurry_helpers(&mut out, "fwp-mcp", max);
    let _ = write!(
        out,
        "fwp-mcp-main =\n    mcp.serve McpServer {{\n        discover = {},\n        tools-list = {},\n        tools = [\n",
        crate::rest::fwp_string(&discover.to_string()),
        crate::rest::fwp_string(&list.to_string()),
    );
    for t in tools {
        let params: Vec<String> = t
            .params
            .iter()
            .map(|p| crate::rest::fwp_string(p))
            .collect();
        let _ = writeln!(
            out,
            "            {} (McpToolSpec {{ name = {}, params = [{}], wrap = {} }}) {},",
            if t.result {
                "mcp.tool-result"
            } else {
                "mcp.tool"
            },
            crate::rest::fwp_string(&t.function),
            params.join(", "),
            if t.wrap { "True" } else { "False" },
            crate::rest::uncurried("fwp-mcp", &t.function, t.arity),
        );
    }
    out.push_str("        ],\n    }\n");
    out
}

fn failure(msg: String) -> Failure {
    Failure {
        rendered: format!("error: {}\n", msg),
        diagnostics: vec![],
        sm: Default::default(),
        root: u32::MAX,
    }
}

/// The tools of a file, and the results of `server/discover` and
/// `tools/list`.
pub fn describe(path: &Path) -> Result<(Compilation, Vec<Tool>, Json, Json), Failure> {
    let roots = crate::mono::Roots {
        exports: true,
        ..Default::default()
    };
    let (c, prog) = crate::driver::compile_file(path, roots)?;
    let tools = tools(&prog).map_err(failure)?;
    let discover = discover(&prog, &crate::rest::title(path)).map_err(failure)?;
    let list = tools_list(&tools);
    Ok((c, tools, discover, list))
}

/// Compile a file as an MCP server: a program whose `main` serves its
/// tools. The warnings are those of the user's file.
pub fn compile(path: &Path) -> Result<(Compilation, Program), Failure> {
    let (c, tools, discover, list) = describe(path)?;
    let text = std::fs::read_to_string(path).map_err(|e| failure(e.to_string()))?;
    let extra = server_source(&tools, &discover, &list);
    let c2 = crate::driver::check_source_with(
        &path.to_string_lossy(),
        &text,
        path.parent(),
        Some(("<mcp server>", &extra)),
    )?;
    let roots = crate::mono::Roots {
        entry: Some(ENTRY.to_string()),
        ..Default::default()
    };
    let (_, prog) = crate::driver::lower(c2, roots)?;
    Ok((c, prog))
}
