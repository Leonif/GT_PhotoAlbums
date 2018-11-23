//
//  PhotoAlbumListPresenter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

protocol PhotoAlbumListPresenter: BasePresenter {
    func showPhotoAlbum()
}


class PhotoAlbumListPresenterImpl: PhotoAlbumListPresenter {
    var interactor: PhotoAlbumListInteractor!
    weak var view: PhotoAlbumListView!
    var router: PhotoAlbumListRouter!
    
    func viewDidLoad() {
        interactor.fetchAlbumList { (result) in
            debugPrint(result)
        }
    }
    
    
    func showPhotoAlbum() {
        router.showAlbum()
    }
}
