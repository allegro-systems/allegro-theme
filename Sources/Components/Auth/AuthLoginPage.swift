import Score
import ScoreLucide

// MARK: - Full Login Page Layout

/// A complete split-panel login page layout used across Allegro products.
///
/// Left panel shows product branding with a mesh gradient, product name,
/// tagline, description, feature bullets, and footer.
/// Right panel shows the auth form (magic link, OAuth, passkey).
///
/// Usage:
/// ```swift
/// AuthLoginPage(
///     product: .stage,
///     features: [
///         .init(icon: "rocket", text: "Instant deployments"),
///         .init(icon: "gauge", text: "Auto-scaling"),
///     ]
/// )
/// ```
@Component
public struct AuthLoginPage {
    let config: ProductAuthConfig

    public init(product config: ProductAuthConfig) {
        self.config = config
    }

    public var body: some Node {
        Stack {
            // ── Left branded panel ──
            AuthBrandPanel(product: config)

            // ── Right auth panel ──
            AuthFormPanel(product: config)

            RawTextNode(Self.loginScript)
        }
        .flex(.row)
        .background(.bg)
        .htmlAttribute("style", "min-height:100vh")
        .overflow(.hidden)
    }

    // MARK: - Client Script

    private static let loginScript = """
        <script>
        (function() {
          var btn = document.getElementById('magic-link-btn');
          var input = document.getElementById('magic-link-email');
          var status = document.getElementById('magic-link-status');
          if (!btn || !input) return;

          btn.addEventListener('click', async function() {
            var email = input.value.trim();
            if (!email) { status.textContent = 'Please enter your email.'; return; }
            btn.disabled = true;
            status.textContent = 'Sending...';
            try {
              var res = await fetch('/auth/magic-link', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email: email })
              });
              var data = await res.json();
              status.textContent = data.message || data.error || 'Something went wrong.';
            } catch (e) {
              status.textContent = 'Network error. Please try again.';
            }
            btn.disabled = false;
          });

          var pkBtn = document.getElementById('passkey-btn');
          if (pkBtn) {
            pkBtn.addEventListener('click', async function() {
              if (!window.PublicKeyCredential) {
                status.textContent = 'Passkeys are not supported in this browser.';
                return;
              }
              status.textContent = 'Starting passkey authentication...';
              try {
                var optRes = await fetch('/auth/passkey/options', { method: 'POST' });
                var opts = await optRes.json();
                opts.challenge = Uint8Array.from(atob(opts.challenge), c => c.charCodeAt(0));
                if (opts.allowCredentials) {
                  opts.allowCredentials = opts.allowCredentials.map(c => ({
                    ...c, id: Uint8Array.from(atob(c.id), ch => ch.charCodeAt(0))
                  }));
                }
                var cred = await navigator.credentials.get({ publicKey: opts });
                var body = {
                  id: cred.id,
                  rawId: btoa(String.fromCharCode(...new Uint8Array(cred.rawId))),
                  response: {
                    authenticatorData: btoa(String.fromCharCode(...new Uint8Array(cred.response.authenticatorData))),
                    clientDataJSON: btoa(String.fromCharCode(...new Uint8Array(cred.response.clientDataJSON))),
                    signature: btoa(String.fromCharCode(...new Uint8Array(cred.response.signature)))
                  },
                  type: cred.type
                };
                var verRes = await fetch('/auth/passkey/verify', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  body: JSON.stringify(body)
                });
                if (verRes.redirected) { window.location.href = verRes.url; return; }
                var result = await verRes.json();
                if (result.success) { window.location.href = '/'; }
                else { status.textContent = result.error || 'Passkey verification failed.'; }
              } catch (e) {
                status.textContent = 'Passkey error: ' + e.message;
              }
            });
          }
        })();
        </script>
        """
}

// MARK: - Product Configuration

