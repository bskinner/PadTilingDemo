import UIKit


class ImagesViewModel: NSObject {
    var images: [NSIndexPath:[UIImage]] = [:]
    
    override init() {
        
    }
    
    subscript(indexPath: NSIndexPath) -> [UIImage]? {
        get {
            if let images = self.images[indexPath] {
                return images
            } else {
                return nil
            }
        }
        
        set(newValue) {
            images[indexPath] = newValue
        }
    }
    
    func numberOfImages() -> Int {
        return self.images.count
    }
}
