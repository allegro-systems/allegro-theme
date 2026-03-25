import Score

public struct AllegroTheme: Theme {
    public let colorRoles: [String: ColorToken] = [
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

        // Theme toggle icons
        "sun": .oklch(0.636, 0.111, 87),
        "moon": .oklch(0.604, 0.026, 80),
    ]

    public let fontFamilies: [String: String] = [
        "sans": "'DM Sans', system-ui, -apple-system, sans-serif",
        "serif": "'Fraunces', serif",
        "mono": "'DM Mono', ui-monospace, monospace",
    ]

    public let stylesheetImports: [String] = [
        "https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap",
        "https://fonts.googleapis.com/css2?family=DM+Mono:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&display=swap",
        "https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,100..900;1,9..144,100..900&display=swap",
    ]

    public let typeScaleBase: Double = 16
    public let spacingUnit: Double = 4
    public let radiusBase: Double = 8

    public let dark: (any ThemePatch)? = AllegroDarkPatch()

    public var named: [String: any ThemePatch] {
        ["dark": AllegroDarkPatch()]
    }

    public init() {}
}

public extension ColorToken {
    #colorTokens("bg", "elevated", "dimmer", "score", "stage", "composer", "libretto", "sun", "moon")
}

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
