import Foundation

/// Owns the list of todos and persists it locally.
///
/// Persistence uses `Codable` + `UserDefaults`, which keeps the app free of
/// third-party dependencies. The `UserDefaults` instance and storage key are
/// injectable so tests can run against an isolated suite without touching the
/// user's real data.
final class TodoStore: ObservableObject {
    @Published private(set) var todos: [TodoItem] = []

    private let defaults: UserDefaults
    private let storageKey: String

    init(defaults: UserDefaults = .standard, storageKey: String = "todos.v1") {
        self.defaults = defaults
        self.storageKey = storageKey
        load()
    }

    /// Adds a todo, ignoring blank or whitespace-only titles.
    /// - Returns: `true` when an item was added, `false` when the title was blank.
    @discardableResult
    func add(title: String) -> Bool {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        todos.append(TodoItem(title: trimmed))
        save()
        return true
    }

    /// Flips the completion state of the matching item.
    func toggle(_ item: TodoItem) {
        guard let index = todos.firstIndex(where: { $0.id == item.id }) else { return }
        todos[index].isCompleted.toggle()
        save()
    }

    /// Removes the matching item.
    func delete(_ item: TodoItem) {
        todos.removeAll { $0.id == item.id }
        save()
    }

    /// Removes items at the given offsets (used by `List`'s swipe-to-delete).
    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        save()
    }

    private func load() {
        guard
            let data = defaults.data(forKey: storageKey),
            let decoded = try? JSONDecoder().decode([TodoItem].self, from: data)
        else {
            todos = []
            return
        }
        todos = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(todos) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
