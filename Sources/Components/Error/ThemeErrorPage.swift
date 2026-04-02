import Score

/// A full-page error layout shared across Allegro apps.
///
/// Displays the HTTP status code, a human-readable title, the error
/// message from the framework, and a link back to the home page (or
/// any custom path). Apps can use this directly as their ``ErrorPage``
/// or wrap it in an app-specific layout.
///
/// ### Minimal usage
///
/// ```swift
/// struct SiteError: ErrorPage {
///     var context: ErrorContext
///     var body: some Node { ThemeErrorPage(context: context) }
/// }
/// ```
///
/// ### Customised usage
///
/// ```swift
/// ThemeErrorPage(
///     context: context,
///     backTitle: "Return to Dashboard",
///     backLink: "/dashboard"
/// )
/// ```
@Component
public struct ThemeErrorPage {
    let context: ErrorContext
    let backTitle: String
    let backLink: String

    /// Creates a themed error page.
    ///
    /// - Parameters:
    ///   - context: The ``ErrorContext`` supplied by the framework.
    ///   - backTitle: Label for the back link. Defaults to `"Back to Home"`.
    ///   - backLink: Destination path for the back link. Defaults to `"/"`.
    public init(context: ErrorContext, backTitle: String = "Back to Home", backLink: String = "/") {
        self.context = context
        self.backTitle = backTitle
        self.backLink = backLink
    }

    public var body: some Node {
        Stack {
            Section {
                Heading(.one) { "\(context.statusCode)" }
                    .font(.serif, size: 72, weight: .light, lineHeight: 1.1, color: .text, align: .center)
                    .compact { $0.font(size: 56) }
                    .animate(.fadeIn, duration: 0.6)

                Paragraph { errorTitle }
                    .font(.serif, size: 24, weight: .light, color: .text, align: .center)
                    .compact { $0.font(size: 20) }
                    .animate(.fadeIn, duration: 0.6, delay: 0.15)

                Paragraph { context.message }
                    .font(.sans, size: 14, lineHeight: 1.6, color: .muted, align: .center)
                    .size(maxWidth: 480)
                    .animate(.fadeIn, duration: 0.6, delay: 0.3)

                Link(to: backLink) { backTitle }
                    .font(.sans, size: 13, weight: .medium, color: .text, align: .center, decoration: TextDecoration.none)
                    .padding(10, at: .vertical)
                    .padding(20, at: .horizontal)
                    .border(width: 1, color: .border, style: .solid)
                    .border(radius:4)
                    .hover { $0.background(.elevated) }
                    .animate(.fadeIn, duration: 0.6, delay: 0.45)
            }
            .flex(.column, gap: 24, align: .center, justify: .center)
            .padding(120, at: .vertical)
            .padding(56, at: .horizontal)
            .compact { $0.padding(80, at: .vertical).padding(20, at: .horizontal) }
        }
        .flex(.column, gap: 0)
        .background(.bg)
        .size(minHeight: .vh(100))
    }

    private var errorTitle: String {
        switch context.statusCode {
        case 404: return "Page Not Found"
        case 403: return "Access Denied"
        case 500: return "Something Went Wrong"
        default: return "Error"
        }
    }
}
