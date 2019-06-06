//
//  FSDataSource.swift
//  SoundCloudSwift
//
//  Created by SilentObserver on 06/06/2019.
//  Copyright © 2019 Nathan Furman. All rights reserved.
//

import Foundation

protocol FSDataSourceDelegate:class {
    func dataSourceDidRetrieveTracks(tracks: [FSTrack])
    func dataSourceDidFail(error: NSError)
}

class FSDataSource {
    
    private let session = URLSession.shared
    private let url = URL(string: "https://api.soundcloud.com/tracks?client_id=7447cc9b363c40c4bd203aef5f0410e6")!
    weak var delegate: FSDataSourceDelegate?
    
    public func getTracks() {
        
        var tracks = Array <FSTrack>()
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
               
                self.fail()
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let dictionary = json as? [[String: Any]] {
                    for item in dictionary {
                        let track = FSTrack(dictionary: item)
                        tracks.append(track)
                    }
                    self.delegate?.dataSourceDidRetrieveTracks(tracks: tracks)
                }
                
            } catch {
                self.fail()
                return
            }
        })
        task.resume()
    }
    
    private func fail() {
        let error = NSError(domain: "", code: 0, userInfo: nil)
        self.delegate?.dataSourceDidFail(error: error)
    }
}
