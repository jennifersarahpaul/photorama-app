//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Jennifer Tigner on 2016-03-17.
//  Copyright © 2016 Jennifer Tigner. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.interestingness.getList"
}

// responsible for knowing and handling all Flick-r related information
struct FlickrAPI {
    //type-level property ('static' for structs, 'class' for classes)
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static func flickrURL(method method: Method, parameters: [String:String]?) -> NSURL {
        let components = NSURLComponents(string: baseURLString)!
        var queryItems = [NSURLQueryItem]()
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.URL!
    }
    
    static func recentPhotosURL() -> NSURL {
        return flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h, data_taken"])
    }
}

