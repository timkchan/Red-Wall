//
//  wallpaperCollectionViewController.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class WallpaperCollectionViewController: UICollectionViewController {
    
    //data source
    
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

                                        print("------------------------------------")
                                        print(itemD["data"] as! NSDictionary)
                                        

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
        return 30 // TK: to be modified.
    }
    
    private struct Storyboard {
        static let CellIdentifier = "WallpaperCell"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as UICollectionViewCell
        
        return cell
    }
    
}
