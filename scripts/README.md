# Firestore Upload Script

Use this when you want to upload `docs/portfolio-content-template.json` to
Firestore without entering arrays and maps manually in the Firebase console.

## One-time Login

Login with the Firebase CLI:

```bash
firebase login
```

## Upload

Run from the project root:

```bash
FIREBASE_PROJECT_ID=shahzaib-portfolio-a3bad node scripts/upload_firestore_content.js
```

By default, the script uploads:

```text
docs/portfolio-content-template.json
```

to:

```text
site/portfolio
```

You can upload another JSON file:

```bash
FIREBASE_PROJECT_ID=shahzaib-portfolio-a3bad node scripts/upload_firestore_content.js path/to/content.json
```
