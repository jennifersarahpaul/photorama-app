//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Jennifer Tigner on 2016-03-17.
//  Copyright © 2016 Jennifer Tigner. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos.")
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
    }
}
