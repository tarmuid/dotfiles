#!/usr/bin/env node
import { spawnSync } from "node:child_process";

const allowedIds = new Set([
  "OPENCLAW_GATEWAY_TOKEN",
  "OPENCLAW_TELEGRAM_BOT_TOKEN",
]);

let stdin = "";
process.stdin.setEncoding("utf8");
process.stdin.on("data", (chunk) => {
  stdin += chunk;
});
process.stdin.on("error", (err) => {
  process.stderr.write(`${err.message}\n`);
  process.exit(1);
});
process.stdin.on("end", () => {
  let request;
  try {
    request = JSON.parse(stdin || "{}");
  } catch (err) {
    process.stderr.write(`Failed to parse request: ${err.message}\n`);
    process.exit(1);
  }

  if (request.protocolVersion !== 1 || !Array.isArray(request.ids)) {
    process.stderr.write("Invalid OpenClaw SecretRef exec request\n");
    process.exit(1);
  }
  if (!process.env.HOME) {
    process.stderr.write("HOME is required for fnox config lookup\n");
    process.exit(1);
  }

  const values = {};
  const errors = {};
  const configPath = `${process.env.HOME}/.openclaw/fnox.toml`;

  for (const id of request.ids) {
    if (!allowedIds.has(id)) {
      errors[id] = { message: `Unsupported fnox secret id: ${id}` };
      continue;
    }

    const result = spawnSync(
      "mise",
      ["exec", "fnox", "--", "fnox", "-c", configPath, "--non-interactive", "get", id],
      { encoding: "utf8", env: process.env },
    );
    if (result.status === 0) {
      const value = result.stdout.replace(/\r?\n$/, "");
      if (value.length > 0) {
        values[id] = value;
      } else {
        errors[id] = { message: "fnox returned an empty value" };
      }
    } else {
      errors[id] = {
        message: (result.stderr || `fnox exited ${result.status}`).trim(),
      };
    }
  }

  process.stdout.write(JSON.stringify({ protocolVersion: 1, values, errors }));
});
