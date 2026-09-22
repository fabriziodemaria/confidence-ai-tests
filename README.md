# confidence-ai-tests

A small test repository containing two independent pieces:

- **Confidence SDK demo** (`main.py`) — a short Python script that evaluates
  feature flags via the [Spotify Confidence](https://confidence.spotify.com)
  SDK through the OpenFeature API.
- **TodoApp** (`TodoApp/`) — a minimal native SwiftUI todo-list app backed by a
  platform-independent, unit-tested `TodoCore` package.

## Confidence SDK demo (Python)

Prerequisites: Python 3.

```bash
pip install -r requirements.txt
python main.py
```

Set your own client secret and flag keys in `main.py` before running.

## TodoApp (Swift)

A SwiftUI app that displays a todo list and lets you add non-empty items, mark
them complete/incomplete, and delete them. The model/store logic lives in the
`TodoCore` package and is covered by tests.

- Run the app: open `TodoApp/Package.swift` in Xcode (15+), pick the
  `TodoListApp` scheme and a destination, then Run.
- Build/test the core logic (macOS or Linux, Swift 6.0+):

  ```bash
  cd TodoApp
  swift build
  swift test
  ```

See [`TodoApp/README.md`](TodoApp/README.md) for full details.
