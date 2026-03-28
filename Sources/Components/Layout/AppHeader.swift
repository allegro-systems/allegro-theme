import Score

/// A consistent app header shell with configurable slots.
///
/// Provides four slots -- leading (logo), center (navigation), trailing (actions),
/// and an optional mobile slot visible only on compact screens. The center and
/// trailing slots are automatically hidden on compact viewports.
///
/// ```swift
/// AppHeader(
///     leading: { SiteLogo() },
///     center: { Navigation { ... } },
///     trailing: { ThemeToggle() },
///     mobile: { MobileMenu() }
/// )
/// ```
///
/// Omit the `mobile` parameter when no compact-only content is needed:
///
/// ```swift
/// AppHeader(
///     leading: { SiteLogo() },
///     center: { NavLink(to: "/docs", icon: "book", label: "Docs") },
///     trailing: { ThemeToggle() }
/// )
/// ```
@Component
public struct AppHeader<Leading: Node, Center: Node, Trailing: Node, Mobile: Node> {
    let leading: Leading
    let center: Center
    let trailing: Trailing
    let mobile: Mobile

    /// Creates an app header with all four slots.
    ///
    /// - Parameters:
    ///   - leading: Content for the left slot (typically a logo or home link).
    ///   - center: Content for the center slot (typically navigation links). Hidden on compact.
    ///   - trailing: Content for the right slot (typically actions like theme toggle). Hidden on compact.
    ///   - mobile: Content shown only on compact screens (e.g. a hamburger menu).
    public init(
        @NodeBuilder leading: () -> Leading,
        @NodeBuilder center: () -> Center,
        @NodeBuilder trailing: () -> Trailing,
        @NodeBuilder mobile: () -> Mobile
    ) {
        self.leading = leading()
        self.center = center()
        self.trailing = trailing()
        self.mobile = mobile()
    }

    public var body: some Node {
        Header {
            Stack { leading }
                .flex(grow: 1)

            Stack { center }
                .flex(grow: 1)
                .compact { $0.hidden() }

            Stack { trailing }
                .flex(.row, gap: 12, align: .center, justify: .end)
                .flex(grow: 1)
                .compact { $0.hidden() }

            mobile
        }
        .flex(.row, align: .center)
        .padding(16, at: .vertical)
        .padding(56, at: .horizontal)
        .compact { $0.padding(20, at: .horizontal).padding(16, at: .vertical) }
        .border(width: 1, color: .border, style: .solid, at: .bottom)
    }
}

extension AppHeader where Mobile == EmptyNode {
    public init(
        @NodeBuilder leading: () -> Leading,
        @NodeBuilder center: () -> Center,
        @NodeBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.center = center()
        self.trailing = trailing()
        self.mobile = EmptyNode()
    }
}
