#if canImport(SwiftUI)
import SwiftUI
import TodoCore

/// The main screen: a list of todos with add, toggle and delete affordances.
struct TodoListView: View {
    let store: TodoStore
    @State private var newTitle: String = ""
    @FocusState private var isInputFocused: Bool

    private var trimmedTitle: String {
        newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                inputRow

                if store.todos.isEmpty {
                    emptyState
                } else {
                    todoList
                }
            }
            .navigationTitle("Todos")
        }
    }

    private var inputRow: some View {
        HStack(spacing: 12) {
            TextField("Add a new todo", text: $newTitle)
                .textFieldStyle(.roundedBorder)
                .focused($isInputFocused)
                .onSubmit(addTodo)

            Button(action: addTodo) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
            .disabled(trimmedTitle.isEmpty)
            .accessibilityLabel("Add todo")
        }
        .padding()
    }

    private var todoList: some View {
        List {
            ForEach(store.todos) { todo in
                TodoRow(todo: todo) {
                    store.toggleCompletion(of: todo.id)
                }
            }
            .onDelete { offsets in
                store.delete(atOffsets: offsets)
            }
        }
        .listStyle(.plain)
    }

    private var emptyState: some View {
        ContentUnavailableView(
            "No Todos Yet",
            systemImage: "checkmark.circle",
            description: Text("Add your first todo using the field above.")
        )
        .frame(maxHeight: .infinity)
    }

    private func addTodo() {
        guard store.addTodo(title: newTitle) != nil else { return }
        newTitle = ""
        isInputFocused = true
    }
}

/// A single row: a tappable completion toggle plus the todo title.
private struct TodoRow: View {
    let todo: Todo
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 12) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isCompleted ? Color.accentColor : Color.secondary)

                Text(todo.title)
                    .strikethrough(todo.isCompleted)
                    .foregroundStyle(todo.isCompleted ? Color.secondary : Color.primary)

                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(todo.title)
        .accessibilityValue(todo.isCompleted ? "Completed" : "Not completed")
        .accessibilityHint("Double tap to toggle completion")
    }
}

#Preview {
    TodoListView(
        store: TodoStore(todos: [
            Todo(title: "Buy groceries"),
            Todo(title: "Walk the dog", isCompleted: true),
            Todo(title: "Read a book")
        ])
    )
}
#endif
