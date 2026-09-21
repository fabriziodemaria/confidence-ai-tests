# TodoApp

A minimal, native **SwiftUI** todo-list app for **iOS**. It is intentionally
small and dependency-free so it is easy to read, run, and review.

## Features

- 📋 **See your todos** in a plain list.
- ➕ **Add** a todo (blank / whitespace-only entries are ignored).
- ✅ **Toggle completion** by tapping a row (completed items are struck through).
- 🗑️ **Delete** a todo with swipe-to-delete or the **Edit** button.
- 🫥 **Clear empty state** shown when there are no todos.
- ♿️ Accessible: rows expose combined labels, values, hints and button traits;
  controls have explicit accessibility labels; text respects Dynamic Type.

No backend, no networking, and no third-party dependencies. Todos live in memory
for the lifetime of the app run.

## Requirements

- **Xcode 15 or later** (uses the iOS 17 `Observation` framework and
  `ContentUnavailableView`).
- **iOS 17.0+** deployment target (runs in the iOS Simulator; no device or
  signing needed).

## Open, build and run (Xcode)

1. Open the project:
   ```sh
   open TodoApp/TodoApp.xcodeproj
   ```
   (or `File ▸ Open…` in Xcode and select `TodoApp/TodoApp.xcodeproj`).
2. In the scheme/destination selector at the top, pick the **TodoApp** scheme
   and any iOS Simulator (e.g. *iPhone 15*).
3. Press **Run** (`⌘R`).

## Run the tests

### In Xcode

- Select the **TodoApp** scheme and an iOS Simulator, then press
  **Product ▸ Test** (`⌘U`).

### From the command line (macOS)

```sh
cd TodoApp
xcodebuild test \
  -project TodoApp.xcodeproj \
  -scheme TodoApp \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Testing the model without Xcode (macOS or Linux)

The `TodoItem` / `TodoStore` model is pure Foundation and has **no** UI
dependency, so it can be built and tested with the Swift Package Manager using
the included `Package.swift`. The SwiftPM library target is named `TodoApp`, so
the exact same test file (`TodoAppTests/TodoStoreTests.swift`) is used by both
the Xcode test target and SwiftPM.

```sh
cd TodoApp
swift test
```

## Project structure

```
TodoApp/
├── Package.swift                 # SwiftPM harness to build/test the model (macOS/Linux)
├── TodoApp.xcodeproj/            # Xcode project (primary way to build & run the app)
├── TodoApp/
│   ├── TodoAppApp.swift          # @main App entry point (SwiftUI)
│   ├── Views/
│   │   └── ContentView.swift     # The single screen: add row, list, empty state
│   ├── Model/
│   │   ├── TodoItem.swift        # Value type for a single todo (Foundation only)
│   │   └── TodoStore.swift       # Observable store: add / toggle / delete logic
│   ├── Assets.xcassets/          # App icon + accent color
│   └── Preview Content/          # SwiftUI preview assets
└── TodoAppTests/
    └── TodoStoreTests.swift      # Focused unit tests for the store behavior
```

## Design notes / decisions

- **Platform:** the repository had no existing Apple project, so per the task an
  **iOS SwiftUI** app was chosen.
- **State management:** `TodoStore` is an `@Observable` class (Observation
  framework, iOS 17+). Business logic (trim/reject empty input, toggle, delete)
  lives here and is UI-agnostic, which keeps it small and unit-testable.
- **Model isolation:** `TodoItem` and `TodoStore` import only `Foundation` /
  `Observation` (no SwiftUI), so the same sources compile and test under SwiftPM
  on non-Apple platforms too.
- **Persistence:** intentionally omitted (in-memory only) to keep the app
  minimal and free of extra dependencies, matching the task constraints.

## Validation status

- ✅ **Model + unit tests:** built and run in this environment with the open
  Swift 6.4 toolchain via `swift test` (Linux). All **11** tests pass.
- ⚠️ **App UI (SwiftUI) & full Xcode build:** could **not** be compiled/run in
  this environment because it requires macOS + Xcode + the iOS SDK, which are
  unavailable on Linux. The Xcode project, scheme and asset catalogs are
  provided and the `project.pbxproj` was verified to parse with a pbxproj
  parser, but building/running the app should be done on macOS with Xcode 15+.
