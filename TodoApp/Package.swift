// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "TodoApp",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: "TodoCore", targets: ["TodoCore"]),
        .executable(name: "TodoListApp", targets: ["TodoListApp"])
    ],
    targets: [
        .target(name: "TodoCore"),
        .executableTarget(
            name: "TodoListApp",
            dependencies: ["TodoCore"]
        ),
        .testTarget(
            name: "TodoCoreTests",
            dependencies: ["TodoCore"]
        )
    ]
)
