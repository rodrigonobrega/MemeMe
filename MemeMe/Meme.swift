//
//  Meme.swift
//  MemeMe
//
//  Created by Rodrigo on 12/08/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

/// MARK: - Struct Meme used to save and Struct constants values

class Meme: NSObject, NSCoding {

    var top:String!
    var bottom:String!
    var image: UIImage!
    var memedImage: UIImage!
    
    private static let kTopKey = "top"
    private static let kBottomKey = "bottom"
    private static let kImageKey = "image"
    private static let kMemedImageKey = "memedImage"
    
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
    }
    
    
    // MARK: - Using NSCoding for tests, saving NSData in UserDefaults
    required convenience init(coder aDecoder: NSCoder) {
        
        let top = aDecoder.decodeObject(forKey: Meme.kTopKey) as! String
        let bottom = aDecoder.decodeObject(forKey: Meme.kBottomKey) as! String
        let image = aDecoder.decodeObject(forKey: Meme.kImageKey) as! UIImage
        let memedImage = aDecoder.decodeObject(forKey: Meme.kMemedImageKey) as! UIImage

        self.init(top: top, bottom: bottom, image: image, memedImage: memedImage)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(top, forKey: Meme.kTopKey)
        aCoder.encode(bottom, forKey: Meme.kBottomKey)
        aCoder.encode(image, forKey: Meme.kImageKey)
        aCoder.encode(memedImage, forKey: Meme.kMemedImageKey)
    }
}
