//
//  PhotoAlbumVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotosView: BaseView {
    func update(title: String)
    func update(photos: [PhotoViewItem])
}

class PhotosVC: UIViewController, PhotosView {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var layout: UICollectionViewFlowLayout!
    
    var presenter: PhotosPresenter!
    var interactor: PhotosInteractor!
    var adapter: PhotoGridAdapter<PhotoCell, PhotoViewItem>!
    
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
                self?.presenter.showPhoto(with: item.urlString)
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
