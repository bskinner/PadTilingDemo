import UIKit

class ImagesDataSource {
    private let imageURLs: [NSURL]
    private var cachedImages: [NSURL:NSData] = [:]
    
    subscript(index: Int) -> NSURL {
        get {
            return imageURLs[index]
        }
    }
    
    init() {
        var images = ["http://media-cache-ec2.pinimg.com/550x/9c/0f/e1/9c0fe176ef1f226b24731eb146a3dbac.jpg",
            "http://media-cache-ec2.pinimg.com/550x/d6/ac/9a/d6ac9a1527726b66a6bf09de58a0bd4d.jpg",
            "http://media-cache-ec2.pinimg.com/550x/e1/88/c6/e188c6f590a8efec480a89aa43a0fcc5.jpg",
            "http://media-cache-ec2.pinimg.com/550x/df/16/14/df1614ff36e7a2e8074edc289f183079.jpg",
            "http://media-cache-ec2.pinimg.com/550x/35/c8/c3/35c8c38bc204c5a4b120e860b00931e6.jpg",
            "http://media-cache-ec2.pinimg.com/550x/77/cc/a6/77cca60231114f05314c985f1a837f78.jpg",
            "http://media-cache-ec2.pinimg.com/550x/06/20/90/0620905d435affd71631d65d83e258ae.jpg",
            "http://media-cache-ec2.pinimg.com/550x/72/0a/db/720adb486511f15ebbd709e56bb5e78c.jpg",
            "http://media-cache-ec2.pinimg.com/550x/fa/47/7a/fa477a4ecb40aabebb0e4ec1f68c235a.jpg",
            "http://media-cache-ec2.pinimg.com/550x/d9/f9/59/d9f95927b520d97315e06d318a8d9aad.jpg",
            "http://media-cache-ec2.pinimg.com/550x/a9/43/e1/a943e14e62ee54a80304c522d13c3c32.jpg",
            "http://media-cache-ec2.pinimg.com/550x/da/cf/c2/dacfc26accb61c9bcb38ccd8385a606a.jpg",
            "http://media-cache-ec2.pinimg.com/550x/1f/e3/bf/1fe3bfb69634587faecdf7491d897692.jpg",
            "http://media-cache-ec2.pinimg.com/550x/9a/8a/51/9a8a51e1ecc2c671169b4ddfc6412cca.jpg",
            "http://media-cache-ec2.pinimg.com/550x/56/b5/cf/56b5cf7705c32b711ad4098185a1a8a2.jpg",
            "http://media-cache-ec2.pinimg.com/550x/bb/83/39/bb83391215023c097a39d25394f53e10.jpg",
            "http://media-cache-ec2.pinimg.com/550x/10/90/9e/10909e8be81baa477803eb37b26a2576.jpg",
            "http://media-cache-ec2.pinimg.com/550x/ac/35/70/ac3570ec141074f7ab1f1ef03e385082.jpg"]
        
        var urls: [NSURL] = []
        for image in images {
            if let url = NSURL(image) {
                urls.append(url)
            } else {
                println("failed to create URL for string \(image)")
            }
        }
        
        self.imageURLs = urls
    }
    
    func image(index: Int, completion: (image: UIImage?, error: NSError?) -> ()) -> NSURLSessionTask {
        var imageURL = self[index]
        
        if let cachedImage = cachedImages[imageURL] {
            completion(cachedImage, nil)
            return nil
        } else {
            var task = NSURLSession.sharedSession().dataTaskWithURL(imageURL) { data, response, error in
                guard error == nil else {
                    println("request failed with error \(error)")
                    completion(nil,error: error)
                    return
                }
                
                guard let image = UIImage(data) else {
                    println("failed to create image from data for url \(imageURL)")
                    completion(nil,nil)
                    return
                }
                
                cachedImages[imageURL] = image
                completion(image,nil)
            }
            
            task.resume()
            return task
        }
        
    }
}
