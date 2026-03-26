import Score

/// A page hero section with a large serif heading, optional muted description,
/// and optional back link. Used for top-of-page headers across dashboard-style apps.
@Component
public struct PageHero {
    let title: String
    let subtitle: String
    let backLinkDestination: String
    let backLinkLabel: String
    let backLinkId: String
    let titleId: String
    let subtitleId: String

    public init(
        _ title: String,
        subtitle: String = "",
        backTo destination: String = "",
        backLabel: String = "",
        backLinkId: String = "",
        titleId: String = "",
        subtitleId: String = ""
    ) {
        self.title = title
        self.subtitle = subtitle
        self.backLinkDestination = destination
        self.backLinkLabel = backLabel
        self.backLinkId = backLinkId
        self.titleId = titleId
        self.subtitleId = subtitleId
    }

    public var body: some Node {
        Section {
            if !backLinkDestination.isEmpty {
                BackLink(to: backLinkDestination, label: backLinkLabel, id: backLinkId)
            }

            Heading(.one) { title }
                .htmlAttribute("id", titleId)
                .font(.serif, size: 48, weight: .light, color: .text)

            if !subtitle.isEmpty {
                Paragraph { subtitle }
                    .htmlAttribute("id", subtitleId)
                    .font(.sans, size: 15, color: .muted)
            }
        }
        .flex(.column, gap: 12, align: .start)
        .padding(48, at: .top)
        .padding(32, at: .bottom)
        .padding(56, at: .horizontal)
    }
}
