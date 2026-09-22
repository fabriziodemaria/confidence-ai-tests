import Foundation

/// A single todo item.
///
/// `Todo` is a plain value type so it is trivial to test and to move across
/// platform boundaries. Identity is provided by a stable `UUID` so SwiftUI can
/// diff lists efficiently and so items keep their identity when toggled.
public struct Todo: Identifiable, Equatable, Codable, Sendable {
    public let id: UUID
    public var title: String
    public var isCompleted: Bool

    public init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
