import Score

/// A horizontal usage bar showing a label, a value label, and a fill indicator.
///
/// The bar tracks are identified by HTML IDs so client-side JS can set
/// the fill width and label text dynamically.
///
/// Use `idPrefix` for the common pattern where fill and label IDs share a prefix:
/// ```swift
/// UsageBar(title: "Storage", idPrefix: "usage-storage")
/// // fill ID: "usage-storage-fill", label ID: "usage-storage-label"
/// ```
///
/// Or supply explicit IDs:
/// ```swift
/// UsageBar(title: "Storage", fillId: "my-fill", labelId: "my-label")
/// ```
@Component
public struct UsageBar {
    let title: String
    let fillId: String
    let labelId: String
    let fillColor: ColorToken
    let trackColor: ColorToken

    /// Creates a usage bar using an ID prefix for the fill and label elements.
    ///
    /// - Parameters:
    ///   - title: The label shown above the bar (e.g. "Storage", "Bandwidth").
    ///   - idPrefix: Common prefix. Fill ID becomes `"\(idPrefix)-fill"`, label ID becomes `"\(idPrefix)-label"`.
    ///   - fillColor: Color of the fill bar. Defaults to `.accent`.
    ///   - trackColor: Color of the track background. Defaults to `.surface`.
    public init(title: String, idPrefix: String, fillColor: ColorToken = .accent, trackColor: ColorToken = .surface) {
        self.title = title
        self.fillId = "\(idPrefix)-fill"
        self.labelId = "\(idPrefix)-label"
        self.fillColor = fillColor
        self.trackColor = trackColor
    }

    /// Creates a usage bar with explicit element IDs.
    ///
    /// - Parameters:
    ///   - title: The label shown above the bar.
    ///   - fillId: HTML `id` for the fill element (set its width via JS to update).
    ///   - labelId: HTML `id` for the value label element (set its textContent via JS).
    ///   - fillColor: Color of the fill bar. Defaults to `.accent`.
    ///   - trackColor: Color of the track background. Defaults to `.surface`.
    public init(title: String, fillId: String, labelId: String, fillColor: ColorToken = .accent, trackColor: ColorToken = .surface) {
        self.title = title
        self.fillId = fillId
        self.labelId = labelId
        self.fillColor = fillColor
        self.trackColor = trackColor
    }

    public var body: some Node {
        Stack {
            Stack {
                Text { title }
                    .font(.sans, size: 13, weight: .medium, color: .text)
                Text { "\u{2014}" }
                    .htmlAttribute("id", labelId)
                    .font(.mono, size: 12, color: .muted)
            }
            .flex(.row, gap: 0, align: .center, justify: .spaceBetween)

            Stack {
                Stack {}
                    .htmlAttribute("id", fillId)
                    .size(height: 6)
                    .radius(3)
                    .background(fillColor)
            }
            .size(height: 6)
            .radius(3)
            .background(trackColor)
        }
        .flex(.column, gap: 6)
    }
}
