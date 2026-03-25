import Score

/// A horizontal divider line using the theme border color.
@Component
public struct Divider {
    public init() {}

    public var body: some Node {
        HorizontalRule()
            .border(width: 0, color: .border, style: .none)
            .size(height: 1)
            .background(.border)
    }
}
