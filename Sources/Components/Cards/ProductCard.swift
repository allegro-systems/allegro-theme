import Score

/// A product showcase card with an accent color bar, title, description, and optional link.
///
/// Renders a bordered card topped with a small colored bar. When a `link` is
/// provided, the entire card becomes clickable and shows "Learn More" at the
/// bottom. Supports a ``ComingSoonBadge`` for unreleased products.
///
/// ```swift
/// ProductCard(
///     title: "Stage",
///     description: "Zero-config deployment for Swift web apps.",
///     accentColor: .stage,
///     link: "/products/stage"
/// )
///
/// ProductCard(
///     title: "Composer",
///     description: "Visual component builder.",
///     accentColor: .composer,
///     comingSoon: true
/// )
/// ```
@Component
public struct ProductCard {
    let title: String
    let description: String
    let accentColor: ColorToken
    let link: String?
    let comingSoon: Bool

    /// Creates a product card.
    ///
    /// - Parameters:
    ///   - title: The product name.
    ///   - description: A short product description in mono font.
    ///   - accentColor: Color for the top bar and "Learn More" text.
    ///   - link: Optional destination URL. When set, the card becomes a clickable link.
    ///   - comingSoon: Shows a ``ComingSoonBadge`` next to the title. Defaults to `false`.
    public init(
        title: String,
        description: String,
        accentColor: ColorToken,
        link: String? = nil,
        comingSoon: Bool = false
    ) {
        self.title = title
        self.description = description
        self.accentColor = accentColor
        self.link = link
        self.comingSoon = comingSoon
    }

    public var body: some Node {
        let card = Article {
            // Accent bar
            Stack {}
                .size(width: 24, height: 3)
                .background(accentColor)

            Stack {
                Heading(.three) { title }
                    .font(.serif, size: 20, weight: .light, color: .text)

                if comingSoon {
                    ComingSoonBadge()
                        .flex(shrink: 0)
                }
            }
            .flex(.row, gap: 10, align: .center)

            Paragraph { description }
                .font(.mono, size: 13, lineHeight: 1.6, color: .muted)
                .flex(grow: 1)

            if link != nil {
                Text { "Learn More →" }
                    .font(.mono, size: 13, weight: .medium, color: accentColor)
            } else {
                Stack {}.flex(grow: 1)
            }
        }
        .flex(.column, gap: 8)
        .padding(24)
        .background(.surface)
        .border(width: 1, color: .border, style: .solid, radius: 8)
        .hover { $0.border(width: 1, color: accentColor, style: .solid) }
        .transition(property: .borderColor, duration: 0.15, timing: .ease)

        if let link {
            Link(to: link) { card }
                .font(color: .text, decoration: TextDecoration.none)
                .hover { $0.font(decoration: TextDecoration.none) }
                .cursor(.pointer)
        } else {
            card
        }
    }
}
