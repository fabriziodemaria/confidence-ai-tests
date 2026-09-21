import SwiftUI

/// A single row in the todo list: a tappable completion toggle plus the title.
struct TodoRowView: View {
    let item: TodoItem
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isCompleted ? Color.accentColor : Color.secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(item.isCompleted ? "Mark \(item.title) as incomplete" : "Mark \(item.title) as complete")

            Text(item.title)
                .strikethrough(item.isCompleted, color: .secondary)
                .foregroundStyle(item.isCompleted ? Color.secondary : Color.primary)

            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    List {
        TodoRowView(item: TodoItem(title: "Buy milk"), onToggle: {})
        TodoRowView(item: TodoItem(title: "Walk the dog", isCompleted: true), onToggle: {})
    }
}
