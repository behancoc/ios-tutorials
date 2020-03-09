//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Brandon Hancock on 3/2/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSouce = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSouce  
        
        store.fetchInterestingPhotos {(photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos")
                
                self.photoDataSouce.photos = photos
                
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSouce.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
}
