import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: TodoStore
    @State private var newTitle = ""
    @FocusState private var addFieldFocused: Bool

    private var canAdd: Bool {
        !newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                addBar
                Divider()
                listContent
            }
            .navigationTitle("Todos")
        }
    }

    private var addBar: some View {
        HStack(spacing: 12) {
            TextField("Add a todo", text: $newTitle)
                .textFieldStyle(.roundedBorder)
                .focused($addFieldFocused)
                .submitLabel(.done)
                .onSubmit(addTodo)

            Button(action: addTodo) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
            .disabled(!canAdd)
            .accessibilityLabel("Add todo")
        }
        .padding()
    }

    @ViewBuilder
    private var listContent: some View {
        if store.todos.isEmpty {
            emptyState
        } else {
            List {
                ForEach(store.todos) { item in
                    TodoRowView(item: item) {
                        store.toggle(item)
                    }
                }
                .onDelete(perform: store.delete(at:))
            }
            .listStyle(.plain)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "checklist")
                .font(.system(size: 52))
                .foregroundStyle(.secondary)
            Text("No todos yet")
                .font(.headline)
            Text("Add your first todo above to get started.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
    }

    private func addTodo() {
        guard store.add(title: newTitle) else { return }
        newTitle = ""
        addFieldFocused = false
    }
}

#Preview {
    ContentView()
        .environmentObject(TodoStore(defaults: UserDefaults(suiteName: "preview") ?? .standard))
}
