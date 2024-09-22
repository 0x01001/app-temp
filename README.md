# Flutter Riverpod - MVVM Architecture

Flutter project using MVVM architecture and riverpod pattern.

## Features

1. Architecture: MVVM Architecture
1. State management: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
1. Navigation: [auto_route](https://pub.dev/packages/auto_route)
1. DI: [get_it](https://pub.dev/packages/get_it), [injectable](https://pub.dev/packages/injectable)
1. REST API: [dio](https://pub.dev/packages/dio)
1. GraphQL: [artemis](https://pub.dev/packages/artemis), [graphql_flutter](https://pub.dev/packages/graphql_flutter)
1. Database: [objectbox](https://pub.dev/packages/objectbox)
1. Shared Preferences: [encrypted_shared_preferences](https://pub.dev/packages/encrypted_shared_preferences)
1. Data class: [freezed](https://pub.dev/packages/freezed)
1. Lint: [dart_code_metrics](https://pub.dev/packages/dart_code_metrics), [flutter_lints](https://pub.dev/packages/flutter_lints)
1. CI/CD: Github Actions
1. Utils: [rxdart](https://pub.dev/packages/rxdart), [dartx](https://pub.dev/packages/dartx), [async](https://pub.dev/packages/async)
1. Assets generator: [flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner), [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
1. Shimmer loading effect
1. Load more
1. Retry when error
1. Nested navigation
1. Dark mode
1. Change App Language

## Getting Started

### Requirements

- Dart: 3.4.0
- Flutter SDK: 3.22.0
- CocoaPods: 1.15.2

### Install

- Export paths: Add to `.zshrc` or `.bashrc` file

```
export PATH="$PATH:<path to flutter>/flutter/bin"
export PATH="$PATH:<path to flutter>/flutter/bin/cache/dart-sdk/bin"
export PATH="$PATH:~/.pub-cache/bin"
```

- Save file `.zshrc`
- Run `source ~/.zshrc`

### Config and run app

- cd to root folder of project
- Run `make init`
- Run app via VSCode or using command `make run_dev`
- Enjoy!

### Secrets configuration

- Define secret constants in [env.dart](lib/shared/utils/env.dart) and JSON files in folder [config](config) including:
  - config/dev.json
  - config/stg.json
  - config/prod.json

For example:

```
{
  "FLAVOR": "dev",
  "APP_BASIC_AUTH_NAME": "admin",
  "APP_BASIC_AUTH_PASSWORD": "admin"
}
```

### Setup Fastlane (optional)

- Create files `.env.default` in [ios/fastlane](ios/fastlane) and [android/fastlane](android/fastlane)
- Paste this into files `.env.default`

```
SLACK_URL = "https://hooks.slack.com/services/xxx"
APP_CENTER_TOKEN = "xxx"
APPLE_TOKEN = "xxx"
FIREBASE_TOKEN = "1//xxx"
```

- Update config values in [ios/Fastfile](ios/fastlane/Fastfile) and [android/Fastfile](android/fastlane/Fastfile)

## Upgrade Flutter

- Update Flutter version in:
  - [README.md](#requirements)
  - [codemagic.yaml](codemagic.yaml)
  - [ci.yaml](.github/workflows/ci.yaml)
  - [cd_dev.yaml](.github/workflows/cd_dev.yaml)
  - [cd_stg.yaml](.github/workflows/cd_stg.yaml)
  - [cd_prod.yaml](.github/workflows/cd_prod.yaml)

## License

MIT
