# JMC Innovators Learning Platform — Flutter App

Native Flutter scaffold matching the branding of https://innovators-jmc.netlify.app,
covering every section from the spec: splash, onboarding, auth (Google / email /
phone OTP), home dashboard, explore grid, AI Center, AI Smart Notebook, JMC
Classroom, Exam Papers, Textbooks, Educational Videos, Science Lab, Math Lab,
Dictionary, Profile, Settings, and an Admin panel.

## Before you can build & run

This was generated without a Flutter SDK or network access, so nothing has
been compiled or tested. To get it running:

```bash
flutter pub get
flutterfire configure          # generates lib/firebase_options.dart
```

Then in `lib/main.dart`, uncomment:
```dart
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```
and add the matching import for `firebase_options.dart`.

## Wiring the AI Center to your existing backend

`lib/services/ai_service.dart` is written to call your team's existing
**JARK AI** backend (Node/Express + Groq) instead of standing up a second AI
service. Point it at your deployed backend without hardcoding the URL:

```bash
flutter run --dart-define=AI_BASE_URL=https://your-jark-ai-backend.example.com
```

Your Express route should accept `{ message, mode, history }` and return
`{ "reply": "..." }` — adjust the field name in `ai_service.dart` if your
existing endpoint differs. The spec mentioned a "GLM-5.2" model; if that's a
real, currently available API for your use case, swap the backend model call
inside your JARK AI server rather than re-pointing the Flutter app — the app
only talks to your own backend, never to a third-party model directly.

## What's real vs. stubbed

| Area | Status |
|---|---|
| Theme, navigation, all 20+ screens | Built with Material 3, functional local state |
| Firebase Auth (Google/email/phone) | Real `firebase_auth` calls — needs your Firebase project |
| AI Center | Real HTTP call — needs `AI_BASE_URL` pointed at JARK AI |
| Notebook | In-memory notes — swap for Hive + Firestore sync (packages already in `pubspec.yaml`) |
| Classroom, Exam Papers, Textbooks, Videos, Dictionary | Mock/local data — replace with Firestore queries or your existing content APIs |
| Admin panel | UI shell only — gate behind a Firestore role/custom-claim check before shipping |
| Offline caching, push notifications, Crashlytics, Remote Config, App Check | Not implemented — packages are in `pubspec.yaml`; wire up once Firebase project exists |

## Structure

```
lib/
  main.dart                 # entry point, splash->onboarding->auth->home flow
  theme/app_theme.dart       # brand colors + Material 3 ThemeData
  routes/app_router.dart      # named routes for feature screens
  services/                  # auth_service.dart, ai_service.dart
  widgets/                   # glass_card.dart, root_shell.dart (bottom nav)
  screens/                   # one folder per feature area
```

## Suggested next milestones

1. Run `flutterfire configure`, confirm Google Sign-In works end-to-end.
2. Point `AI_BASE_URL` at JARK AI and confirm the chat round-trips.
3. Replace mock lists (exam papers, textbooks, classroom data) with real
   Firestore collections — start with one screen, expand the pattern to the rest.
4. Add app icons/splash via `flutter_launcher_icons` and `flutter_native_splash`
   (both already dev dependencies) using your existing logo assets.
5. Set up Firebase Cloud Messaging for the Notifications feature.
