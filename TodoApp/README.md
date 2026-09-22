# TodoApp

A small, native SwiftUI todo-list app plus a platform-independent `TodoCore`
library that holds the model and store logic. The split keeps the behaviour
easy to review and unit-testable on any platform (including Linux CI), while the
UI stays a thin SwiftUI layer.

## Features

- Displays the list of todos.
- Add a new todo (blank / whitespace-only input is rejected).
- Tap a row to mark it complete / incomplete (with a strikethrough style).
- Swipe to delete a todo.

## Project layout

```
TodoApp/
├── Package.swift
├── Sources/
│   ├── TodoCore/            # Pure model + store logic (no UI framework)
│   │   ├── Todo.swift
│   │   └── TodoStore.swift
│   └── TodoListApp/         # SwiftUI application (Apple platforms only)
│       ├── TodoListApp.swift
│       └── TodoListView.swift
└── Tests/
    └── TodoCoreTests/       # Unit tests for the model + store
        ├── TodoStoreTests.swift
        └── TodoTests.swift
```

`TodoStore` is annotated with `@Observable` (Observation framework), so SwiftUI
views update automatically while the logic itself remains plain Foundation.

## Prerequisites

- **To run the app (GUI):** macOS with **Xcode 15 or later** (targets
  **iOS 17+ / macOS 14+**, required by SwiftUI's `@Observable` and
  `ContentUnavailableView`).
- **To build/test the `TodoCore` logic only:** a **Swift 6.0 toolchain** on
  macOS or Linux (no Apple SDK required).

## Build & run the app

Open the package in Xcode and run it:

```bash
cd TodoApp
open Package.swift          # opens the package in Xcode
```

In Xcode, select the **TodoListApp** scheme, choose a destination (an iOS
Simulator or **My Mac**), and press **Run** (⌘R).

## Build & test the core logic (macOS or Linux)

From the `TodoApp` directory:

```bash
cd TodoApp
swift build      # builds TodoCore (and the app target where SwiftUI exists)
swift test       # runs the TodoCore unit tests
```

On a platform without SwiftUI (e.g. Linux), `swift build` still succeeds:
`TodoCore` compiles normally and the executable target uses a small fallback
entry point that prints a message explaining the app requires an Apple platform.
