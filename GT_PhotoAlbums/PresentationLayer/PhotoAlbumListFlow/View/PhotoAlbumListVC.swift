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
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var layout: UICollectionViewFlowLayout!
    
    var presenter: PhotoAlbumListPresenter!
    var interactor: PhotoAlbumListInteractor!
    var adapter: PhotoAlbumListAdapter!
    
    
    fileprivate func setupCollectionView() {
        collectionView.register(PhotoAlbumCell.self)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        adapter.layout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        navigationItem.title = "Albums"
        
        setupCollectionView()
        eventBinding()
    }
    
    func update(albums: [PhotoAlbumViewItem]) {
        adapter.datasource = albums
    }
    
    private func eventBinding() {
        adapter.eventHandler = { [weak self] event in
            switch event {
            case .update:
                self?.collectionView.reloadData()
            case let .selected(item):
                debugPrint(item.id)
            }
        }
    }

    func close() { }
}
