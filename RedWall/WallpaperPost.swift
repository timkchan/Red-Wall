//
//  WallpaperPost.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class WallpaperPost {
    var id: String = ""
    var author: String = ""
    var thumbnailURL: String = ""
    var imgURL: String = ""
    var ups: Int = 0
    var downs: Int = 0
    
    init(id: String, author: String, thumbnailURL: String, imgURL: String, ups: Int, downs: Int ) {
        self.id = id
        self.author = author
        self.thumbnailURL = thumbnailURL
        self.imgURL = imgURL
        self.ups = ups
        self.downs = downs
    }
    
    convenience init(copies wallpaperPost: WallpaperPost) {
        self.init(id: wallpaperPost.id, author: wallpaperPost.author, thumbnailURL: wallpaperPost.thumbnailURL, imgURL: wallpaperPost.imgURL, ups: wallpaperPost.ups, downs: wallpaperPost.downs)
    }
    
    func toString() {
        print(self.id)
        print(self.author)
        print(self.thumbnailURL)
        print(self.imgURL)
        print(self.ups)
        print(self.downs)
    }
}
