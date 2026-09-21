import XCTest
@testable import TodoListApp

final class TodoStoreTests: XCTestCase {
    private var suiteName: String!
    private var defaults: UserDefaults!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Isolate each test in its own UserDefaults suite so runs don't leak state.
        suiteName = "TodoStoreTests-\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)
    }

    override func tearDownWithError() throws {
        defaults.removePersistentDomain(forName: suiteName)
        defaults = nil
        suiteName = nil
        try super.tearDownWithError()
    }

    private func makeStore() -> TodoStore {
        TodoStore(defaults: defaults, storageKey: "todos.test")
    }

    func testStartsEmpty() {
        let store = makeStore()
        XCTAssertTrue(store.todos.isEmpty)
    }

    func testAddTrimsAndAppends() {
        let store = makeStore()
        let added = store.add(title: "  Buy milk  ")
        XCTAssertTrue(added)
        XCTAssertEqual(store.todos.count, 1)
        XCTAssertEqual(store.todos.first?.title, "Buy milk")
        XCTAssertEqual(store.todos.first?.isCompleted, false)
    }

    func testAddIgnoresBlankTitles() {
        let store = makeStore()
        XCTAssertFalse(store.add(title: ""))
        XCTAssertFalse(store.add(title: "   "))
        XCTAssertFalse(store.add(title: "\n\t"))
        XCTAssertTrue(store.todos.isEmpty)
    }

    func testToggleFlipsCompletion() {
        let store = makeStore()
        store.add(title: "Walk the dog")
        let item = try! XCTUnwrap(store.todos.first)

        store.toggle(item)
        XCTAssertEqual(store.todos.first?.isCompleted, true)

        store.toggle(item)
        XCTAssertEqual(store.todos.first?.isCompleted, false)
    }

    func testDeleteByItemRemovesMatch() {
        let store = makeStore()
        store.add(title: "First")
        store.add(title: "Second")
        let first = try! XCTUnwrap(store.todos.first)

        store.delete(first)
        XCTAssertEqual(store.todos.count, 1)
        XCTAssertEqual(store.todos.first?.title, "Second")
    }

    func testDeleteAtOffsetsRemovesRows() {
        let store = makeStore()
        store.add(title: "First")
        store.add(title: "Second")
        store.add(title: "Third")

        store.delete(at: IndexSet(integer: 1))
        XCTAssertEqual(store.todos.map(\.title), ["First", "Third"])
    }

    func testPersistenceAcrossStoreInstances() {
        let store = makeStore()
        store.add(title: "Persisted")
        store.toggle(try! XCTUnwrap(store.todos.first))

        // A fresh store reading the same suite/key should restore the data.
        let reloaded = makeStore()
        XCTAssertEqual(reloaded.todos.count, 1)
        XCTAssertEqual(reloaded.todos.first?.title, "Persisted")
        XCTAssertEqual(reloaded.todos.first?.isCompleted, true)
    }
}
