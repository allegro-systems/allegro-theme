import Score

/// A colored dot + label status indicator.
///
/// Renders an 8pt colored circle followed by a label, both in the given color.
/// Use with the theme status tokens for consistent state representation.
///
/// ```swift
/// StatusDot(label: "Running", color: .statusActive)
/// StatusDot(label: "Error", color: .statusError)
/// StatusDot(label: "Idle", color: .statusInactive)
/// ```
///
/// - Parameters:
///   - label: The status text shown next to the dot.
///   - color: Color applied to both the dot and the label text.
@Component
public struct StatusDot {
    let label: String
    let color: ColorToken

    public init(label: String, color: ColorToken) {
        self.label = label
        self.color = color
    }

    public var body: some Node {
        Stack {
            Stack {}
                .size(width: 8, height: 8)
                .border(radius:4)
                .background(color)
            Text { label }
        }
        .flex(.row, gap: 6, align: .center)
        .font(.sans, size: 13, weight: .medium, color: color)
    }
}
