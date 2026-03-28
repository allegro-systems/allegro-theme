import Score

/// A page hero section with a large serif heading, subtitle, and optional back link.
///
/// Renders a padded section at the top of dashboard-style pages with a large
/// serif title, optional muted subtitle, and optional back navigation.
///
/// ```swift
/// // Simple page title
/// PageHero("Overview")
///
/// // Title with subtitle
/// PageHero("App Details", subtitle: "myapp.allegro.systems")
///
/// // With back navigation
/// PageHero("Build #42",
///     subtitle: "Started 2 minutes ago",
///     backTo: "/apps/myapp/builds",
///     backLabel: "< All Builds"
/// )
/// ```
@Component
public struct PageHero {
    let title: String
    let subtitle: String
    let backLinkDestination: String
    let backLinkLabel: String
    let backLinkId: String
    let titleId: String
    let subtitleId: String

    /// Creates a page hero section.
    ///
    /// - Parameters:
    ///   - title: The large heading text.
    ///   - subtitle: Optional muted description text below the title.
    ///   - destination: Optional back-link URL. When non-empty, a ``BackLink`` is rendered.
    ///   - backLabel: Text for the back link (e.g. "< All Apps").
    ///   - backLinkId: Optional HTML `id` for the back link.
    ///   - titleId: Optional HTML `id` for the heading element.
    ///   - subtitleId: Optional HTML `id` for the subtitle element.
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
