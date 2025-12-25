# Firebase Configuration

This directory contains Firebase configuration and deployment files.

## Structure

```
firebase/
├── firebase.json         # Firebase project config
├── firestore.rules       # Firestore security rules
├── firestore.indexes.json # Firestore indexes
├── storage.rules         # Storage security rules
└── functions/            # Cloud Functions (if used)
```

## Setup

### 1. Install Firebase CLI

```bash
npm install -g firebase-tools
```

### 2. Login and Initialize

```bash
firebase login
firebase init
```

### 3. Select Services

Choose the services you need:
- Firestore
- Storage
- Functions
- Hosting
- Emulators

## Configuration

### firebase.json (example)

```json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "storage": {
    "rules": "storage.rules"
  },
  "emulators": {
    "firestore": {
      "port": 8080
    },
    "storage": {
      "port": 9199
    }
  }
}
```

## Commands

```bash
# Start emulators
make firebase-emulators

# Deploy rules
make firebase-deploy-rules

# Deploy all
make firebase-deploy
```

## Environment Variables

Add to `.env`:

```bash
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY=your-private-key
FIREBASE_CLIENT_EMAIL=your-client-email
```

## Security

- Never commit `firebase-adminsdk*.json` files
- Use environment variables for credentials
- Review security rules before deployment
