import Score

/// A styled action link with primary/secondary variants.
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
        let vPad = large ? 12 : 8
        let hPad = large ? 24 : 12
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

/// A detail page action link with outline styling.
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

/// A back navigation link.
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

/// An upgrade/call-to-action link with accent background.
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
