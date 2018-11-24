//
//  PhotoCell.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell, NibLoadableReusable, Configurable {

    typealias Item = PhotoViewItem
    @IBOutlet private var imageView: UIImageView!
    
    func config(item: PhotoViewItem) {
        imageView.downloadImage(for: item.urlString)
    }

}
