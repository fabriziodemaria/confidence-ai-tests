import Foundation
import Observation

/// Observable, in-memory store that owns the list of todos and the small amount
/// of business logic around it (adding, toggling and deleting).
///
/// It uses the `Observation` framework (`@Observable`) so SwiftUI views update
/// automatically, while keeping the type free of any UI dependency. That makes
/// the behaviour straightforward to cover with focused unit tests.
@Observable
final class TodoStore {
    /// The current todos, most-recently-added last. Read-only from the outside;
    /// mutations go through the intent methods below.
    private(set) var items: [TodoItem]

    init(items: [TodoItem] = []) {
        self.items = items
    }

    /// Whether there are no todos. Handy for driving an empty state.
    var isEmpty: Bool { items.isEmpty }

    /// Adds a new todo.
    ///
    /// The title is trimmed of surrounding whitespace/newlines and an empty
    /// title is ignored, so the UI can call this unconditionally.
    /// - Parameter title: The user-entered text.
    /// - Returns: The created item, or `nil` when the title was blank.
    @discardableResult
    func addTodo(title: String) -> TodoItem? {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        let item = TodoItem(title: trimmed)
        items.append(item)
        return item
    }

    /// Flips the completion state of the given todo, if it still exists.
    func toggleCompletion(for item: TodoItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isCompleted.toggle()
    }

    /// Removes the given todo, if present.
    func delete(_ item: TodoItem) {
        items.removeAll { $0.id == item.id }
    }

    /// Removes the todos at the supplied offsets.
    ///
    /// Mirrors the shape SwiftUI's `List.onDelete` provides while staying free
    /// of any SwiftUI/UIKit dependency so it can be tested anywhere.
    func delete(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) where items.indices.contains(index) {
            items.remove(at: index)
        }
    }
}
