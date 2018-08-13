//
//  Meme.swift
//  MemeMe
//
//  Created by Rodrigo on 12/08/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

/// MARK: - Struct Meme used to save and Struct constants values
//
//struct Meme {
//    var top:String!
//    var bottom:String!
//    var image: UIImage
//    var memedImage: UIImage
//    var imageData:Data!
//    var memedImageData:Data!
//}

class Meme: NSObject, NSCoding {

    var top:String!
    var bottom:String!
    var image: UIImage!
    var memedImage: UIImage!
//    var imageData:Data!
//    var memedImageData:Data!
    
    init(top: String,
        bottom: String,
        image: UIImage,
        memedImage: UIImage
        
        ) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
//        self.imageData = imageData
//        self.memedImageData = memedImageData
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let top = aDecoder.decodeObject(forKey: "top") as! String
        let bottom = aDecoder.decodeObject(forKey: "bottom") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! UIImage
        let memedImage = aDecoder.decodeObject(forKey: "memedImage") as! UIImage
//        let imageData = aDecoder.decodeObject(forKey: "imageData") as! Data
//        let memedImageData = aDecoder.decodeObject(forKey: "memedImageData") as! Data
        
        
        self.init(top: top, bottom: bottom, image: image, memedImage: memedImage)//, imageData: imageData, memedImageData: memedImageData)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(top, forKey: "top")
        aCoder.encode(bottom, forKey: "bottom")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(memedImage, forKey: "memedImage")
        //aCoder.encode(imageData, forKey: "imageData")
//        aCoder.encode(memedImageData, forKey: "memedImageData")
    }
}
