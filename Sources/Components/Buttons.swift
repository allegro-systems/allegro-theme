import Score

/// A styled submit/action button.
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

/// A full-width submit button variant.
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

/// A secondary/outline action button.
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
