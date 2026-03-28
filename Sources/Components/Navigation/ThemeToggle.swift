import Score
import ScoreLucide

/// A dark/light mode toggle button with sun and moon icons.
///
/// Persists the user's preference via the `.theme` storage key so the
/// choice survives page reloads. Place it in your header's trailing slot.
///
/// ```swift
/// AppHeader(
///     leading: { SiteLogo() },
///     center: { /* nav */ },
///     trailing: { ThemeToggle() }
/// )
/// ```
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
