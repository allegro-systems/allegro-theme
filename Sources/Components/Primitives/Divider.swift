import Score

/// A horizontal divider line using the theme border color.
///
/// Renders a 1px `<hr>` element with the theme's `border` color.
///
/// ```swift
/// Stack {
///     SectionLabel("Settings")
///     Divider()
///     FormField(label: "Name", inputId: "name", type: .text, placeholder: "...")
/// }
/// .flex(.column, gap: 16)
/// ```
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
