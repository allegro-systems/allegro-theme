import Score
import ScoreLucide

/// A feature showcase card with a Lucide icon, title, and description.
///
/// Renders a bordered card on a surface background. The `large` variant
/// uses bigger padding and places the icon inline with the title.
///
/// ```swift
/// FeatureCard(
///     icon: "zap",
///     title: "Instant Deploys",
///     description: "Push to deploy in under 10 seconds.",
///     accentColor: .stage
/// )
///
/// // Large variant for hero feature grids
/// FeatureCard(
///     icon: "code",
///     title: "Swift-Native",
///     description: "Write your entire stack in Swift.",
///     large: true
/// )
/// ```
///
/// - Parameters:
///   - icon: Lucide icon name (e.g. "zap", "code", "globe").
///   - title: The card heading.
///   - description: A short explanation rendered in mono font.
///   - accentColor: Icon color. Defaults to `.accent`.
///   - large: When `true`, uses larger padding and inline icon+title layout.
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
