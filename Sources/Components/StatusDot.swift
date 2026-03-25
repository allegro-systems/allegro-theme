import Score

/// A generic colored status indicator with dot and label.
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
                .radius(4)
                .background(color)
            Text { label }
        }
        .flex(.row, gap: 6, align: .center)
        .font(.sans, size: 13, weight: .medium, color: color)
    }
}
