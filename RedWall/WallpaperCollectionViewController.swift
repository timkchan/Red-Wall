//
//  wallpaperCollectionViewController.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit
import CoreData

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
                                    let imgURL = (((((post["preview"] as? NSDictionary)?["images"] as? NSArray)?[0] as? NSDictionary)?["source"] as? NSDictionary)?["url"]) as! String
                                        
                                    let wp = WallpaperPost(id: id, author: author, thumbnailURL: thumbnailURL, imgURL: imgURL, ups: ups, downs: downs)
                                    
                                    
                                    
                                    print("------------------------------------")
                                    wp.toString()
                                    
                                    
                                    
                                    
//                                    let newPost = NSEntityDescription.insertNewObject(forEntityName: "Post", into: context)
//                                    
//                                    newPost.setValue(id, forKey: "id")
//                                    
//                                    do {
//                                        try context.save()
//                                        print("saved")
//                                    } catch {
//                                        print("error when saving into CoreData")
//                                    }
                                
                                    self.bank.append(wp)
                                    
                                    
//                                    var indexes = [IndexPath]()
//                                    for i in 0 ..< self.bank.count {
//                                        indexes.append(IndexPath(row: i, section: 0))
//                                    }
//                                    self.collectionView?.performBatchUpdates({
//                                        self.bank.append(wp)
//                                        self.collectionView?.insertItems(at: indexes)
//                                        }, completion: nil)
                                    

                                }
                                self.collectionView?.reloadData()
                                
                            }
                        }
                    } catch {
                        print("JSON processing failed")
                    }
                }
            }
        }
        
        task.resume()
        
        
        // Setup the layout of collection view
        let width = (collectionView!.frame.width - leftAndRightPaddings * (numberOfItemsPerRow + 1)) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width - heightAdjustment)
        
        
        
    }
    
    
    // MARK: - UICollectionView Data source
    // Number of sections.
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Number of items in each section.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bank.count // TK: to be modified.
    }
    
    private struct Storyboard {
        static let CellIdentifier = "WallpaperCell"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! WallpaperCollectionViewCell
        print("XXX")
        
        if bank.count > 0 {
            cell.wallpaperPost = self.bank[indexPath.row]
        }
        
        return cell
    }
    
    

    
}
