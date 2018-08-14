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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
