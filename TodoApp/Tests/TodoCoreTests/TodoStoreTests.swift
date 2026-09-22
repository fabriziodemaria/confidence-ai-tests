import XCTest
@testable import TodoCore

final class TodoStoreTests: XCTestCase {

    func testStoreStartsEmptyByDefault() {
        let store = TodoStore()
        XCTAssertTrue(store.todos.isEmpty)
    }

    func testAddTodoAppendsTrimmedTitle() {
        let store = TodoStore()

        let created = store.addTodo(title: "  Buy milk  ")

        XCTAssertNotNil(created)
        XCTAssertEqual(store.todos.count, 1)
        XCTAssertEqual(store.todos.first?.title, "Buy milk")
        XCTAssertEqual(store.todos.first?.isCompleted, false)
    }

    func testAddTodoRejectsEmptyTitle() {
        let store = TodoStore()

        XCTAssertNil(store.addTodo(title: ""))
        XCTAssertTrue(store.todos.isEmpty)
    }

    func testAddTodoRejectsWhitespaceOnlyTitle() {
        let store = TodoStore()

        XCTAssertNil(store.addTodo(title: "   \n\t  "))
        XCTAssertTrue(store.todos.isEmpty)
    }

    func testAddTodoPreservesInsertionOrder() {
        let store = TodoStore()

        store.addTodo(title: "First")
        store.addTodo(title: "Second")
        store.addTodo(title: "Third")

        XCTAssertEqual(store.todos.map(\.title), ["First", "Second", "Third"])
    }

    func testToggleCompletionFlipsState() {
        let store = TodoStore()
        let todo = store.addTodo(title: "Task")!

        store.toggleCompletion(of: todo.id)
        XCTAssertEqual(store.todos.first?.isCompleted, true)

        store.toggleCompletion(of: todo.id)
        XCTAssertEqual(store.todos.first?.isCompleted, false)
    }

    func testToggleCompletionIgnoresUnknownIdentifier() {
        let store = TodoStore()
        store.addTodo(title: "Task")

        store.toggleCompletion(of: UUID())

        XCTAssertEqual(store.todos.first?.isCompleted, false)
    }

    func testDeleteByIdentifierRemovesMatchingItem() {
        let store = TodoStore()
        let first = store.addTodo(title: "Keep")!
        let second = store.addTodo(title: "Remove")!

        store.delete(id: second.id)

        XCTAssertEqual(store.todos.map(\.id), [first.id])
    }

    func testDeleteByIdentifierIgnoresUnknownIdentifier() {
        let store = TodoStore()
        store.addTodo(title: "Keep")

        store.delete(id: UUID())

        XCTAssertEqual(store.todos.count, 1)
    }

    func testDeleteAtOffsetsRemovesSelectedRows() {
        let store = TodoStore()
        store.addTodo(title: "A")
        store.addTodo(title: "B")
        store.addTodo(title: "C")

        store.delete(atOffsets: IndexSet(integer: 1))

        XCTAssertEqual(store.todos.map(\.title), ["A", "C"])
    }
}
