// Drive a `--target wasm32-browser` build with node, as a page would:
// `node browser-run.mjs program.js` prints the lines the program writes.
import { readFile } from "node:fs/promises";
import { pathToFileURL } from "node:url";
import process from "node:process";

const js = process.argv[2];
const { run } = await import(pathToFileURL(js).href);
const bytes = await readFile(js.replace(/\.js$/, ".wasm"));
const lines = [];
const code = await run({
  bytes,
  stdout: (line) => lines.push(line),
  stderr: (line) => lines.push("stderr: " + line),
  env: { FWP_SEED: "42" },
});
process.stdout.write(lines.map((l) => l + "\n").join(""));
process.exit(code);
