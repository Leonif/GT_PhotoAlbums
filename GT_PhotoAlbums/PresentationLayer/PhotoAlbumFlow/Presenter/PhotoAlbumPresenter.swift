//
//  PhotoAlbumPresenter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

protocol PhotoAlbumPresenter: BasePresenter {
    var album: PhotoAlbumViewItem! { get set }
    func showPhotoAlbum()
}

class PhotoAlbumPresenterImpl: PhotoAlbumPresenter {
    var interactor: PhotoAlbumInteractor!
    weak var view: PhotoAlbumView!
    var router: PhotoAlbumRouter!
    var mapper: PhotoAlbumMapper!
    var album: PhotoAlbumViewItem! {
        didSet { view.update(title: album.name) }
    }
    
    func viewDidLoad() {
        interactor.fetchAlbumList { (result) in
            debugPrint(result)
        }
    }
    
    func showPhotoAlbum() {
        router.showAlbum()
    }
}
