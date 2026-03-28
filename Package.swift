// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "AllegroTheme",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "AllegroTheme", targets: ["AllegroTheme"]),
    ],
    dependencies: [
        .package(url: "https://github.com/allegro-systems/score.git", branch: "main"),
        .package(url: "https://github.com/allegro-systems/score-lucide.git", branch: "main"),
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
