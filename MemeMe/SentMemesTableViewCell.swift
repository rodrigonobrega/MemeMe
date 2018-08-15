//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Rodrigo on 12/08/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMemed: UIImageView!
    @IBOutlet weak var labelDescription:UILabel!

    var meme:Meme? {
        didSet {
            self.imageMemed.image = meme?.memedImage
            self.labelDescription.text = "\(meme!.top!) ... \(meme!.bottom!)"
        }
    }
    

}
