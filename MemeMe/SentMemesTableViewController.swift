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
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.memes().count
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SentMemesTableViewCell
        cell.meme = AppDelegate.memes()[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailController = segue.destination as? DetailViewController
        detailController?.meme = AppDelegate.memes()[(self.tableView.indexPathForSelectedRow?.row)!]
    }

}
