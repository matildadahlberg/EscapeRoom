import Foundation

class Image {
    
    var imageName : String
    
    init(imageName : String) {
        self.imageName = imageName
    }
    
    let key1 = Image(imageName: "key1")
    let key2 = Image(imageName: "key2")
}
