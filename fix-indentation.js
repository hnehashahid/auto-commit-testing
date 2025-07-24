const fs = require("fs");
const path = require("path");

// Configuration
const INDENT_SIZE = 2;
const FILE_EXTENSION = ".view.lkml"; // You can change to ".model.lkml", ".explore.lkml", etc.
const TARGET_DIR = "./lookml"; // Your LookML folder

// Recursive function to walk through files
function walkDir(dir, callback) {
  fs.readdirSync(dir).forEach(f => {
    const dirPath = path.join(dir, f);
    const isDirectory = fs.statSync(dirPath).isDirectory();
    isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
  });
}

// Fix indentation in a LookML file
function fixIndentation(filePath) {
  const lines = fs.readFileSync(filePath, "utf8").split("\n");

  let indentLevel = 0;
  let inMultilineComment = false;
  const fixedLines = [];

  for (let line of lines) {
    let trimmed = line.trim();

    // Handle multi-line comments (/* */)
    if (trimmed.startsWith("/*")) inMultilineComment = true;
    if (trimmed.endsWith("*/")) inMultilineComment = false;

    if (inMultilineComment || trimmed === "") {
      fixedLines.push(line);
      continue;
    }

    // Adjust indent level
    if (trimmed.startsWith("}")) indentLevel = Math.max(indentLevel - 1, 0);

    const newLine = " ".repeat(indentLevel * INDENT_SIZE) + trimmed;
    fixedLines.push(newLine);

    if (trimmed.endsWith("{")) indentLevel++;
  }

  fs.writeFileSync(filePath, fixedLines.join("\n"), "utf8");
  console.log(`Fixed: ${filePath}`);
}

// Run
walkDir(TARGET_DIR, function (filePath) {
  if (filePath.endsWith(FILE_EXTENSION)) {
    fixIndentation(filePath);
  }
});
