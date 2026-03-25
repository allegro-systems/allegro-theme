// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "AllegroTheme",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "AllegroTheme", targets: ["AllegroTheme"]),
    ],
    dependencies: [
        .package(path: "../../score"),
        .package(path: "../score-lucide"),
    ],
    targets: [
        .target(
            name: "AllegroTheme",
            dependencies: [
                .product(name: "Score", package: "Score"),
                .product(name: "ScoreLucide", package: "score-lucide"),
            ],
            path: "Sources"
        )
    ]
)
