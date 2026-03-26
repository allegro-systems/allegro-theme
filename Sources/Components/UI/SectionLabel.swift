import Score

/// An uppercase section label for organizing content areas.
@Component
public struct SectionLabel {
    let text: String
    let tracking: Double

    public init(_ text: String, tracking: Double = 3) {
        self.text = text
        self.tracking = tracking
    }

    public var body: some Node {
        Text { text }
            .font(.mono, size: 12, weight: .medium, tracking: tracking, color: .muted, transform: .uppercase)
    }
}
