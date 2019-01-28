import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    func reset() {

    }
}
