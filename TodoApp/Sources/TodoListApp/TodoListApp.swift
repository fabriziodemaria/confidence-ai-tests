#if canImport(SwiftUI)
import SwiftUI
import TodoCore

/// Application entry point.
///
/// A single ``TodoStore`` is created here and shared with the view hierarchy so
/// there is exactly one source of truth for the list.
@main
struct TodoListApp: App {
    @State private var store = TodoStore()

    var body: some Scene {
        WindowGroup {
            TodoListView(store: store)
        }
    }
}
#else

/// Fallback entry point for non-Apple platforms (for example Linux CI), where
/// SwiftUI is not available. The reusable logic lives in the `TodoCore`
/// library, which builds and is tested on every platform.
@main
struct TodoListApp {
    static func main() {
        print("TodoListApp is a SwiftUI application and must be run on an Apple platform (iOS 17+/macOS 14+).")
        print("The reusable TodoCore logic is available and tested on this platform via `swift test`.")
    }
}
#endif
