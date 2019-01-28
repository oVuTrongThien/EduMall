import Foundation

let langEN = "en"

class LocalizationHelper {

    static let shared = LocalizationHelper()
    private var enBundle: Bundle?

    init() {
        if let enBundlePath = Bundle.main.path(forResource: langEN, ofType: "lproj") {
            enBundle = Bundle(path: enBundlePath)
        }
    }

    func localized(_ key: String) -> String {
        var bundle: Bundle?
        switch Preferences.shared.currentLocale() {
        case langEN:
            bundle = enBundle
        default:
            break
        }
        guard let currentBundle = bundle else { return "" }
        return NSLocalizedString(key, tableName: nil, bundle: currentBundle, value: key, comment: key)
    }

    func en(_ key: String) -> String {
        return NSLocalizedString(key, tableName: nil, bundle: enBundle!, value: key, comment: key)
    }

    func localized(_ key: String, _ locale: String) -> String {
        var bundle: Bundle?
        switch locale {
        case langEN:
            bundle = enBundle
        default:
            break
        }
        guard let currentBundle = bundle else { return "" }
        return NSLocalizedString(key, tableName: nil, bundle: currentBundle, value: key, comment: key)
    }

}
