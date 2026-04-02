import Score

/// A small colored badge for plan names, tags, and status labels.
///
/// Renders compact inline text with a colored background and rounded corners.
///
/// ```swift
/// Badge(label: "Pro", textColor: .bg, background: .accent)
/// Badge(label: "Beta", textColor: .muted, background: .elevated)
/// ```
///
/// - Parameters:
///   - label: The badge text.
///   - textColor: Text color. Defaults to `.text`.
///   - background: Background color. Defaults to `.surface`.
@Component
public struct Badge {
    let label: String
    let textColor: ColorToken
    let background: ColorToken

    public init(label: String, textColor: ColorToken = .text, background: ColorToken = .surface) {
        self.label = label
        self.textColor = textColor
        self.background = background
    }

    public var body: some Node {
        Text { label }
            .font(.sans, size: 11, weight: .semibold, color: textColor)
            .background(background)
            .padding(4, at: .horizontal)
            .padding(2, at: .vertical)
            .border(radius:4)
    }
}
