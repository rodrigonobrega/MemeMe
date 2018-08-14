//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Rodrigo on 12/08/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemesCollectionViewCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var space:CGFloat = 3.0
        var dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        if (!UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            space = 1.0
            dimension = (view.frame.size.width - (1 * space)) / 5
        }
        
        self.flowLayout.minimumInteritemSpacing = space
        self.flowLayout.minimumLineSpacing = space
        self.flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppDelegate.memes().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemesCollectionViewCell
        cell.meme = AppDelegate.memes()[indexPath.row]
        return cell
    }
    
//    func memes() -> [Meme] {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            return appDelegate.memes
//        }
//        return [Meme]()
//    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as? DetailViewController
        detailController?.meme = AppDelegate.memes()[(self.collectionView?.indexPathsForSelectedItems?.first?.row)!]
    }

}
