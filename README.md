# Dash App README

App for Realtime chatting

### Requirements

Make sure you have met the following requirements:
* You have latest version of Flutter installed on your machine, if not, you can find it [here](https://flutter.dev).
* You have your IDE of choice with Flutter/Dart plugins (Android Studio / IntelliJ, Visual Studio Code).
* A connected mobile device
    * An appropriate emulator works aswell - [Android][android-emulator-guide]

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Preparation

To build or run the application, we must first prepare the project. We do this by running the following commands:

#### Android

```sh
> cd dash
> flutter clean
> flutter pub get
> flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### iOS

```sh
> cd dash
> flutter clean
> flutter pub get
> flutter packages pub run build_runner build --delete-conflicting-outputs
> cd ios
> rm -rf Pods/ Podfile.lock
> pod install
```

Also, ensure `firebase_options.dart` file is located in **dash/lib/** folder.
If not, follow **Step 1** and **Step 2** here: [Adding Firebase to Flutter](https://firebase.google.com/docs/flutter/setup?platform=ios)

### Running the app

Commands for running a flutter app are the same for Android and iOS platform.

```sh
> flutter run //Running the app on connected devices
```

### Building an Android app (Release APK)

```sh
> flutter build apk //Build apk file
```

### Building an iOS app

```sh
> flutter build ipa //Build ipa file
```




