# TodoListApp

A small, self-contained iOS todo-list app built with SwiftUI. It has no
third-party dependencies and persists your todos locally using `Codable` +
`UserDefaults`.

## Requirements

- Xcode 15 or newer
- iOS 17.0+ (simulator or device)

## Open & run

1. Open the project:
   ```sh
   open TodoListApp/TodoListApp.xcodeproj
   ```
   (or in Xcode: **File ▸ Open…** and select `TodoListApp/TodoListApp.xcodeproj`)
2. In the Xcode toolbar, select the **TodoListApp** scheme and an iOS Simulator
   (for example *iPhone 15*).
3. Press **Run** (`⌘R`).

## Run the tests

- In Xcode: **Product ▸ Test** (`⌘U`), or
- From the command line (macOS with Xcode installed):
  ```sh
  cd TodoListApp
  xcodebuild test \
    -project TodoListApp.xcodeproj \
    -scheme TodoListApp \
    -destination 'platform=iOS Simulator,name=iPhone 15'
  ```

## Supported behavior

- **Add**: type a title and tap the **+** button or press return. Blank or
  whitespace-only titles are ignored, and titles are trimmed.
- **Complete / incomplete**: tap the circle on a row to toggle its state; the
  title is struck through when complete.
- **Delete**: swipe a row left (swipe-to-delete).
- **Empty state**: a friendly placeholder is shown when there are no todos.
- **Persistence**: todos are saved locally and restored on the next launch.

## Project layout

```
TodoListApp/
├── TodoListApp.xcodeproj/          # Xcode project, shared scheme, workspace
├── TodoListApp/
│   ├── TodoListAppApp.swift        # App entry point
│   ├── ContentView.swift           # List UI, add bar, empty state
│   ├── Models/TodoItem.swift       # Codable/Identifiable model
│   ├── Stores/TodoStore.swift      # ObservableObject store (Codable + UserDefaults)
│   ├── Views/TodoRowView.swift     # Single row (toggle + title)
│   └── Assets.xcassets             # App icon / accent color
└── TodoListAppTests/
    └── TodoStoreTests.swift        # Unit tests for add/toggle/delete/persistence
```

## Notes

- `TodoStore` accepts an injectable `UserDefaults` suite and storage key, which
  keeps the unit tests isolated from the app's real data.
