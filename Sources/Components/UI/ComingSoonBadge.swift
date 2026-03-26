import Score

/// A small "Coming Soon" badge with a bordered pill style.
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
