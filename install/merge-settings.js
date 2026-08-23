#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const CLAUDE_DIR = process.env.CLAUDE_DIR || path.join(process.env.HOME || process.env.USERPROFILE, '.claude');
const SETTINGS_PATH = path.join(CLAUDE_DIR, 'settings.json');
const TEMPLATE_PATH = path.join(__dirname, '..', 'templates', 'settings.template.json');

let existing = {};
if (fs.existsSync(SETTINGS_PATH)) {
  try {
    existing = JSON.parse(fs.readFileSync(SETTINGS_PATH, 'utf8'));
  } catch (e) {
    console.error('Invalid settings.json, backing up and replacing');
    fs.copyFileSync(SETTINGS_PATH, SETTINGS_PATH + '.bak');
  }
}

let template = {};
if (fs.existsSync(TEMPLATE_PATH)) {
  template = JSON.parse(fs.readFileSync(TEMPLATE_PATH, 'utf8'));
}

const merged = { ...template, ...existing };
fs.writeFileSync(SETTINGS_PATH, JSON.stringify(merged, null, 2) + '\n');
console.log('Merged settings into', SETTINGS_PATH);
