//
//  DetailViewController.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var fullResImage: UIImage? = nil
    
    @IBOutlet weak var DetailViewImageViewController: UIImageView!
        
    @IBAction func saveImageBtn(_ sender: AnyObject) {
        if fullResImage != nil {
            UIImageWriteToSavedPhotosAlbum(fullResImage!, nil, nil, nil)
        }
    }
    
    
    var post: WallpaperPost!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = post.author
        
        
        let url = NSURL(string: post.imgURL)
        if let data = NSData(contentsOf:url as! URL) {
            fullResImage = UIImage(data: data as Data)
            DetailViewImageViewController.image = fullResImage
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
