import Score

/// A primary action button with accent background.
///
/// Renders a `<button type="button">` with the theme accent color. Use in
/// forms and action panels where a prominent call-to-action is needed.
///
/// ```swift
/// SubmitButton(label: "Save Changes", id: "save-btn")
/// ```
///
/// - Parameters:
///   - label: The button text.
///   - id: Optional HTML `id` attribute.
///   - onclick: Optional inline click handler (prefer `@Action` when possible).
@Component
public struct SubmitButton {
    let label: String
    let id: String
    let onclick: String

    public init(label: String, id: String = "", onclick: String = "") {
        self.label = label
        self.id = id
        self.onclick = onclick
    }

    public var body: some Node {
        Button(type: .button) {
            Text { label }
        }
        .htmlAttribute("id", id)
        .htmlAttribute("onclick", onclick)
        .font(.sans, size: 14, weight: .semibold, color: .bg)
        .padding(10, at: .horizontal)
        .padding(8, at: .vertical)
        .background(.accent)
        .radius(6)
    }
}

/// A full-width variant of ``SubmitButton``.
///
/// Identical styling to ``SubmitButton`` but stretches to 100% of its
/// container width. Useful for login forms and modal actions.
///
/// ```swift
/// SubmitButtonWide(label: "Send Magic Link", id: "magic-link-btn")
/// ```
///
/// - Parameters:
///   - label: The button text.
///   - id: Optional HTML `id` attribute.
///   - onclick: Optional inline click handler (prefer `@Action` when possible).
@Component
public struct SubmitButtonWide {
    let label: String
    let id: String
    let onclick: String

    public init(label: String, id: String = "", onclick: String = "") {
        self.label = label
        self.id = id
        self.onclick = onclick
    }

    public var body: some Node {
        Button(type: .button) {
            Text { label }
        }
        .htmlAttribute("id", id)
        .htmlAttribute("onclick", onclick)
        .font(.sans, size: 14, weight: .semibold, color: .bg)
        .padding(12, at: .horizontal)
        .padding(10, at: .vertical)
        .background(.accent)
        .radius(6)
        .size(width: .percent(100))
    }
}

/// A secondary action button with outline styling.
///
/// Renders a bordered button on a surface background with muted text.
/// Use alongside ``SubmitButton`` for lower-priority actions like "Cancel".
///
/// ```swift
/// SecondaryButton(label: "Cancel", id: "cancel-btn")
/// ```
///
/// - Parameters:
///   - label: The button text.
///   - id: Optional HTML `id` attribute.
///   - onclick: Optional inline click handler (prefer `@Action` when possible).
@Component
public struct SecondaryButton {
    let label: String
    let id: String
    let onclick: String

    public init(label: String, id: String = "", onclick: String = "") {
        self.label = label
        self.id = id
        self.onclick = onclick
    }

    public var body: some Node {
        Button(type: .button) {
            Text { label }
        }
        .htmlAttribute("id", id)
        .htmlAttribute("onclick", onclick)
        .font(.sans, size: 13, weight: .medium, color: .muted)
        .padding(8, at: .horizontal)
        .padding(6, at: .vertical)
        .background(.surface)
        .radius(6)
        .border(width: 1, color: .border, style: .solid)
    }
}
