import UIKit

class AvatarImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 3.0
    }
}
