import Foundation

class Preferences {
    private static let kCurrentLocale       = "CurrentLocale"
    private static let kDefaultLocale       = AppLanguage.vn.name

    static let shared = Preferences()

    func currentLocale() -> String {
        if let locale = UserDefaults.standard.value(forKey: Preferences.kCurrentLocale) as? String {
            return locale
        }
        return Preferences.kDefaultLocale
    }

    func initLocale() {
        if UserDefaults.standard.value(forKey: Preferences.kCurrentLocale) == nil {
            var defaultLanguage: String = Preferences.kDefaultLocale
            if let preferredLanguage = NSLocale.preferredLanguages[0] as String?,
                preferredLanguage.hasPrefix(AppLanguage.vn.name) {
                defaultLanguage = AppLanguage.vn.name
            }
            UserDefaults.standard.set(defaultLanguage, forKey: Preferences.kCurrentLocale)
            UserDefaults.standard.synchronize()
        }
    }

    func setCurrentLocale(_ locale: String) {
        UserDefaults.standard.set(locale, forKey: Preferences.kCurrentLocale)
        UserDefaults.standard.synchronize()
    }
}
