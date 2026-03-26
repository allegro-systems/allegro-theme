import Score
import ScoreLucide

/// A navigation link used in sidebars, nav menus, headers, and footers.
///
/// Supports two styles:
/// - **Sidebar style** (default): icon + label with background, padding, and hover effects.
/// - **Inline style**: text-only link with no chrome — omit `icon` and set `style: .inline`.
///
/// Labels can be localized by setting `localized: true`, which wraps the label in `Localized()`.
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
            Localized(label)
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
            .radius(8)
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
