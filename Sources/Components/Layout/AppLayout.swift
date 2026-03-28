import Score

/// A full-page layout wrapper with header, scrollable main content, and footer.
///
/// Renders a vertical flex column that stretches to at least 100vh. The main
/// content area grows to fill available space between the header and footer.
///
/// ```swift
/// AppLayout(
///     header: { SiteHeader() },
///     footer: { SiteFooter() }
/// ) {
///     Section { ... }
/// }
/// ```
@Component
public struct AppLayout<HeaderContent: Node, FooterContent: Node, MainContent: Node> {
    let header: HeaderContent
    let footer: FooterContent
    let mainContent: MainContent

    /// Creates a full-page layout.
    ///
    /// - Parameters:
    ///   - header: The page header (typically an ``AppHeader``).
    ///   - footer: The page footer (typically an ``AppFooter``).
    ///   - content: The main page content rendered inside a `<main>` element.
    public init(
        @NodeBuilder header: () -> HeaderContent,
        @NodeBuilder footer: () -> FooterContent,
        @NodeBuilder content: () -> MainContent
    ) {
        self.header = header()
        self.footer = footer()
        self.mainContent = content()
    }

    public var body: some Node {
        Stack {
            header
            Main { mainContent }
                .flex(grow: 1)
            footer
        }
        .flex(.column)
        .background(.bg)
        .size(minHeight: .vh(100))
    }
}
