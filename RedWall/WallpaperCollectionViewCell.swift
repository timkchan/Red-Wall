//
//  WallpaperCollectionViewCell.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit


// Content of each cell
class WallpaperCollectionViewCell: UICollectionViewCell {

    // Thumbnail, Author, effect outlet
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var wallpaperAuthorLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    // Update UI when a cell get assigned a post
    var wallpaperPost: WallpaperPost? {
        didSet{
            updateUI()
        }
    }
    
    // Set author name, set thumbnail image
    func updateUI() {
        wallpaperAuthorLabel.text = wallpaperPost?.author
        assignImageViewImageFromImageURL(link: (wallpaperPost?.imgURL)!, imageView: thumbnailImageView)
    }
    

    
    // Set Cell rounded corners
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        self.clipsToBounds = true
    }
    
    // Function to download an image from URL and assign the image to image view
    func assignImageViewImageFromImageURL(link: String, imageView:UIImageView, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
}
