//
//  FSTrack.swift
//  SoundCloudSwift
//
//  Created by SilentObserver on 06/06/2019.
//  Copyright © 2019 Nathan Furman. All rights reserved.
//

import Foundation

class FSTrack {
    
    var title: String?
    var poster: String?
    var trackURL: String?
    var id: String?
    var streamable: Bool?
    
    init(dictionary: Dictionary <String, Any>) {
        
        if let _ = dictionary["title"] as? String {
            self.title = dictionary["title"] as? String
        }
        if let _ = dictionary["artwork_url"] as? String {
            self.poster = dictionary["artwork_url"] as? String
        }
        if let _ = dictionary["stream_url"] as? String {
            self.trackURL = dictionary["stream_url"] as? String
        }
        if let _ = dictionary["id"] as? String {
            self.id = dictionary["id"] as? String
        }
        if let _ = dictionary["streamable"] as? NSNumber {
            self.streamable = Bool(truncating: dictionary["streamable"] as! NSNumber)
        }
        
    }
}
