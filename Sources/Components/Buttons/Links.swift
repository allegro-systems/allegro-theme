import Score

/// A styled action link with primary and secondary variants.
///
/// The primary variant renders with an accent background; the secondary uses
/// a bordered outline. Both support a `large` size for hero call-to-actions.
///
/// ```swift
/// // Primary (filled) action link
/// ActionLink(to: "/signup", label: "Get Started")
///
/// // Secondary (outlined) action link
/// ActionLink(to: "/docs", label: "Read Docs", primary: false)
///
/// // Large hero variant
/// ActionLink(to: "/signup", label: "Start Free", large: true)
/// ```
///
/// - Parameters:
///   - destination: The URL path this link navigates to.
///   - label: The link text.
///   - primary: When `true` (default), renders with accent background. When `false`, uses outline.
///   - large: When `true`, applies extra padding for hero sections. Defaults to `false`.
@Component
public struct ActionLink {
    let destination: String
    let label: String
    let isPrimary: Bool
    let large: Bool

    public init(to destination: String, label: String, primary: Bool = true, large: Bool = false) {
        self.destination = destination
        self.label = label
        self.isPrimary = primary
        self.large = large
    }

    public var body: some Node {
        let vPad: Double = large ? 12 : 8
        let hPad: Double = large ? 24 : 12
        if isPrimary {
            Link(to: destination) { label }
                .font(.sans, size: 13, weight: .medium, color: .bg, decoration: TextDecoration.none)
                .padding(vPad, at: .vertical).padding(hPad, at: .horizontal)
                .background(.accent)
                .radius(6)
                .hover { $0.opacity(0.85) }
        } else {
            Link(to: destination) { label }
                .font(.sans, size: 13, weight: .medium, color: .text, decoration: TextDecoration.none)
                .padding(vPad, at: .vertical).padding(hPad, at: .horizontal)
                .border(width: 1, color: .border, style: .solid)
                .radius(6)
                .hover { $0.background(.elevated) }
        }
    }
}

/// An outline-styled action link for detail pages.
///
/// Renders a bordered link with elevated background, suitable for
/// secondary actions on detail/show pages (e.g. "Edit", "View Logs").
///
/// ```swift
/// DetailActionLink(to: "/apps/myapp/settings", label: "Settings")
/// ```
///
/// - Parameters:
///   - destination: The URL path this link navigates to.
///   - label: The link text.
///   - id: Optional HTML `id` attribute.
@Component
public struct DetailActionLink {
    let destination: String
    let label: String
    let id: String

    public init(to destination: String, label: String, id: String = "") {
        self.destination = destination
        self.label = label
        self.id = id
    }

    public var body: some Node {
        Link(to: destination) {
            Text { label }
        }
        .htmlAttribute("id", id)
        .font(.sans, size: 14, weight: .medium, color: .text, decoration: TextDecoration.none)
        .padding(8, at: .horizontal)
        .padding(8, at: .vertical)
        .background(.elevated)
        .radius(6)
        .border(width: 1, color: .border, style: .solid)
    }
}

/// A minimal back-navigation link with muted styling.
///
/// Renders as plain muted text with no decoration. Typically used above
/// page titles to link back to a parent listing.
///
/// ```swift
/// BackLink(to: "/apps", label: "< Back to Apps")
/// ```
///
/// - Parameters:
///   - destination: The URL path to navigate back to.
///   - label: The link text (e.g. "< Back to Apps").
///   - id: Optional HTML `id` attribute.
@Component
public struct BackLink {
    let destination: String
    let label: String
    let id: String

    public init(to destination: String, label: String, id: String = "") {
        self.destination = destination
        self.label = label
        self.id = id
    }

    public var body: some Node {
        Link(to: destination) {
            Text { label }
        }
        .htmlAttribute("id", id)
        .font(.sans, size: 13, color: .muted, decoration: TextDecoration.none)
    }
}

/// An upgrade call-to-action link with accent background.
///
/// Similar to a primary ``ActionLink`` but with semibold weight, designed
/// for plan upgrade prompts in sidebar bottom sections and settings pages.
///
/// ```swift
/// UpgradeLink(to: "/billing/upgrade", label: "Upgrade to Pro")
/// ```
///
/// - Parameters:
///   - destination: The URL path to the upgrade/billing page.
///   - label: The link text.
@Component
public struct UpgradeLink {
    let destination: String
    let label: String

    public init(to destination: String, label: String) {
        self.destination = destination
        self.label = label
    }

    public var body: some Node {
        Link(to: destination) {
            Text { label }
        }
        .font(.sans, size: 13, weight: .semibold, color: .bg, decoration: TextDecoration.none)
        .padding(12, at: .horizontal)
        .padding(8, at: .vertical)
        .background(.accent)
        .radius(6)
    }
}
