# Dash
### Creators
Žiga Povhe - 63190236
Lan Pavletič - 63210530

Aplikacije za klepet

Najprej nas aplikacija prosi, da se vano prijavimo. Če računa še nimamo ga lahko ustvarimo, če smo pozabili geslo lahko navedemo naš email naslov, na katerega bomo prejeli možnost izbire novega gesla. 

Ko smo prijavljeni aplikacijo je prva stran "dashboard", kjer imamo vse naše pogovor. Pogovore lahko brišemo, beremo ali ustvarjamo. Ustvarimo ga tako, da v desnem kotu kliknemo znak +, ki pa nas privede na ekran, kjer lahko vidimo vse uporabnike, in si izberemo s kom se želimo pogovarjati.

Na Dashbordu, lahko kliknemo na posamezne pogovore in s tem odpremo celoten pogovor, kjer vidmo vsa poslana sporočila in jih sami tudi pošiljamo.

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




