//
//  PhotoAlbumListVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotoAlbumListView: BaseView {
    func update(albums: [PhotoAlbumViewItem])
}

class PhotoAlbumListVC: UIViewController, PhotoAlbumListView {
    var presenter: PhotoAlbumListPresenter!
    var interactor: PhotoAlbumListInteractor!
    var adapter: PhotoAlbumListAdapter!
    @IBOutlet private var collectionView: UICollectionView!
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        setupCollectionView()
        
        adapter.eventHandler = { [weak self] event in
            switch event {
            case .update: self?.collectionView.reloadData()
            }
        }
    }
    
    func update(albums: [PhotoAlbumViewItem]) {
        adapter.datasource = albums
    }

    func close() { }
}
