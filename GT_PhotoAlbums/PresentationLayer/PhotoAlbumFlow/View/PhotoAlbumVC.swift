//
//  PhotoAlbumVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotoAlbumView: BaseView {
    func update(title: String)
    func update(photos: [PhotoViewItem])
}

class PhotoAlbumVC: UIViewController, PhotoAlbumView {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var layout: UICollectionViewFlowLayout!
    
    var presenter: PhotoAlbumPresenter!
    var interactor: PhotoAlbumInteractor!
    var adapter: PhotoAdapter<PhotoCell, PhotoViewItem>!
    
    private func setupCollectionView() {
        collectionView.register(PhotoCell.self)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        adapter.layout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupCollectionView()
        eventBinding()
    }
    
    func update(title: String) {
        navigationItem.title = "Album: \(title)"
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
    
    func update(photos: [PhotoViewItem]) {
        adapter.datasource = photos
    }
    
    func close() {
        navigationController?.popViewController(animated: true)
    }
}
