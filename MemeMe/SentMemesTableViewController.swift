//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Rodrigo on 12/08/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    private let reuseIdentifier = "MemesTableViewCell"
    private let detailViewControllerIdentifier = "detailViewControllerID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return memes().count
    }
    
    func memes() -> [Meme] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.memes
        }
        return [Meme]()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SentMemesTableViewCell
        
        cell.imageMemed.image = memes()[indexPath.row].memedImage

        return cell
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as! DetailViewController
//
//
//        detailViewController.meme = self.memes()[indexPath.row]
//
//        //Push to the scene
//        navigationController?.pushViewController(detailViewController, animated: true)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as? DetailViewController
        detailController?.meme = self.memes()[(self.tableView.indexPathForSelectedRow?.row)!]
    }

}
