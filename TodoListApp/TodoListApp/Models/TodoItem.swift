import Foundation

/// A single todo entry.
///
/// `Codable` so the store can persist the list with `UserDefaults`,
/// `Identifiable` so SwiftUI's `List` can diff rows, and `Equatable`
/// to keep the unit tests simple.
struct TodoItem: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
