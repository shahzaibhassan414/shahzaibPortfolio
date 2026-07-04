#!/usr/bin/env node

const { execFileSync } = require('child_process');
const fs = require('fs');
const os = require('os');
const path = require('path');

const projectId = process.env.FIREBASE_PROJECT_ID;
const documentPath = process.env.FIRESTORE_CONTENT_DOC_PATH || 'site/portfolio';
const inputPath = process.argv[2] || 'docs/portfolio-content-template.json';

if (!projectId) {
  console.error('Missing FIREBASE_PROJECT_ID environment variable.');
  process.exit(1);
}

function firestoreValue(value) {
  if (value === null) return { nullValue: null };

  if (Array.isArray(value)) {
    return { arrayValue: { values: value.map(firestoreValue) } };
  }

  switch (typeof value) {
    case 'string':
      return { stringValue: value };
    case 'boolean':
      return { booleanValue: value };
    case 'number':
      return Number.isInteger(value)
        ? { integerValue: value.toString() }
        : { doubleValue: value };
    case 'object':
      return {
        mapValue: {
          fields: Object.fromEntries(
            Object.entries(value).map(([key, item]) => [key, firestoreValue(item)])
          ),
        },
      };
    default:
      return { stringValue: String(value) };
  }
}

function firestoreDocument(json) {
  return {
    fields: Object.fromEntries(
      Object.entries(json).map(([key, value]) => [key, firestoreValue(value)])
    ),
  };
}

function firebaseAccessToken() {
  if (process.env.FIREBASE_TOKEN) return process.env.FIREBASE_TOKEN;

  const configPath = path.join(
    os.homedir(),
    '.config',
    'configstore',
    'firebase-tools.json'
  );

  if (!fs.existsSync(configPath)) {
    throw new Error(
      'Firebase CLI config not found. Run `firebase login` or set FIREBASE_TOKEN.'
    );
  }

  const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
  const token = config.tokens && config.tokens.access_token;
  const expiresAt = config.tokens && config.tokens.expires_at;

  if (!token) {
    throw new Error(
      'Firebase CLI access token not found. Run `firebase login` or set FIREBASE_TOKEN.'
    );
  }

  if (expiresAt && Number(expiresAt) <= Date.now()) {
    throw new Error(
      'Firebase CLI access token is expired. Run `firebase login` or set FIREBASE_TOKEN.'
    );
  }

  return token;
}

const absoluteInputPath = path.resolve(inputPath);
const content = JSON.parse(fs.readFileSync(absoluteInputPath, 'utf8'));
const body = JSON.stringify(firestoreDocument(content));
const accessToken = firebaseAccessToken();

const encodedDocumentPath = documentPath
  .split('/')
  .filter(Boolean)
  .map(encodeURIComponent)
  .join('/');
const url = `https://firestore.googleapis.com/v1/projects/${encodeURIComponent(
  projectId
)}/databases/(default)/documents/${encodedDocumentPath}`;

execFileSync(
  'curl',
  [
    '-sS',
    '-X',
    'PATCH',
    '-H',
    `Authorization: Bearer ${accessToken}`,
    '-H',
    'Content-Type: application/json',
    '--data-binary',
    body,
    url,
  ],
  { stdio: 'inherit' }
);

console.log(`\nUploaded ${absoluteInputPath} to ${documentPath}.`);