/// Configuration for a product's auth/login page appearance.
///
/// Defines the branding, accent color, tagline, feature list, and background
/// gradient for the left panel of ``AuthLoginPage``. Pre-built configurations
/// are available as static properties for each Allegro product.
///
/// ```swift
/// // Use a built-in product config
/// AuthLoginPage(product: .stage)
/// AuthLoginPage(product: .libretto)
///
/// // Or create a custom config
/// let config = ProductAuthConfig(
///     name: "MyApp",
///     accentColor: .accent,
///     tagline: "Build. Ship. Repeat.",
///     features: [.init(icon: "rocket", text: "Fast deploys")],
///     gradientCSS: "linear-gradient(135deg, #1a1a2e, #16213e)"
/// )
/// ```
public struct ProductAuthConfig: Sendable {
    public let name: String
    public let accentColor: ColorToken
    public let titleStyle: TitleStyle
    public let tagline: String
    public let description: String
    public let features: [FeatureBullet]
    public let gradientCSS: String

    /// Controls how the product name is rendered on the brand panel.
    public enum TitleStyle: Sendable {
        /// Normal serif title (e.g. "Libretto").
        case normal
        /// Spaced uppercase title with custom letter spacing (e.g. "S T A G E").
        case spaced(tracking: Double)
    }

    /// A single feature bullet point displayed on the brand panel.
    public struct FeatureBullet: Sendable {
        /// Lucide icon name shown before the text.
        public let icon: String
        /// Feature description text.
        public let text: String
        public init(icon: String, text: String) {
            self.icon = icon
            self.text = text
        }
    }

    /// Creates a product auth configuration.
    ///
    /// - Parameters:
    ///   - name: Product name displayed as the heading.
    ///   - accentColor: Product color token used for the magic link button and feature icons.
    ///   - titleStyle: Heading rendering style. Defaults to `.normal`.
    ///   - tagline: Short tagline shown below the product name.
    ///   - description: Optional longer description paragraph. Defaults to empty.
    ///   - features: List of feature bullets with icon and text.
    ///   - gradientCSS: CSS gradient value for the brand panel background.
    public init(
        name: String,
        accentColor: ColorToken,
        titleStyle: TitleStyle = .normal,
        tagline: String,
        description: String = "",
        features: [FeatureBullet],
        gradientCSS: String
    ) {
        self.name = name
        self.accentColor = accentColor
        self.titleStyle = titleStyle
        self.tagline = tagline
        self.description = description
        self.features = features
        self.gradientCSS = gradientCSS
    }

    /// Stage product configuration
    public static let stage = ProductAuthConfig(
        name: "STAGE",
        accentColor: .stage,
        titleStyle: .spaced(tracking: 8),
        tagline: "Deploy. Scale. Ship.",
        features: [
            .init(icon: "rocket", text: "Instant deployments from CLI or dashboard"),
            .init(icon: "gauge", text: "Automatic idle scaling & process management"),
            .init(icon: "globe", text: "Custom domains with automatic SSL"),
            .init(icon: "activity", text: "Real-time build logs & monitoring"),
        ],
        gradientCSS: """
            radial-gradient(ellipse 80% 60% at 0% 0%, #c86e9ecc, transparent), \
            radial-gradient(ellipse 80% 60% at 100% 100%, #c86e6ecc, transparent), \
            radial-gradient(ellipse 60% 60% at 50% 50%, #24201800, transparent), \
            linear-gradient(135deg, #1a1814 0%, #242018 100%)
            """
    )

    /// Libretto product configuration
    public static let libretto = ProductAuthConfig(
        name: "Libretto",
        accentColor: .libretto,
        tagline: "Write. Publish. Connect.",
        description: "A distraction-free writing platform for creators who value craft over clicks.",
        features: [
            .init(icon: "pen-line", text: "Split-pane Markdown editor with live preview"),
            .init(icon: "users", text: "Public profiles, likes, and comments"),
            .init(icon: "rss", text: "Built-in RSS syndication and custom domains"),
            .init(icon: "sparkles", text: "No ads, no tracking \u{2014} just your words"),
        ],
        gradientCSS: """
            radial-gradient(ellipse 80% 60% at 0% 0%, #c8a96ed9, transparent), \
            radial-gradient(ellipse 60% 60% at 100% 100%, #6ec88ad9, transparent), \
            radial-gradient(ellipse 60% 60% at 50% 50%, #3d302000, transparent), \
            linear-gradient(135deg, #1a1814 0%, #3d3020 100%)
            """
    )
}

// MARK: - Brand Panel (Left Side)

/// The left branded panel of ``AuthLoginPage``.
///
/// Displays the product name, tagline, description, feature bullets, and a
/// link to allegro.systems, all on top of a mesh gradient background.
/// Hidden on compact screens.
@Component
public struct AuthBrandPanel {
    let config: ProductAuthConfig

