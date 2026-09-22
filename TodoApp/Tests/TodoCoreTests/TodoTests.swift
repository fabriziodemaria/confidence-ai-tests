import XCTest
@testable import TodoCore

final class TodoTests: XCTestCase {

    func testDefaultInitialiserIsIncompleteWithUniqueIdentity() {
        let a = Todo(title: "A")
        let b = Todo(title: "A")

        XCTAssertFalse(a.isCompleted)
        XCTAssertNotEqual(a.id, b.id)
    }

    func testEquatableComparesAllStoredProperties() {
        let id = UUID()
        let base = Todo(id: id, title: "Task", isCompleted: false)

        XCTAssertEqual(base, Todo(id: id, title: "Task", isCompleted: false))
        XCTAssertNotEqual(base, Todo(id: id, title: "Task", isCompleted: true))
        XCTAssertNotEqual(base, Todo(id: id, title: "Other", isCompleted: false))
    }

    func testCodableRoundTripPreservesValues() throws {
        let original = Todo(title: "Round trip", isCompleted: true)

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Todo.self, from: data)

        XCTAssertEqual(original, decoded)
    }
}
