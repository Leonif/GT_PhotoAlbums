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
}

class PhotoAlbumListAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var datasource: [PhotoAlbumViewItem] = [] {
        didSet { eventHandler?(.update) }
    }
    var eventHandler: EventHandler<PhotoAlbumListAdapterEvent>?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoAlbumCell = collectionView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
}
