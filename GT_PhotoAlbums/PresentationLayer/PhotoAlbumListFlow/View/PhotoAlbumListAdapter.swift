//
//  PhotoAlbumListAdapter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit


enum PhotoAlbumListAdapterEvent {
    case update
    case selected(PhotoAlbumViewItem)
}

class PhotoAlbumListAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var datasource: [PhotoAlbumViewItem] = [] {
        didSet { eventHandler?(.update) }
    }
    
    var layout: UICollectionViewFlowLayout? {
        didSet {
            let padding: CGFloat = 2
            let columns: CGFloat = 2
            var width = UIScreen.main.bounds.size.width / columns
            width -= (padding * (columns - 1))
            layout?.itemSize = CGSize(width: width, height: width)
            layout?.minimumLineSpacing = padding
            layout?.minimumInteritemSpacing = padding
        }
    }
    
    var eventHandler: EventHandler<PhotoAlbumListAdapterEvent>?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoAlbumCell = collectionView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource[indexPath.row]
        eventHandler?(.selected(item))
    }
}
