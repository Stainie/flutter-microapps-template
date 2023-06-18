# flutter-microapps-template

### Plugins

Plugins can be accessed by any other package in the monorepo. They are located in the `plugins` folder.

-   Plugins should have only one responsibility and should be as small as possible.
-   Plugins should be tested and documented.
-   Plugins should be abstracted and easy to change
-   Plugins should not contain any business logic and should be usable in other projects.

### Microapps

Microapps are projects that contain business logic and <b>should not contain any pages only components</b>. They are located in the `microapps` folder.

### App

The app is the main project that contains the pages and the routing. It should be created in the projects inheriting this template

## Setup Flutter

### Install Flutter

#### Normal

Follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install).

#### FVM

Follow the instructions on the [FVM website](https://fvm.app/docs/getting_started/installation).

### Install Android Studio

Follow the instructions on the [Android Studio website](https://developer.android.com/studio/install).

### Install Xcode

Follow the instructions on the [Xcode website](https://developer.apple.com/xcode/).

### Install VSCode

Follow the instructions on the [VSCode website](https://code.visualstudio.com/download).

### Install Flutter extension

Install the [Flutter extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) for VSCode.

### Install Melos (Monorepo Package installer)

Install the [Melos](https://pub.dev/packages/melos) package globally.


## Install Packages

`flutter pub global run melos bootstrap`  # Install all packages in the monorepo

## Analyze

`melos run analyze`  # Analyze all packages in the monorepo

## Test

`melos run test`  # Test all packages in the monorepo

## Generate (Watch build_runner)

`melos generate:watch`  # Watch and run build_runner on all packages in the monorepo

## Run

Start project with vscode debugger selecting the environment.
`launch.json` is already configured.

## Update local translations from LingoHub

`melos pull_translations` # Add new cloud translations from LingoHub to `local_en.json`

## Debug Proxy

### Install

Install proxyman from the [Proxyman website](https://proxyman.io/).

### Setup emulator certificate (Android, iOS)

Follow the instructions on the [Proxyman website](https://proxyman.io/docs/advanced-usage/certificate/).


### Git/branching rules and strategy

-   `main` branch should be the default branch. Every new developer will by default clone from it, and use it as a base for merging

-   Following trunk based development, it should be the source of truth, and always be stable

-   By default, we will use Squash and merge merging strategy, in order to keep the history clean and linear. Merge commit strategy should be used only in specific scenarios, where every commit could break the functionality, so it is easy to git blame and get on the right track. Example for this is making bug fixes for a release, where every commit is for fixing/improving one functionality

-   One developer should be enough for sanity check of the PR. Automation should take care of everything else

-   Branch naming should have one of the prefixes: `refactor/`, `bug/`, `feature/`, `test/`, `config/` or `release/`, followed by the ticket number and explanation, or the release number. Examples are

    -   refactor/PBL-1_main-page-redesign 

    -   release/v1.0.0

-   After the PR has been merged, the feature branch should be deleted remotely

-   PRs should be opened as Draft, until they are ready for review

-   Every developer should have the responsibility of keeping their PRs without conflicts towards main

-   We will create following labels, in order to keep the ‘Pull requests’ section clean and visible: `Ready for E2E`, `Merge`, `Blocked`. By default, PR won’t have a label

-   As soon as product team decides to go for a release, we branch out of main and create a release branch that further goes through the CD process
