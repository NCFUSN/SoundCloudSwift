//
//  FSTrackCollectionViewCell.swift
//  SoundCloudSwift
//
//  Created by SilentObserver on 06/06/2019.
//  Copyright © 2019 Nathan Furman. All rights reserved.
//

import UIKit

class FSTrackCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivPoster.layer.cornerRadius = ivPoster.frame.height/2
        ivPoster.clipsToBounds = true
    }

}
