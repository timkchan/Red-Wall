//
//  WallpaperCollectionViewCell.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class WallpaperCollectionViewCell: UICollectionViewCell {
    
    
    
    func downloadedFrom(link: String, imageView:UIImageView, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                imageView.image = image
            }
            }.resume()
    }
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var wallpaperAuthorLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var wallpaperPost: WallpaperPost? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        // TO-DO Update Image
        
        wallpaperAuthorLabel.text = wallpaperPost?.author
        downloadedFrom(link: (wallpaperPost?.thumbnailURL)!, imageView: thumbnailImageView)
        
    }
}
