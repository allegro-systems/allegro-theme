import Score

/// A small colored badge for labels like plan names, tags, etc.
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
            .radius(4)
    }
}
