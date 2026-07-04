# Firestore Portfolio Content

The portfolio can load editable content from Firestore at runtime, so text
changes do not require a new Vercel build.

## Firebase Setup

Use the free Spark plan and create a Cloud Firestore database.

Create this document:

```text
collection: site
document: portfolio
```

The app reads this path by default:

```text
site/portfolio
```

If you use another path, set this build variable:

```text
FIRESTORE_CONTENT_DOC_PATH=site/portfolio
```

## Vercel Variable

Add this environment variable in Vercel:

```text
FIREBASE_PROJECT_ID=your-firebase-project-id
```

Then redeploy once. After that, Firestore content edits will update without
another Vercel build.

You can also bypass Firestore and load any public JSON URL:

```text
PORTFOLIO_CONTENT_URL=https://example.com/portfolio-content.json
```

## Firestore Fields

Add these top-level fields as arrays of maps. Any missing or empty field will
fall back to the hardcoded data in `AppClass`.

The full current content template lives here:

```text
docs/portfolio-content-template.json
```

To upload this template automatically instead of entering nested arrays by hand,
use:

```bash
FIREBASE_PROJECT_ID=shahzaib-portfolio-a3bad node scripts/upload_firestore_content.js
```

```json
{
  "projects": [
    {
      "name": "Paw Play Love",
      "image": "assets/projects/project_ppl.png",
      "description": "Project description...",
      "role": "Flutter developer",
      "timeline": "Social product",
      "impact": "Subscriptions + real-time community",
      "androidLink": "https://play.google.com/store/apps/details?id=com.pawplaylove",
      "iosLink": "https://apps.apple.com/id/app/paw-play-love/id6648773545",
      "techs": ["Flutter", "Firebase", "Socket.io"],
      "highlights": ["Built live social interactions."],
      "isFeatured": true
    }
  ],
  "skills": [
    {
      "name": "Flutter",
      "value": 0.9
    }
  ],
  "skillsImages": [
    {
      "name": "Flutter",
      "image": "assets/skills/skills-flutter.png"
    }
  ],
  "blogs": [
    {
      "title": "How to Add a Heatmap in Flutter",
      "description": "Article summary...",
      "imageUrl": "https://example.com/blog-cover.jpg",
      "link": "https://example.com/blog",
      "date": "Oct 07, 2025"
    }
  ],
  "packages": [
    {
      "name": "fancy_button_animations",
      "description": "Package description...",
      "version": "v0.0.2",
      "pubLink": "https://pub.dev/packages/fancy_button_animations",
      "techs": ["Flutter", "Dart", "Animations"]
    }
  ]
}
```

## Firestore Rules

For a public portfolio, allow public reads for only this content document and
keep writes private:

```text
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /site/portfolio {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

Use local asset paths for images if you want to stay fully free and simple.
Changing or adding local image files still requires a new build.
