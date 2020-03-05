//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Brandon Hancock on 3/2/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import Foundation

enum Method: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {
    private static let baseURLString = "https://www.flickr.com/services/rest"
    
    private static let apiKey = "a160c6879256e6f0f0deba9e0a0b9d19"
    
    private static func flickrURL(method: Method,
                                  parameters: [String:String]?) -> URL {
        
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            
            queryItems.append(item)
        }
        
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
    
    static var interestingPhotosURL: URL {
        return flickrURL(method: .interestingPhotos,
                         parameters: ["extras" : "url_h, date_taken"])
    }
}
