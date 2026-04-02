import Score
import ScoreLucide

/// A navigation link used in sidebars, nav menus, headers, and footers.
///
/// Supports two visual styles and optional localization. The sidebar style
/// renders an icon + label with background, padding, and hover effects.
/// The inline style renders a minimal text link with no chrome.
///
/// ```swift
/// // Sidebar style (default) with icon
/// NavLink(to: "/apps", icon: "grid", label: "Apps", active: true)
///
/// // Inline style for header/footer links
/// NavLink(to: "/about", label: "About", style: .inline)
///
/// // Localized label
/// NavLink(to: "/docs", icon: "book", label: "nav.docs", localized: true)
/// ```
@Component
public struct NavLink {
    /// Visual style of the nav link.
    public enum Style: Sendable {
        /// Sidebar-style with padding, background, and radius.
        case sidebar
        /// Minimal inline link with no chrome.
        case inline
    }

    let destination: String
    let icon: String?
    let label: String
    var active: Bool = false
    var font: FontFamily = .sans
    var size: Double = 14
    var color: ColorToken? = nil
    var localized: Bool = false
    var style: Style = .sidebar

    /// Creates a navigation link.
    ///
    /// - Parameters:
    ///   - destination: The URL path this link navigates to.
    ///   - icon: Optional Lucide icon name shown before the label (sidebar style only).
    ///   - label: The visible text (or localization key when `localized` is `true`).
    ///   - active: Highlights the link as the current page. Defaults to `false`.
    ///   - font: Font family for the label. Defaults to `.sans`.
    ///   - size: Font size in points. Defaults to `14`.
    ///   - color: Override color. When `nil`, uses `.text` if active, `.muted` otherwise.
    ///   - localized: Wraps the label in `t()` for i18n. Defaults to `false`.
    ///   - style: Visual style -- `.sidebar` (padded with icon) or `.inline` (text only).
    public init(
        to destination: String,
        icon: String? = nil,
        label: String,
        active: Bool = false,
        font: FontFamily = .sans,
        size: Double = 14,
        color: ColorToken? = nil,
        localized: Bool = false,
        style: Style = .sidebar
    ) {
        self.destination = destination
        self.icon = icon
        self.label = label
        self.active = active
        self.font = font
        self.size = size
        self.color = color
        self.localized = localized
        self.style = style
    }

    var resolvedColor: ColorToken {
        color ?? (active ? .text : .muted)
    }

    @NodeBuilder
    var labelContent: some Node {
        if localized {
            t(label)
        } else {
            Text { label }
        }
    }

    public var body: some Node {
        switch style {
        case .sidebar:
            Link(to: destination) {
                if let icon {
                    Icon(icon, size: 18, color: resolvedColor)
                }
                labelContent
            }
            .flex(.row, gap: 12, align: .center)
            .font(font, size: size, color: resolvedColor, decoration: TextDecoration.none)
            .padding(12, at: .horizontal)
            .padding(10, at: .vertical)
            .border(radius:8)
            .background(active ? .elevated : .surface)
            .hover { $0.background(.elevated).font(color: .text) }

        case .inline:
            Link(to: destination) {
                labelContent
            }
            .font(font, size: size, color: resolvedColor, decoration: TextDecoration.none)
        }
    }
}
