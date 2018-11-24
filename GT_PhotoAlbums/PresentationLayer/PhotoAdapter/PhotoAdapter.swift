//
//  PhotoAlbumListAdapter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit


enum PhotoAdapterEvent<Item> {
    case update
    case selected(Item)
}

protocol Configurable {
    associatedtype Item
    func config(item: Item)
}

class PhotoAdapter<Cell: UICollectionViewCell, Item>:
    NSObject, UICollectionViewDelegate, UICollectionViewDataSource
    where Cell: NibLoadableReusable & Configurable, Cell.Item == Item {
    
    var datasource: [Item] = [] {
        didSet { eventHandler?(.update) }
    }
    
    private var columns: CGFloat
    
    var layout: UICollectionViewFlowLayout? {
        didSet {
            let padding: CGFloat = 2
            var width = UIScreen.main.bounds.size.width / columns
            width -= (padding * (columns - 1))
            layout?.itemSize = CGSize(width: width, height: width)
            layout?.minimumLineSpacing = padding
            layout?.minimumInteritemSpacing = padding
        }
    }
    
    init(columns: CGFloat) {
        self.columns = columns
        super.init()
    }
    
    var eventHandler: EventHandler<PhotoAdapterEvent<Item>>?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(for: indexPath)
        
        let item = getItem(for: indexPath)
        cell.config(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = getItem(for: indexPath)
        eventHandler?(.selected(item))
    }
    
    private func getItem(for indexPath: IndexPath) -> Item {
        return datasource[indexPath.row]
    }
}
