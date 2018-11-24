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
    var mapper: PhotoAlbumListMapper!
    
    func viewDidLoad() {
        interactor.fetchAlbumList { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(albumEntities):
                let viewItems = self.mapper.transform(input: albumEntities)
                self.view.update(albums: viewItems)
            case let .failure(error):
               self.view.onError(with: error.localizedDescription)
            }
        }
    }
    
    
    func showPhotoAlbum() {
        router.showAlbum()
    }
}
