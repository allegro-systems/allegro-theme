import Score

/// A full-page layout wrapper with header, main content, and footer.
///
/// Usage:
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
                .flexItem(grow: 1)
            footer
        }
        .flex(.column)
        .background(.bg)
        .size(minHeight: .vh(100))
    }
}
