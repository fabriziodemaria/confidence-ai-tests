// swift-tools-version:5.9
import PackageDescription

// This package exists only to build and unit-test the dependency-free model
// (`TodoItem` / `TodoStore`) from the command line or on Linux, where SwiftUI
// and Xcode are unavailable. The primary way to build and run the app is the
// `TodoApp.xcodeproj` Xcode project (see README.md).
//
// The library target is named `TodoApp` so the shared test file's
// `@testable import TodoApp` works both here and in the Xcode test target.
let package = Package(
    name: "TodoApp",
    platforms: [
        .macOS(.v14)
    ],
    targets: [
        .target(
            name: "TodoApp",
            path: "TodoApp/Model"
        ),
        .testTarget(
            name: "TodoAppTests",
            dependencies: ["TodoApp"],
            path: "TodoAppTests"
        )
    ]
)
