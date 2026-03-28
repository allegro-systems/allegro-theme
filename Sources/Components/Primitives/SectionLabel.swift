import Score

/// An uppercase monospace section label for organizing content areas.
///
/// Renders small uppercase text in the mono font with wide letter spacing.
/// Use to label groups of controls, settings sections, or sidebar areas.
///
/// ```swift
/// SectionLabel("Account")
/// SectionLabel("Navigation", tracking: 4)
/// ```
///
/// - Parameters:
///   - text: The label text (rendered uppercase automatically).
///   - tracking: Letter spacing in points. Defaults to `3`.
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
