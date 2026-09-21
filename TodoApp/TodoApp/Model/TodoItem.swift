import Foundation

/// A single todo entry.
///
/// The model is intentionally tiny and dependency-free (Foundation only) so it
/// can be unit tested on any platform, including from the command line.
struct TodoItem: Identifiable, Equatable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
