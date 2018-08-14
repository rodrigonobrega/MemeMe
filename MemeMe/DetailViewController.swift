//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Rodrigo on 14/08/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme:Meme?
    
    @IBOutlet weak var imageMeme: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageMeme.image = meme?.memedImage
    }

}
