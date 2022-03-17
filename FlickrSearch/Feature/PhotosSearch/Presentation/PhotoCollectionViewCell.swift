//
//  PhotoCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    @IBOutlet weak var photoImageView: UIImageView!

    func setup(with photo: PhotoModel){
        self.photoImageView.image = nil
        guard let farm = photo.farm,
                let server = photo.server,
                let id = photo.id,
                let secret = photo.secret else {
            self.photoImageView.image = #imageLiteral(resourceName: "unknown")
            return
        }
        self.photoImageView.setImageWithURL(url: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
    }
}
