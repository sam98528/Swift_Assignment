import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension Int {
    static func addCommas(to number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}

extension Notification.Name {
    static let bookAdd = Notification.Name("bookAdd")
    static let bookDelete = Notification.Name("bookDelete")
    static let bookRead = Notification.Name("bookRead")
}


