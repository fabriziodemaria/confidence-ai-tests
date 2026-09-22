import Foundation
import Observation

/// The single source of truth for the todo list.
///
/// `TodoStore` owns the array of ``Todo`` values and exposes small, intention
/// revealing methods for the behaviour the UI needs: adding a non-empty item,
/// toggling completion and deleting. It is annotated with `@Observable` so
/// SwiftUI views update automatically, while the logic itself is pure
/// Foundation and therefore fully unit-testable on any platform.
@Observable
public final class TodoStore {
    /// The current todo items, most-recently-added last.
    public private(set) var todos: [Todo]

    public init(todos: [Todo] = []) {
        self.todos = todos
    }

    /// Adds a new todo from raw user input.
    ///
    /// The title is trimmed of surrounding whitespace and newlines. Blank
    /// input is rejected so the list never contains empty rows.
    ///
    /// - Parameter title: The raw text entered by the user.
    /// - Returns: The created ``Todo`` on success, or `nil` when the trimmed
    ///   title is empty.
    @discardableResult
    public func addTodo(title: String) -> Todo? {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        let todo = Todo(title: trimmed)
        todos.append(todo)
        return todo
    }

    /// Flips the completion state of the item with the given identifier.
    ///
    /// Unknown identifiers are ignored.
    public func toggleCompletion(of id: Todo.ID) {
        guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
        todos[index].isCompleted.toggle()
    }

    /// Removes the item with the given identifier, if present.
    public func delete(id: Todo.ID) {
        todos.removeAll { $0.id == id }
    }

    /// Removes the items at the supplied offsets.
    ///
    /// This mirrors the signature SwiftUI's `List.onDelete` provides. The
    /// removal is implemented with only the standard library so `TodoCore`
    /// stays free of any UI-framework dependency.
    public func delete(atOffsets offsets: IndexSet) {
        for index in offsets.sorted(by: >) where todos.indices.contains(index) {
            todos.remove(at: index)
        }
    }
}