    public init(product config: ProductAuthConfig) {
        self.config = config
    }

    public var body: some Node {
        Section {
            // Brand group
            Stack {
                switch config.titleStyle {
                case .normal:
                    Heading(.one) { config.name }
                        .font(.serif, size: 48, weight: .semibold, lineHeight: 1.1, color: .oklch(0.909, 0.023, 85))
                case .spaced(let tracking):
                    Heading(.one) { config.name }
                        .font(.serif, size: 42, weight: .semibold, tracking: tracking, lineHeight: 1.1, color: .oklch(0.909, 0.023, 85))
                }

                Paragraph { config.tagline }
                    .font(.sans, size: 18, tracking: 2, color: .oklch(0.7, 0.02, 85))

                if !config.description.isEmpty {
                    Paragraph { config.description }
                        .font(.sans, size: 15, lineHeight: 1.6, color: .oklch(0.6, 0.015, 85))
                        .size(maxWidth: 420)
                }
            }
            .flex(.column, gap: 16)

            // Feature bullets
            Stack {
                for feature in config.features {
                    AuthFeatureBullet(icon: feature.icon, text: feature.text, accentColor: config.accentColor)
                }
            }
            .flex(.column, gap: 14)

            // Footer
            Link(to: "https://allegro.systems") { Text { "allegro.systems" } }
                .font(.mono, size: 12, color: .oklch(0.45, 0.01, 85), decoration: TextDecoration.none)
                .hover { $0.font(color: .oklch(0.6, 0.01, 85)) }
        }
        .flex(.column, gap: 48, justify: .center)
        .padding(64, at: .vertical)
        .padding(56, at: .horizontal)
        .flex(grow: 1)
        .htmlAttribute("style", "background: \(config.gradientCSS);")
        .compact { $0.hidden() }
    }
}

/// A single icon + text feature bullet used in ``AuthBrandPanel``.
@Component
public struct AuthFeatureBullet {
    let icon: String
    let text: String
    let accentColor: ColorToken

    public init(icon: String, text: String, accentColor: ColorToken) {
        self.icon = icon
        self.text = text
        self.accentColor = accentColor
    }

    public var body: some Node {
        Stack {
            Icon(icon, size: 18, color: accentColor)
            Text { text }
                .font(.sans, size: 14, color: .oklch(0.82, 0.02, 85))
        }
        .flex(.row, gap: 12, align: .center)
    }
}

// MARK: - Auth Form Panel (Right Side)

/// The right auth form panel of ``AuthLoginPage``.
///
/// Contains the magic link email input, GitHub OAuth button, and passkey
/// button. Fixed at 500pt wide on desktop, full width on compact.
@Component
public struct AuthFormPanel {
    let config: ProductAuthConfig

    public init(product config: ProductAuthConfig) {
        self.config = config
    }

