//
//  FSTracksCollectionViewController.swift
//  SoundCloudSwift
//
//  Created by SilentObserver on 06/06/2019.
//  Copyright © 2019 Nathan Furman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TheCell"


class FSTracksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var tracks = Array<FSTrack>()
    private var dataSource = FSDataSource()
    private var collectionView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: self.collectionView.bounds.width - 20, height: 73)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "FSTrackCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        collectionView.clipsToBounds = true
        self.title = "Loading..."
        dataSource.delegate = self
        dataSource.getTracks()
    }
    

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FSTrackCollectionViewCell
        
        let track = tracks[indexPath.row]
        if let _ = track.title {
            cell.lblTitle.text = track.title
        }
        if let _ = track.poster {
            cell.ivPoster.loadImageUsingCache(withUrl: track.poster!)
            
        } else {
            cell.ivPoster.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
}

extension FSTracksViewController: FSDataSourceDelegate {
    func dataSourceDidRetrieveTracks(tracks: [FSTrack]) {
        self.tracks = tracks
        DispatchQueue.main.async {
            self.title = "\(tracks.count) tracks"
            self.collectionView.reloadData()
        }
    }
    
    func dataSourceDidFail(error: NSError) {
        //
    }
    
    
    
}

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = NSCache<NSString, AnyObject>().object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    NSCache<NSString, AnyObject>().setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}
