import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reset()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    func reset() {

    }

}
