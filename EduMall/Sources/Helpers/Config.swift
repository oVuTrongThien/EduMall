
struct Config {

    static let databaseVersion              = 1
    static let appId                        = "12345678"
    static let platform                     = "iOS"
    static let policyURL                    = ""

    // MARK: XML

    static let imageDownloadQueueIdentifier = "IMAGE_DOWNLOAD_QUEUE"
    static let thumbDownloadQueueIdentifier = "THUMBNAIL_DOWNLOAD_QUEUE"

    // API URL
    static func apiBaseUrl() -> String {
        return ""
    }

}
