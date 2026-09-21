import XCTest
@testable import TodoApp

final class TodoStoreTests: XCTestCase {

    // MARK: - Adding

    func testNewStoreIsEmpty() {
        let store = TodoStore()
        XCTAssertTrue(store.isEmpty)
        XCTAssertEqual(store.items.count, 0)
    }

    func testAddTodoAppendsItem() {
        let store = TodoStore()
        let added = store.addTodo(title: "Buy milk")

        XCTAssertNotNil(added)
        XCTAssertEqual(store.items.count, 1)
        XCTAssertEqual(store.items.first?.title, "Buy milk")
        XCTAssertEqual(store.items.first?.isCompleted, false)
        XCTAssertFalse(store.isEmpty)
    }

    func testAddTodoTrimsWhitespace() {
        let store = TodoStore()
        store.addTodo(title: "   Walk the dog\n")

        XCTAssertEqual(store.items.first?.title, "Walk the dog")
    }

    func testAddEmptyTitleIsIgnored() {
        let store = TodoStore()

        XCTAssertNil(store.addTodo(title: ""))
        XCTAssertNil(store.addTodo(title: "   \n\t "))
        XCTAssertTrue(store.isEmpty)
    }

    func testAddPreservesInsertionOrder() {
        let store = TodoStore()
        store.addTodo(title: "First")
        store.addTodo(title: "Second")
        store.addTodo(title: "Third")

        XCTAssertEqual(store.items.map(\.title), ["First", "Second", "Third"])
    }

    // MARK: - Toggling

    func testToggleCompletionFlipsState() {
        let store = TodoStore()
        let item = store.addTodo(title: "Task")!

        store.toggleCompletion(for: item)
        XCTAssertEqual(store.items.first?.isCompleted, true)

        store.toggleCompletion(for: item)
        XCTAssertEqual(store.items.first?.isCompleted, false)
    }

    func testToggleUnknownItemDoesNothing() {
        let store = TodoStore(items: [TodoItem(title: "Existing")])
        let stranger = TodoItem(title: "Not in store")

        store.toggleCompletion(for: stranger)

        XCTAssertEqual(store.items.count, 1)
        XCTAssertEqual(store.items.first?.isCompleted, false)
    }

    // MARK: - Deleting

    func testDeleteItemRemovesIt() {
        let store = TodoStore()
        let first = store.addTodo(title: "First")!
        store.addTodo(title: "Second")

        store.delete(first)

        XCTAssertEqual(store.items.map(\.title), ["Second"])
    }

    func testDeleteAtOffsetsRemovesCorrectItems() {
        let store = TodoStore()
        store.addTodo(title: "A")
        store.addTodo(title: "B")
        store.addTodo(title: "C")

        store.delete(at: IndexSet([0, 2]))

        XCTAssertEqual(store.items.map(\.title), ["B"])
    }

    func testDeleteAtOutOfRangeOffsetIsIgnored() {
        let store = TodoStore()
        store.addTodo(title: "Only")

        store.delete(at: IndexSet([5]))

        XCTAssertEqual(store.items.map(\.title), ["Only"])
    }

    func testDeleteUnknownItemDoesNothing() {
        let store = TodoStore(items: [TodoItem(title: "Keep me")])

        store.delete(TodoItem(title: "Ghost"))

        XCTAssertEqual(store.items.count, 1)
    }
}
