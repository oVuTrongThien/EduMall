import UIKit

struct DateFormat {
    static let yyyyssDash = "yyyy-MM-dd HH:mm:ss"
    static let yyyyMddSlash = "yyyy/M/dd"
    static let ddmmSlash = "dd/MM/yyyy HH:mm"
    static let ddMMyyyy = "dd/MM/yyyy"
    static let yyyyMMddDash = "yyyy-MM-dd"
    static let MMyyyy = "MM/yyyy"
    static let yyyyMMdd = "yyyyMMdd"
    static let yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    static let yyyymmSSSZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    static let EEEddMMMyyyyHHmmssz = "EEE',' dd MMM yyyy HH':'mm':'ss z"
    static let EEEdMMMyyyHHmmss = "EEE, d MMM yyyy HH:mm:ss"
    static let yyyyMMddTHHmmssz = "yyyy-MM-dd'T'HH:mm:ssz"
    static let YYYYMMDDHHMMSS = "yyyyMMddHHmmss"
}

struct Region {
    static let vn = "vn"
}

struct MimeType {
    static let imageJpeg = "image/jpeg"
}

struct ExtensionFile {
    static let jpg = ".jpg"
}

struct DeviceType {
    static let IsPhone  = UIDevice.current.userInterfaceIdiom == .phone
    static let IsIpad   = UIDevice.current.userInterfaceIdiom == .pad
}

struct DefaultRatioByScreen {
    static let categoryHeightRatio: CGFloat = 1 / 20
}

struct ScreenSize {
    static let ScreenWidth         = UIScreen.main.bounds.size.width
    static let ScreenHeight        = UIScreen.main.bounds.size.height
    static let ScreenMaxLength     = max(ScreenSize.ScreenWidth, ScreenSize.ScreenHeight)
    static let ScreenMinLength     = min(ScreenSize.ScreenWidth, ScreenSize.ScreenHeight)
}

struct DeviceInfo {

    struct Orientation {
        static var isLandscape: Bool {
            return UIDevice.current.orientation.isValidInterfaceOrientation ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.statusBarOrientation.isLandscape
        }

        static var isPortrait: Bool {
            return UIDevice.current.orientation.isValidInterfaceOrientation ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
        }
    }

}
