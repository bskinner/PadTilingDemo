import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    var images: [UIImage] = [] {
        didSet {
            self.reloadSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reloadSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        for image in self.images {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = true
            imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            imageView.frame = self.bounds
            self.addSubview(imageView)
        }
    }
}
