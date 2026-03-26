import Score
import ScoreLucide

/// A feature showcase card with icon, title, and description.
@Component
public struct FeatureCard {
    let icon: String
    let title: String
    let description: String
    let accentColor: ColorToken
    let large: Bool

    public init(icon: String, title: String, description: String, accentColor: ColorToken = .accent, large: Bool = false) {
        self.icon = icon
        self.title = title
        self.description = description
        self.accentColor = accentColor
        self.large = large
    }

    public var body: some Node {
        Article {
            if large {
                Stack {
                    Icon(icon, size: 24, color: accentColor)
                    Heading(.three) { title }
                        .font(.serif, size: 22, weight: .light, color: .text)
                }
                .flex(.row, gap: 14, align: .center)
            } else {
                Icon(icon, size: 20, color: accentColor)

                Heading(.three) { title }
                    .font(.serif, size: 18, weight: .light, color: .text)
            }

            Paragraph { description }
                .font(.mono, size: 13, lineHeight: 1.6, color: .muted)
        }
        .flex(.column, gap: 12)
        .padding(large ? 32 : 24, at: .vertical)
        .padding(large ? 28 : 24, at: .horizontal)
        .background(.surface)
        .border(width: 1, color: .border, style: .solid, radius: large ? 0 : 8)
    }
}
