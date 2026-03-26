import Score

/// An inline product label with a colored border.
@Component
public struct ProductPill {
    let name: String
    let color: ColorToken

    public init(_ name: String, color: ColorToken) {
        self.name = name
        self.color = color
    }

    public var body: some Node {
        Text { name }
            .font(.mono, size: 11, weight: .medium, tracking: 1, color: color)
            .border(width: 1, color: color, style: .solid)
            .padding(5, at: .vertical)
            .padding(14, at: .horizontal)
    }
}
