//
//  wallpaperCollectionViewController.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit
import CoreData

// Faved Lst
var favedPosts = [WallpaperPost]()
var userDefaults = UserDefaults.standard

class WallpaperCollectionViewController: UICollectionViewController {
    
    // Data source
    var bank = [WallpaperPost]()
    
    // Constrants for collection view layout
    private let leftAndRightPaddings: CGFloat = 8.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    private let heightAdjustment: CGFloat = 50.0
    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved Fav Lst into favedPosts
        loadSavedFavLst()
        
        // Fetch Json data and filled bank
        populateBank()
        
        // Setup the layout of collection view
        let width = (collectionView!.frame.width - leftAndRightPaddings * (numberOfItemsPerRow + 1)) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width - heightAdjustment)
    }
    
    
    // MARK: - UICollectionView OVERRIDES
    // Number of sections.
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Number of items in each section.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bank.count
    }
    
    // For quick reference back to the cell and segue
    private struct Storyboard {
        static let CellIdentifier = "WallpaperCell"
        static let ShowDetailViewSegue = "ShowDetailViewSegue"
        static let ShowFavViewSegue = "ShowFavViewSegue"
    }
    
    // Load Cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! WallpaperCollectionViewCell
        
        if bank.count > 0 && cell.wallpaperPost == nil {
            cell.wallpaperPost = self.bank[indexPath.row]
        }
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    // Load Detail View when an image is clicked.
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = bank[indexPath.row]
        self.performSegue(withIdentifier: Storyboard.ShowDetailViewSegue, sender: post)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailViewSegue" {
            let secondVC: DetailViewController = segue.destination as! DetailViewController
            secondVC.post = sender as! WallpaperPost
        }
    }

    
    // Function to load saved Fav Lst into favedPosts
    func loadSavedFavLst() {
        if userDefaults.object(forKey: "favs") != nil {
            favedPosts = NSKeyedUnarchiver.unarchiveObject(with: (userDefaults.object(forKey: "favs") as! NSData) as Data) as! [WallpaperPost]
        }
    }
    
    
    // Function to fetch JSON data and parse it in to bank of posts.
    func populateBank() {
        // Fetch Reddit JSON content
        let sourceURL = URL(string: "https://www.reddit.com/r/wallpapers/.json")
        let task = URLSession.shared.dataTask(with: sourceURL!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                if let URLConent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: URLConent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        
                        if let jsonData = jsonResult["data"] as? NSDictionary {
                            if let items = jsonData["children"] as? NSArray {
                                for item in items {
                                    
                                    let itemD:NSDictionary = (item as? NSDictionary)!
                                    
                                    // Finally get down to the post.
                                    let post = itemD["data"] as! NSDictionary
                                    
                                    let id = post["id"] as! String
                                    let author = post["author"] as! String
                                    let thumbnailURL = post["thumbnail"] as! String
                                    let ups = post["ups"] as! Int
                                    let downs = post["downs"] as! Int
                                    var imgURL = "http://photography.timkchan.com/images/s/haley/034.jpg"
                                    if let preview = post["preview"] {
                                        
                                        imgURL = (((((preview as? NSDictionary)?["images"] as? NSArray)?[0] as? NSDictionary)?["source"] as? NSDictionary)?["url"]) as! String
                                        
                                    }
                                    
                                    // Saving each post into the bank.
                                    let wp = WallpaperPost(id: id, author: author, thumbnailURL: thumbnailURL, imgURL: imgURL, ups: ups, downs: downs)
                                    self.bank.append(wp)
                                    
                                    print("------------------------------------")
                                    wp.toString()
                                }
                                
                                // Step out to the main thread to reload (Fixed long load bug).
                                DispatchQueue.main.async {
                                    self.collectionView?.reloadData()
                                }
                            }
                        }
                    } catch {
                        print("JSON processing failed")
                    }
                }
            }
        }
        task.resume()
    }
    
}
