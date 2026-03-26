import Score

/// A documentation card linking to a docs section.
@Component
public struct DocCard {
    let title: String
    let description: String
    let accentColor: ColorToken
    let link: String?
    let comingSoon: Bool
    let filled: Bool

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
