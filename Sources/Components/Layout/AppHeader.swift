import Score

/// A consistent app header shell with configurable slots:
/// leading (logo), center (navigation), trailing (actions),
/// and an optional mobile slot visible only on compact screens.
///
/// Usage:
/// ```swift
/// AppHeader(
///     leading: { SiteLogo() },
///     center: { Navigation { ... } },
///     trailing: { ThemeToggle() },
///     mobile: { MobileMenu() }
/// )
/// ```
@Component
public struct AppHeader<Leading: Node, Center: Node, Trailing: Node, Mobile: Node> {
    let leading: Leading
    let center: Center
    let trailing: Trailing
    let mobile: Mobile

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
                .flexItem(grow: 1)

            Stack { center }
                .flexItem(grow: 1)
                .compact { $0.hidden() }

            Stack { trailing }
                .flex(.row, gap: 12, align: .center, justify: .end)
                .flexItem(grow: 1)
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