    public var body: some Node {
        Stack {
            // Header + Email form
            Stack {
                Heading(.two) { "Sign in to \(config.name)" }
                    .font(.serif, size: 28, weight: .medium, color: .text)

                Paragraph { "Enter your email to receive a magic link" }
                    .font(.sans, size: 14, color: .muted)

                Text { "EMAIL ADDRESS" }
                    .font(.mono, size: 11, weight: .medium, tracking: 2, color: .muted, transform: .uppercase)
                    .padding(16, at: .top)

                // Email input with icon
                Stack {
                    Icon("mail", size: 18, color: .dimmer)
                    Input(type: .email, name: "email", placeholder: "you@example.com")
                        .htmlAttribute("id", "magic-link-email")
                        .font(.sans, size: 14)
                        .flex(grow: 1)
                        .htmlAttribute("style", "background:transparent;border:none;outline:none;color:inherit;width:100%;")
                }
                .flex(.row, gap: 10, align: .center)
                .padding(0, at: .vertical)
                .padding(16, at: .horizontal)
                .size(height: 48)
                .background(.elevated)
                .border(width: 1, color: .border, style: .solid, radius: 8)

                // Send Magic Link button — uses product accent
                Button(type: .button) {
                    Stack {
                        Icon("wand-sparkles", size: 16, color: .bg)
                        Text { "Send Magic Link" }
                    }
                    .flex(.row, gap: 8, align: .center, justify: .center)
                }
                .htmlAttribute("id", "magic-link-btn")
                .htmlAttribute("style", "cursor:pointer;")
                .font(.sans, size: 14, weight: .semibold, color: .bg)
                .size(width: .percent(100))
                .padding(14, at: .vertical)
                .background(config.accentColor)
                .radius(8)
                .border(width: 0, color: .border, style: .none)
                .hover { $0.opacity(0.85) }
            }
            .flex(.column, gap: 12)

            Paragraph { "" }
                .htmlAttribute("id", "magic-link-status")
                .font(.sans, size: 13, color: .muted)

            // Divider
            AuthDivider()

            // OAuth + Passkey buttons
            Stack {
                // GitHub button with inline SVG (Lucide doesn't include brand icons)
                Link(to: "/auth/oauth/github/login") {
                    Stack {
                        RawTextNode(Self.githubSVG)
                        Text { "Continue with GitHub" }
                    }
                    .flex(.row, gap: 10, align: .center, justify: .center)
                }
                .font(.sans, size: 14, color: .text, decoration: TextDecoration.none)
                .size(width: .percent(100))
                .padding(14, at: .vertical)
                .border(width: 1, color: .border, style: .solid, radius: 8)
                .flex(.row, align: .center, justify: .center)
                .hover { $0.background(.elevated) }

                AuthPasskeyButton()
            }
            .flex(.column, gap: 12)
        }
        .flex(.column, gap: 32, justify: .center)
        .padding(56, at: .horizontal)
        .background(.surface)
        .size(width: 500)
        .flex(shrink: 0)
        .compact { $0.size(width: .percent(100)) }
    }

    private static let githubSVG = """
        <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M12 0C5.374 0 0 5.373 0 12c0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23A11.509 11.509 0 0112 5.803c1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576C20.566 21.797 24 17.3 24 12c0-6.627-5.373-12-12-12z"/></svg>
        """
}

// MARK: - Shared Sub-components

/// A horizontal "or" divider used between auth methods in ``AuthFormPanel``.
@Component
public struct AuthDivider {
    public init() {}

    public var body: some Node {
        Stack {
            Stack {}.size(height: 1).background(.border).flex(grow: 1)
            Text { "or" }
                .font(.mono, size: 11, tracking: 2, color: .dimmer)
            Stack {}.size(height: 1).background(.border).flex(grow: 1)
        }
        .flex(.row, gap: 16, align: .center)
    }
}

/// A full-width outlined button with a Lucide icon, used for OAuth providers.
///
/// ```swift
/// AuthOutlineButton(icon: "github", label: "Continue with GitHub", link: "/auth/oauth/github/login")
/// ```
@Component
public struct AuthOutlineButton {
    let icon: String
    let label: String
    let link: String

    public init(icon: String, label: String, link: String) {
        self.icon = icon
        self.label = label
        self.link = link
    }

    public var body: some Node {
        Link(to: link) {
            Stack {
                Icon(icon, size: 18, color: .text)
                Text { label }
            }
            .flex(.row, gap: 10, align: .center, justify: .center)
        }
        .font(.sans, size: 14, color: .text, decoration: TextDecoration.none)
        .size(width: .percent(100))
        .padding(14, at: .vertical)
        .border(width: 1, color: .border, style: .solid, radius: 8)
        .flex(.row, align: .center, justify: .center)
        .hover { $0.background(.elevated) }
    }
}

/// A full-width outlined button that triggers WebAuthn passkey authentication.
@Component
public struct AuthPasskeyButton {
    public init() {}

    public var body: some Node {
        Button(type: .button) {
            Stack {
                Icon("key-round", size: 18, color: .text)
                Text { "Continue with Passkey" }
            }
            .flex(.row, gap: 10, align: .center, justify: .center)
        }
        .htmlAttribute("id", "passkey-btn")
        .font(.sans, size: 14, weight: .regular, color: .text)
        .size(width: .percent(100))
        .padding(14, at: .vertical)
        .htmlAttribute("style", "background:transparent;cursor:pointer;")
        .border(width: 1, color: .border, style: .solid, radius: 8)
        .flex(.row, align: .center, justify: .center)
        .hover { $0.background(.elevated) }
    }
}
