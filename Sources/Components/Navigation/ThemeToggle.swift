import Score
import ScoreLucide

/// A dark/light mode toggle button.
@Component
public struct ThemeToggle {
    @State(persisted: .theme) var isDark = false

    @Action mutating func toggleTheme() { isDark.toggle() }

    public init() {}

    public var body: some Node {
        Button(type: .button) {
            Stack {
                Icon("sun", size: 16, color: .sun)
                Icon("moon", size: 16, color: .moon)
            }
            .flex(.row, gap: 6, align: .center)
        }
        .on(.click, action: "toggleTheme")
        .cursor(.pointer)
        .border(width: 0, color: .border, style: .none)
        .padding(6, at: .vertical)
        .padding(10, at: .horizontal)
        .background(.elevated)
        .radius(20)
    }
}
