import Score

/// A standard form field with an uppercase label and a styled text input.
///
/// ```swift
/// FormField(label: "Email", inputId: "settings-email", type: .email, placeholder: "you@example.com")
/// ```
@Component
public struct FormField {
    let label: String
    let inputId: String
    let type: InputType
    let placeholder: String
    let name: String

    /// Creates a form field.
    ///
    /// - Parameters:
    ///   - label: The visible label text (rendered uppercase).
    ///   - inputId: The HTML `id` for the `<input>` element.
    ///   - type: The input type (`.text`, `.email`, etc.).
    ///   - placeholder: Placeholder text shown when the input is empty.
    ///   - name: The HTML `name` attribute. Defaults to `inputId` with any
    ///     `"settings-"` prefix stripped for backward compatibility.
    public init(label: String, inputId: String, type: InputType, placeholder: String, name: String? = nil) {
        self.label = label
        self.inputId = inputId
        self.type = type
        self.placeholder = placeholder
        self.name = name ?? inputId.replacingOccurrences(of: "settings-", with: "")
    }

    public var body: some Node {
        Stack {
            Label(for: inputId) {
                Text { label }
            }
            .font(.mono, size: 11, weight: .medium, tracking: 2, color: .muted, transform: .uppercase)
            Input(type: type, name: name, placeholder: placeholder)
                .htmlAttribute("id", inputId)
                .padding(12, at: .vertical)
                .padding(16, at: .horizontal)
                .font(.sans, size: 14, color: .text)
                .background(.elevated)
                .border(width: 1, color: .border, style: .solid)
                .border(radius:6)
                .outline(width: 0, style: .none, color: .border)
                .placeholder { $0.font(color: .muted) }
        }
        .flex(.column, gap: 8)
    }
}
