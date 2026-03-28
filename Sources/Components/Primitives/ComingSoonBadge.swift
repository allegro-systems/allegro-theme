import Score

/// A small "Coming Soon" pill badge with a bordered outline.
///
/// Used alongside product cards and doc cards to indicate unreleased features.
/// Takes no parameters -- styling is fixed to match the theme.
///
/// ```swift
/// Stack {
///     Heading(.three) { "Composer" }
///     ComingSoonBadge()
/// }
/// .flex(.row, gap: 10, align: .center)
/// ```
@Component
public struct ComingSoonBadge {
    public init() {}

    public var body: some Node {
        Text { "Coming Soon" }
            .font(.mono, size: 10, color: .muted)
            .padding(3, at: .vertical)
            .padding(8, at: .horizontal)
            .border(width: 1, color: .border, style: .solid)
    }
}
