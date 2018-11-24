//
//  PhotoAlbumCell.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

class PhotoAlbumCell: UICollectionViewCell, NibLoadableReusable {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    func config(item: PhotoAlbumViewItem) {
        titleLabel.text = item.name
        imageView.downloadImage(for: item.urlString!)
    }
}