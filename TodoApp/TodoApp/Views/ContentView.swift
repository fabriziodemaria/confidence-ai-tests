import SwiftUI

/// The single screen of the app: an input row for adding todos, followed by the
/// list of todos or a clear empty state when there are none.
struct ContentView: View {
    @State private var store = TodoStore()
    @State private var newTitle = ""
    @FocusState private var isInputFocused: Bool

    private var trimmedTitle: String {
        newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                addRow
                Divider()
                content
            }
            .navigationTitle("Todos")
            .toolbar {
                if !store.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }

    // MARK: - Add row

    private var addRow: some View {
        HStack(spacing: 12) {
            TextField("Add a todo", text: $newTitle)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .focused($isInputFocused)
                .onSubmit(addTodo)
                .accessibilityLabel("New todo")

            Button(action: addTodo) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
            .disabled(trimmedTitle.isEmpty)
            .accessibilityLabel("Add todo")
        }
        .padding()
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if store.isEmpty {
            ContentUnavailableView {
                Label("No Todos Yet", systemImage: "checklist")
            } description: {
                Text("Add your first todo using the field above.")
            }
        } else {
            List {
                ForEach(store.items) { item in
                    TodoRow(item: item) {
                        store.toggleCompletion(for: item)
                    }
                }
                .onDelete { store.delete(at: $0) }
            }
            .listStyle(.plain)
        }
    }

    // MARK: - Actions

    private func addTodo() {
        guard store.addTodo(title: newTitle) != nil else { return }
        newTitle = ""
        isInputFocused = true
    }
}

/// A single row in the todo list. Tapping anywhere on the row toggles it.
private struct TodoRow: View {
    let item: TodoItem
    let toggle: () -> Void

    var body: some View {
        Button(action: toggle) {
            HStack(spacing: 12) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.isCompleted ? Color.accentColor : Color.secondary)
                    .imageScale(.large)

                Text(item.title)
                    .strikethrough(item.isCompleted)
                    .foregroundStyle(item.isCompleted ? Color.secondary : Color.primary)

                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(item.title)
        .accessibilityValue(item.isCompleted ? "Completed" : "Not completed")
        .accessibilityHint("Double tap to toggle completion")
        .accessibilityAddTraits(item.isCompleted ? [.isButton, .isSelected] : .isButton)
    }
}

#Preview("With todos") {
    ContentView()
}
