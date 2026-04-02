import Score
import ScoreLucide

/// A hover-activated language picker dropdown for multi-locale sites.
///
/// Reads the locale list from the application's ``Localization`` configuration
/// via ``LocalizationContext``. Each supported locale is listed with its native
/// display name (e.g. "Francais", "Deutsch") and links to the locale-prefixed path.
///
/// ```swift
/// AppHeader(
///     leading: { SiteLogo() },
///     center: { /* nav */ },
///     trailing: {
///         LanguageDropdown()
///         ThemeToggle()
///     }
/// )
/// ```
@Component
public struct LanguageDropdown {

    /// The current page path (e.g. "/score", "/about").
    /// Used to construct locale-aware links that stay on the same page.
    let pagePath: String

    private var currentLocale: String {
        LocalizationContext.current?.locale.identifier ?? "en"
    }

    private var supportedLocales: [SiteLocale] {
        LocalizationContext.current?.localization.supportedLocales ?? []
    }

    private var defaultLocale: String {
        LocalizationContext.current?.localization.defaultLocale.identifier ?? "en"
    }

    public init(pagePath: String = "/") {
        self.pagePath = pagePath
    }

    public var body: some Node {
        Stack {
            Stack {
                Icon("globe", size: 16, color: .text)
                Text { currentLocale.uppercased() }
                    .font(.mono, size: 11, weight: .medium, color: .text)
            }
            .flex(.row, gap: 4, align: .center)
            .padding(6, at: .vertical)
            .padding(8, at: .horizontal)
            .background(.elevated)
            .border(width: 1, color: .border, style: .solid, radius: 20)
            .cursor(.pointer)

            Stack {
                Stack {
                    for locale in supportedLocales {
                        let isActive = locale.identifier == currentLocale
                        let href = locale.identifier == defaultLocale ? pagePath : "/\(locale.identifier)\(pagePath)"

                        if isActive {
                            Link(to: href) { locale.displayName }
                                .font(.sans, size: 13, weight: .medium, color: .text, decoration: TextDecoration.none)
                                .display(.block)
                                .padding(7, at: .vertical)
                                .padding(14, at: .horizontal)
                                .background(.elevated)
                                .border(radius: 6)
                        } else {
                            Link(to: href) { locale.displayName }
                                .font(.sans, size: 13, color: .text, decoration: TextDecoration.none)
                                .display(.block)
                                .padding(7, at: .vertical)
                                .padding(14, at: .horizontal)
                                .border(radius: 6)
                                .hover { $0.background(.elevated).font(color: .text, decoration: TextDecoration.none) }
                        }
                    }
                }
                .flex(.column, gap: 0)
                .padding(6)
                .background(.surface)
                .border(width: 1, color: .border, style: .solid, radius: 10)
                .size(width: 160)
            }
            .position(.absolute, top: 36, trailing: 0)
            .zIndex(50)
            .showOnGroupHover()
        }
        .position(.relative)
        .hoverGroup()
    }
}
