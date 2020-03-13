//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Brandon Hancock on 3/2/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import Foundation
import CoreData

enum FlickrError: Error {
    case invalidJSONData
}

enum Method: String {
    case interestingPhotos = "flickr.interestingness.getList"
}


struct FlickrAPI {
    private static let baseURLString = "https://www.flickr.com/services/rest"
    
    private static let apiKey = "a160c6879256e6f0f0deba9e0a0b9d19"
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
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
    
    static func photos(fromJSON data: Data, into context: NSManagedObjectContext) -> PhotosResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDictionary = jsonObject as? [AnyHashable: Any],
                let photos = jsonDictionary["photos"] as? [String: Any],
                let photosArray = photos ["photo"] as? [[String: Any]] else {
                    
                    //The JSON didn't match our expectations in terms of structure
                    return .failure(FlickrError.invalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photo(fromJSON: photoJSON, into: context) {
                    finalPhotos.append(photo)
                }
            }
            if finalPhotos.isEmpty && !photosArray.isEmpty {
                //We weren't able to parse any photos
                //Maybe the JSON foramt for the photos has changed
                return .failure(FlickrError.invalidJSONData)
            }
            return .success(finalPhotos)
            
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func photo(fromJSON json: [String: Any], into context: NSManagedObjectContext) -> Photo? {
        guard let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from: dateString) else {
                
                //We don't have enough information to construct a photo, so return nil
                return nil
        }
        var photo: Photo!
        context.performAndWait {
            photo = Photo(context: context)
            photo.title = title
            photo.photoID = photoID
            photo.remoteURL = url as NSURL
            photo.dateTaken = dateTaken as NSDate as Date
        }
        return photo
    }
}
