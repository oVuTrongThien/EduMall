import Foundation
import UIKit

extension String {

    var localized: String {
        return LocalizationHelper.shared.localized(self)
    }

    func localizedWithComment(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }

    static func isNullOrEmpty(_ string: String?) -> Bool {
        return string == nil ||
            string?.trimmingCharacters(in: .whitespacesAndNewlines)
            .caseInsensitiveCompare("") == .orderedSame
    }

    func getLabelHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.size.height
    }

    func getLabelWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.size.width
    }

    static func formatNumber(number: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value: number))
    }

    func getUnderLineAttributedText(withColor color: UIColor) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: mutableString.length)
        mutableString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        mutableString.addAttributes([.foregroundColor: color], range: range)
        return mutableString
    }

    func rangeOf(_ string: String) -> NSRange {
        let copySelf = self as NSString
        return copySelf.range(of: string)
    }

    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

}
