
import UIKit
import SDWebImage

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = #imageLiteral(resourceName: "place-holder")) {
        if let urlString = urlString,
            let url = URL(string: urlString) {
            sd_setShowActivityIndicatorView(false)
            sd_setIndicatorStyle(.gray)
            sd_setImage(with: url,
                             placeholderImage: placeHolder,
                             options: SDWebImageOptions(rawValue: 0),
                             completed: { [weak self] (_, error, _, _) in
                if error != nil {
                    self?.image = placeHolder
                }
            })
        } else {
            self.image = placeHolder
        }
    }

}
