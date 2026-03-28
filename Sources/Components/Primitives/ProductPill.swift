import Score

/// An inline product label with a colored border pill.
///
/// Renders the product name in a bordered pill using the product's accent
/// color for both text and border. Used on marketing pages and feature grids
/// to tag content by product.
///
/// ```swift
/// ProductPill("Score", color: .score)
/// ProductPill("Stage", color: .stage)
/// ```
///
/// - Parameters:
///   - name: The product name to display.
///   - color: The product's accent color token (e.g. `.score`, `.stage`).
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
