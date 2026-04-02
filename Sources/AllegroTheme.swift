import Score

/// The shared visual theme for all Allegro products.
///
/// `AllegroTheme` provides the complete design system used across Score, Stage,
/// Composer, and Libretto -- including color tokens, font families, type scale,
/// spacing, and border radius defaults. It also supplies an ``AllegroDarkPatch``
/// for automatic dark-mode support.
///
/// ```swift
/// @main struct MyApp: ScoreApp {
///     var theme: some Theme { AllegroTheme() }
/// }
/// ```
@Theme
public struct AllegroTheme {

    public var extraColorRoles: [String: ColorToken] {
        [
            // Core palette — light mode (default)
            "surface": .oklch(1.0, 0, 0),
            "text": .oklch(0.21, 0.008, 85),
            "border": .oklch(0.884, 0.023, 85),
            "accent": .oklch(0.636, 0.111, 87),
            "muted": .oklch(0.604, 0.026, 80),
            "destructive": .oklch(0.493, 0.156, 25),
            "success": .oklch(0.562, 0.134, 150),
            "bg": .oklch(0.98, 0.006, 85),
            "elevated": .oklch(0.957, 0.012, 80),
            "dimmer": .oklch(0.81, 0.024, 85),

            // Product colors
            "score": .oklch(0.519, 0.1, 244),
            "stage": .oklch(0.504, 0.16, 1),
            "composer": .oklch(0.562, 0.134, 150),
            "libretto": .oklch(0.636, 0.111, 87),

            // Status colors
            "statusActive": .oklch(0.72, 0.19, 142),
            "statusWarning": .oklch(0.80, 0.18, 85),
            "statusError": .oklch(0.63, 0.24, 25),
            "statusInactive": .oklch(0.55, 0.02, 260),
            "statusActiveBg": .oklch(0.25, 0.08, 142),
            "statusWarningBg": .oklch(0.25, 0.08, 85),
            "statusErrorBg": .oklch(0.25, 0.08, 25),

            // Theme toggle icons
            "sun": .oklch(0.636, 0.111, 87),
            "moon": .oklch(0.604, 0.026, 80),
        ]
    }

    public var extraFontFamilies: [String: String] {
        [
            "sans": "'DM Sans', system-ui, -apple-system, sans-serif",
            "serif": "'Fraunces', serif",
            "mono": "'DM Mono', ui-monospace, monospace",
        ]
    }

    public var stylesheetImports: [String] {
        [
            "https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap",
            "https://fonts.googleapis.com/css2?family=DM+Mono:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&display=swap",
            "https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,100..900;1,9..144,100..900&display=swap",
        ]
    }

    public var typeScaleBase: Double { 16 }
    public var spacingUnit: Double { 4 }
    public var radiusBase: Double { 8 }

    public var dark: (any ThemePatch)? { AllegroDarkPatch() }

    public var named: [String: any ThemePatch] {
        ["dark": AllegroDarkPatch()]
    }

    public init() {}
}

/// Dark-mode color overrides for ``AllegroTheme``.
///
/// Applied automatically when the user toggles dark mode via ``ThemeToggle``.
/// Overrides surface, text, border, and product colors with darker variants
/// while preserving the same semantic token names.
public struct AllegroDarkPatch: ThemePatch {

    public var syntaxTheme: SyntaxTheme? { .scoreDefault }

    public let colorRoles: [String: ColorToken]? = [
        "surface": .oklch(0.21, 0.008, 85),
        "text": .oklch(0.909, 0.023, 85),
        "border": .oklch(0.287, 0.015, 85),
        "accent": .oklch(0.749, 0.085, 83),
        "muted": .oklch(0.55, 0.027, 80),
        "bg": .oklch(0.164, 0.004, 85),
        "elevated": .oklch(0.245, 0.016, 85),
        "dimmer": .oklch(0.343, 0.015, 80),
        "score": .oklch(0.681, 0.081, 246),
        "stage": .oklch(0.654, 0.127, 348),
        "composer": .oklch(0.76, 0.125, 153),
        "libretto": .oklch(0.749, 0.085, 83),
        "sun": .oklch(0.55, 0.027, 80),
        "moon": .oklch(0.749, 0.085, 83),
    ]

    public init() {}
}
