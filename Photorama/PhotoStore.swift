//
//  PhotoStore.swift
//  Photorama
//
//  Created by Jennifer Tigner on 2016-03-17.
//  Copyright © 2016 Jennifer Tigner. All rights reserved.
//

import Foundation

//to initiate the web service requests
class PhotoStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion completion: (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume() // b/c tasks are always called in suspended state
    }
    
    // method to process JSON data returned from the web service request
    func processRecentPhotosRequest(data data: NSData?, error: NSError?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(jsonData)
    }
}

