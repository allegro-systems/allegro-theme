import Score

/// A documentation section card with accent bar, title, and optional link.
///
/// Similar to ``ProductCard`` but tailored for documentation listings.
/// Supports a `filled` variant that uses a surface background instead of
/// the default page background, and a `comingSoon` flag for unreleased docs.
///
/// ```swift
/// DocCard(
///     title: "Getting Started",
///     description: "Install Score and create your first app.",
///     accentColor: .score,
///     link: "/docs/getting-started"
/// )
///
/// DocCard(
///     title: "Deployment Guide",
///     description: "Deploy to Stage from the CLI.",
///     accentColor: .stage,
///     comingSoon: true
/// )
/// ```
@Component
public struct DocCard {
    let title: String
    let description: String
    let accentColor: ColorToken
    let link: String?
    let comingSoon: Bool
    let filled: Bool

    /// Creates a documentation card.
    ///
    /// - Parameters:
    ///   - title: The documentation section heading.
    ///   - description: A short summary of the docs section.
    ///   - accentColor: Color for the top bar and "Read Docs" link.
    ///   - link: Optional destination URL. When set, the card becomes clickable.
    ///   - comingSoon: Shows a ``ComingSoonBadge`` and dims the text. Defaults to `false`.
    ///   - filled: Uses `.surface` background instead of `.bg`. Defaults to `false`.
    public init(
        title: String,
        description: String,
        accentColor: ColorToken,
        link: String? = nil,
        comingSoon: Bool = false,
        filled: Bool = false
    ) {
        self.title = title
        self.description = description
        self.accentColor = accentColor
        self.link = link
        self.comingSoon = comingSoon
        self.filled = filled
    }

    public var body: some Node {
        let card = Article {
            // Accent bar
            Stack {}
                .size(width: 32, height: 3)
                .background(accentColor)

            Stack {
                Heading(.three) { title }
                    .font(.serif, size: 20, weight: .light, color: comingSoon ? .muted : .text)

                if comingSoon {
                    ComingSoonBadge()
                }
            }
            .flex(.row, gap: 10, align: .center)

            Paragraph { description }
                .font(.mono, size: 13, lineHeight: 1.6, color: comingSoon ? .dimmer : .muted)

            if link != nil {
                Text { "Read Docs →" }
                    .font(.mono, size: 13, weight: .medium, color: accentColor)
            }
        }
        .flex(.column, gap: 14)
        .padding(28)
        .size(minHeight: 180)
        .background(filled ? .surface : .bg)
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
