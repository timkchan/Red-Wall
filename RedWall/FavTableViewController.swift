//
//  FavTableViewController.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // Number of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favedPosts.count
    }

    // Cell style
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = favedPosts[indexPath.row].author + " - " + favedPosts[indexPath.row].id
        return cell
    }

    // Show detail view of selected image from table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = favedPosts[indexPath.row]
        post.toString()
        self.performSegue(withIdentifier: "ShowTBDetailViewSegue", sender: post)
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTBDetailViewSegue" {
            let secondVC: DetailViewController = segue.destination as! DetailViewController
            secondVC.post = sender as! WallpaperPost
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favedPosts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Save array after deletion
            userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: favedPosts), forKey: "favs")
            userDefaults.synchronize()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
