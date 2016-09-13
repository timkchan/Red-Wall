//
//  WallpaperPost.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class WallpaperPost : NSObject, NSCoding {
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
    
    required init(coder aDecoder: NSCoder) {
        
        self.id = aDecoder.decodeObject(forKey: "id") as! String;
        self.author = aDecoder.decodeObject(forKey: "author") as! String;
        self.thumbnailURL = aDecoder.decodeObject(forKey: "thumbnailURL") as! String;
        self.imgURL = aDecoder.decodeObject(forKey: "imgURL") as! String;
        if let uu = aDecoder.decodeObject(forKey: "ups") {
            self.ups = uu as! Int
        }
        if let dd = aDecoder.decodeObject(forKey: "downs") {
            self.downs = dd as! Int
        }
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id");
        aCoder.encode(self.author, forKey: "author");
        aCoder.encode(self.thumbnailURL, forKey: "thumbnailURL");
        aCoder.encode(self.imgURL, forKey: "imgURL");
        aCoder.encode(self.ups, forKey: "ups");
        aCoder.encode(self.downs, forKey: "downs");
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
