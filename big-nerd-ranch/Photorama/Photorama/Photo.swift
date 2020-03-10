//
//  Photo.swift
//  Photorama
//
//  Created by Brandon Hancock on 3/4/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
    
    
}

extension Photo: Equatable {
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        //Two photos are the same if they have the same photo id
        return lhs.photoID == rhs.photoID
    }
}
