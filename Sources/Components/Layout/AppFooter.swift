import Score

/// A consistent app footer with three columns and an optional copyright row.
///
/// Provides leading (branding), center (navigation links), and trailing (actions)
/// columns that collapse into a single centered column on compact screens.
/// An optional `copyright` slot renders a small line below the columns.
///
/// ```swift
/// AppFooter(
///     leading: { SiteLogo(); Paragraph { "Tagline" } },
///     center: { Navigation { Link(to: "/about") { "About" } } },
///     trailing: { Icon("github", size: 20) }
/// ) copyright: {
///     Localized("footer.copyright")
/// }
/// ```
@Component
public struct AppFooter<Leading: Node, Center: Node, Trailing: Node, CopyrightContent: Node> {
    let leading: Leading
    let center: Center
    let trailing: Trailing
    let copyrightContent: CopyrightContent

    /// Creates an app footer.
    ///
    /// - Parameters:
    ///   - leading: Left column content (logo, tagline).
    ///   - center: Center column content (navigation links).
    ///   - trailing: Right column content (social icons, actions).
    ///   - copyright: Optional bottom row (copyright text). Pass `EmptyNode` to omit.
    public init(
        @NodeBuilder leading: () -> Leading,
        @NodeBuilder center: () -> Center,
        @NodeBuilder trailing: () -> Trailing,
        @NodeBuilder copyright: () -> CopyrightContent
    ) {
        self.leading = leading()
        self.center = center()
        self.trailing = trailing()
        self.copyrightContent = copyright()
    }

    public var body: some Node {
        Footer {
            Stack {
                Stack { leading }
                    .flex(.column, gap: 8, align: .start)
                    .flex(grow: 1, basis: 0)
                    .compact { $0.flex(.column, gap: 8, align: .center) }

                Stack { center }
                    .flex(.row, gap: 24, align: .start, justify: .center)
                    .flex(grow: 1, basis: 0)
                    .compact { $0.flex(.column, gap: 12, align: .center) }

                Stack { trailing }
                    .flex(.row, align: .start, justify: .end)
                    .flex(grow: 1, basis: 0)
            }
            .flex(.row, align: .start, justify: .spaceBetween)
            .compact { $0.flex(.column, gap: 24, align: .center) }

            Stack {
                Paragraph { copyrightContent }
                    .font(.mono, size: 11, color: .dimmer)
                    .compact { $0.font(size: 10) }
            }
            .flex(.row, justify: .center)
        }
        .flex(.column, gap: 40)
        .padding(56)
        .border(width: 1, color: .border, style: .solid, at: .top)
        .compact { $0.padding(40, at: .vertical).padding(20, at: .horizontal) }
    }
}

extension AppFooter where CopyrightContent == EmptyNode {
    public init(
        @NodeBuilder leading: () -> Leading,
        @NodeBuilder center: () -> Center,
        @NodeBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.center = center()
        self.trailing = trailing()
        self.copyrightContent = EmptyNode()
    }
}
