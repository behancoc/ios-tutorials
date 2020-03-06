//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Brandon Hancock on 3/2/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos {(photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos")
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
}
