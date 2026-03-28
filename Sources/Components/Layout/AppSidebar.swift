import Score

/// A fixed-width sidebar navigation panel with logo, nav links, and a bottom section.
///
/// Renders a 240pt-wide `<aside>` with a right border, divided into a top group
/// (logo + nav) and a bottom group (plan badge, settings, etc.) separated by
/// `justify: .spaceBetween`.
///
/// ```swift
/// AppSidebar(
///     logo: { Link(to: "/") { Text { "Stage" } } },
///     nav: { NavLink(to: "/apps", icon: "grid", label: "Apps") },
///     bottom: { PlanBadge(plan: .free) }
/// )
/// ```
@Component
public struct AppSidebar<Logo: Node, Nav: Node, Bottom: Node> {
    let logo: Logo
    let nav: Nav
    let bottom: Bottom

    /// Creates a sidebar panel.
    ///
    /// - Parameters:
    ///   - logo: Top-left branding content (logo, product name link).
    ///   - nav: Navigation links, typically a list of ``NavLink`` components.
    ///   - bottom: Bottom section content (plan badge, user info, settings link).
    public init(
        @NodeBuilder logo: () -> Logo,
        @NodeBuilder nav: () -> Nav,
        @NodeBuilder bottom: () -> Bottom
    ) {
        self.logo = logo()
        self.nav = nav()
        self.bottom = bottom()
    }

    public var body: some Node {
        Aside {
            Stack {
                Stack { logo }
                Navigation { nav }
                    .flex(.column, gap: 4)
            }
            .flex(.column, gap: 32)

            Stack { bottom }
                .flex(.column, gap: 12)
        }
        .flex(.column, justify: .spaceBetween)
        .size(width: 240, minHeight: .percent(100))
        .flex(shrink: 0)
        .padding(24, at: .vertical)
        .padding(20, at: .horizontal)
        .background(.surface)
        .border(width: 1, color: .border, style: .solid, at: .trailing)
    }
}

/// A sidebar + main content layout with optional client-side auth gate.
///
/// Renders a horizontal flex row that fills the viewport. When `authGated`
/// is `true`, a client-side script redirects unauthenticated visitors
/// (no `session` cookie) to `/login`.
///
/// ```swift
/// SidebarLayout(authGated: true) {
///     DashboardSidebar()
/// } content: {
///     OverviewPage()
/// }
/// ```
@Component
public struct SidebarLayout<Sidebar: Node, MainContent: Node> {
    let sidebar: Sidebar
    let mainContent: MainContent
    let authGated: Bool

    /// Creates a sidebar layout.
    ///
    /// - Parameters:
    ///   - authGated: When `true`, injects a client-side redirect to `/login`
    ///     for unauthenticated visitors. Defaults to `false`.
    ///   - sidebar: The sidebar content (typically an ``AppSidebar``).
    ///   - content: The main content area rendered inside a `<main>` element.
    public init(
        authGated: Bool = false,
        @NodeBuilder sidebar: () -> Sidebar,
        @NodeBuilder content: () -> MainContent
    ) {
        self.sidebar = sidebar()
        self.mainContent = content()
        self.authGated = authGated
    }

    public var body: some Node {
        Stack {
            if authGated {
                RawTextNode(authGateScript)
            }
            sidebar
            Main { mainContent }
                .flex(.column, gap: 0)
                .flex(grow: 1)
                .overflow(y: .auto)
                .size(minHeight: .percent(100))
        }
        .flex(.row)
        .size(minHeight: .vh(100))
        .background(.bg)
    }
}

// SCORE-GAP: client-side auth redirect
private let authGateScript = """
    <script>
    (function() {
      if (document.cookie.indexOf('session=') === -1 && window.location.pathname !== '/login') {
        window.location.replace('/login');
      }
    })();
    </script>
    """
