//! Explicit Rust arena peer. Token slices borrow the input; nodes use indices.
use std::env;
use std::fs;
use std::hint::black_box;
use std::mem::size_of;
use std::time::Instant;

#[derive(Clone, Copy)]
#[repr(C)]
struct Node {
    value_or_left: i64,
    right: usize,
    tag: u64,
}

fn parse(
    tokens: &[&str],
    position: &mut usize,
    nodes: &mut Vec<Node>,
    allocations: &mut usize,
) -> usize {
    let token = *tokens.get(*position).expect("missing expression");
    *position += 1;
    let node = if token == "+" || token == "*" {
        let left = parse(tokens, position, nodes, allocations);
        let right = parse(tokens, position, nodes, allocations);
        Node {
            value_or_left: i64::try_from(left).unwrap(),
            right,
            tag: if token == "+" { 1 } else { 2 },
        }
    } else {
        Node {
            value_or_left: token.parse().expect("invalid integer"),
            right: 0,
            tag: 0,
        }
    };
    if nodes.len() == nodes.capacity() {
        let extra = if nodes.capacity() == 0 {
            8
        } else {
            nodes.capacity()
        };
        nodes.reserve_exact(extra);
        *allocations += 1;
    }
    let index = nodes.len();
    nodes.push(node);
    index
}
fn evaluate(nodes: &[Node], index: usize) -> i64 {
    let n = nodes[index];
    if n.tag == 0 {
        return n.value_or_left;
    }
    let left = evaluate(nodes, usize::try_from(n.value_or_left).unwrap());
    let right = evaluate(nodes, n.right);
    if n.tag == 1 {
        left.checked_add(right)
    } else {
        left.checked_mul(right)
    }
    .expect("integer overflow")
}
fn main() {
    let args: Vec<_> = env::args().collect();
    assert_eq!(args.len(), 5);
    let text = fs::read_to_string(&args[1]).unwrap();
    let rounds: usize = args[2].parse().unwrap();
    let expected: i64 = args[3].parse().unwrap();
    let expected_nodes: usize = args[4].parse().unwrap();
    assert!(rounds > 0 && expected_nodes > 0 && text.len() <= 65536);
    let (mut tokenize_ns, mut construct_ns, mut walk_ns, mut release_ns) = (0, 0, 0, 0);
    let (mut node_bytes, mut token_bytes, mut allocations) = (0, 0, 0);
    for _ in 0..rounds {
        let begin = Instant::now();
        let mut tokens = Vec::new();
        let mut token_allocations = 0;
        for token in black_box(&text).split_ascii_whitespace() {
            if tokens.len() == tokens.capacity() {
                let extra = if tokens.capacity() == 0 {
                    8
                } else {
                    tokens.capacity()
                };
                tokens.reserve_exact(extra);
                token_allocations += 1;
            }
            tokens.push(token);
        }
        let split = Instant::now();
        let mut nodes = Vec::new();
        let mut position = 0;
        let mut node_allocations = 0;
        let root = parse(&tokens, &mut position, &mut nodes, &mut node_allocations);
        let built = Instant::now();
        assert_eq!(position, tokens.len(), "trailing input");
        let result = black_box(evaluate(&nodes, root));
        let walked = Instant::now();
        node_bytes = nodes.capacity() * size_of::<Node>();
        token_bytes = tokens.capacity() * size_of::<&str>();
        allocations = node_allocations + token_allocations;
        let count = nodes.len();
        drop(nodes);
        drop(tokens);
        let released = Instant::now();
        assert_eq!(count, expected_nodes);
        assert_eq!(result, expected);
        tokenize_ns += (split - begin).as_nanos();
        construct_ns += (built - split).as_nanos();
        walk_ns += (walked - built).as_nanos();
        release_ns += (released - walked).as_nanos();
    }
    println!("{{\"rounds\":{rounds},\"result\":{expected},\"nodes\":{expected_nodes},\"tokenizeNs\":{tokenize_ns},\"constructNs\":{construct_ns},\"walkAndReleaseNs\":{},\"releaseNs\":{release_ns},\"totalNs\":{},\"nodeCapacityBytes\":{node_bytes},\"tokenCapacityBytes\":{token_bytes},\"allocations\":{allocations},\"nodeSize\":{}}}", walk_ns + release_ns, tokenize_ns + construct_ns + walk_ns + release_ns, size_of::<Node>());
}
