//
//  DetailViewController.swift
//  RedWall
//
//  Created by Tim Kit Chan on 12/09/16.
//  Copyright © 2016 AppBee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Place holder for the corresponding wall paper post form bank (get transferred to here from segue)
    var post: WallpaperPost!
    
    @IBAction func favAction(_ sender: AnyObject) {
        if !favedPosts.contains(post) {
            favedPosts.append(post)
        }
        dump(favedPosts)
    }
    
    
    // Place holder for the wallpaper
    var fullResImage: UIImage? = nil
    
    @IBOutlet weak var DetailViewImageViewController: UIImageView!
    
    // Action to save wallpaper to camera roll
    @IBAction func saveImageBtn(_ sender: AnyObject) {
        if fullResImage != nil {
            UIImageWriteToSavedPhotosAlbum(fullResImage!, self, #selector(imageSaved), nil)
        }
    }
    
    // Function to prompt user when wallpaper has been saved
    func imageSaved(image: UIImage!, didFinishSavingWithError: NSError!, contextInfo:UnsafeRawPointer) {
        print("Saved")
        let alertController = UIAlertController(title: "Downloaded", message: "Image is saved in camera roll.", preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("Dismiss")
        }
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Nav bar title (Author of post)
        title = post.author
        
        // Show image
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
