# Splittr

Splittr is a Flutter-based multi-platform application utilizing clean architecture, BLoC for state management, Injectable for dependency injection, and Hive for offline-first caching.

---

## 🛠️ Environment Configuration & Secrets Management

We use the [envied](https://pub.dev/packages/envied) package to manage compile-time environment variables with full **obfuscated encryption** for production keys.

### 🔑 Setup Env Files

Real environment files are gitignored to prevent leaks. To set up your local environment:
1. Copy the example templates in the project root:
   ```bash
   cp .env.dev.example .env.dev
   cp .env.prod.example .env.prod
   ```
2. Populate the `.env.dev` and `.env.prod` files with your actual credentials.

### 🧬 Structure (`MultiEnv`)

Environment variables are unified within a single `MultiEnv` class using stacked `@Envied` annotations to cleanly separate development and production profiles:

```dart
// lib/core/app_config/env/multi_env.dart
@Envied(path: '.env.dev', name: 'DebugEnv', obfuscate: true)
@Envied(path: '.env.prod', name: 'ProductionEnv', obfuscate: true)
abstract class MultiEnv {
  static late final MultiEnv instance;

  static void init(Env env) {
    instance = switch (env) {
      Env.dev => _DebugEnv(),
      Env.prod => _ProductionEnv(),
    };
  }
  
  // Define environment-specific fields below
  abstract final String apiBaseUrl;
  abstract final String vercelBypassKey;
}
```

### ⚙️ Code Generation

Once you update your `.env.dev` or `.env.prod` files, run the build runner to compile the environments:
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🔥 Firebase Setup

Ensure you install the [Firebase CLI](https://firebase.google.com/docs/cli) and [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup?platform=android) before running these commands:

### Development Environment
```bash
flutterfire configure --platforms=android --android-package-name=com.example.splittr.dev --android-out=android/app/src/dev/google-services.json --out=lib/core/firebase/firebase_options_dev.dart
```

### Production Environment
```bash
flutterfire configure --platforms=android --android-package-name=com.example.splittr --android-out=android/app/src/prod/google-services.json --out=lib/core/firebase/firebase_options_prod.dart
```

---

## 🚀 Running the App

The app supports target-specific entry points (`lib/main_dev.dart` and `lib/main_prod.dart`) along with Flutter build flavors.

### VS Code
Use the predefined configurations in `.vscode/launch.json`:
* Select **Dev** to run development.
* Select **Prod** to run production.

### Android Studio
Ensure you have configured run/debug targets:
1. Go to **Edit Configurations**.
2. Add a new Flutter run configuration.
3. Name it **DEV** or **PROD**.
4. Set the Dart entrypoint to `lib/main_dev.dart` (DEV) or `lib/main_prod.dart` (PROD).
5. Set the Build Flavor section to `dev` (DEV) or `prod` (PROD).

---

## 🧱 Mason CLI (Code Generation)

We use Mason to generate uniform pages and components.

### Initial Setup
1. Activate Mason CLI globally:
   ```bash
   dart pub global activate mason_cli
   ```
2. Navigate to the mason directory and install the brick registry:
   ```bash
   cd mason
   mason get
   ```

### Command Usage
* **Create a Page**:
  ```bash
  mason make feature_page -o ../lib/features/ --on-conflict overwrite --feature_name <yourFeatureName>
  ```   
* **Create a Component**:
  ```bash
  mason make feature_component -o ../lib/features/ --on-conflict overwrite --feature_name <yourFeatureName>
  ```

---

## 🧹 Maintenance Commands

Use the following commands to clean caches or reset dependencies:

```bash
# Clean pub cache
fvm flutter pub cache clean
fvm flutter pub cache repair

# Clean build artifacts
fvm flutter clean
```
