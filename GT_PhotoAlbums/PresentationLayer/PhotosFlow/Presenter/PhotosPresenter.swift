//
//  PhotosPresenter.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

protocol PhotosPresenter: BasePresenter {
    var album: PhotoAlbumViewItem! { get set }
    func showPhoto(with urlString: String)
}

class PhotosPresenterImpl: PhotosPresenter {
    var interactor: PhotosInteractor!
    weak var view: PhotosView!
    var router: PhotosRouter!
    var mapper: PhotosMapper!
    var album: PhotoAlbumViewItem! {
        didSet { view.update(title: album.name) }
    }
    
    func viewDidLoad() {
        interactor.fetchPhotos(album: album.id, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(entities):
                let viewItems = self.mapper.transform(input: entities)
                self.view.update(photos: viewItems)
            case let .failure(.facebookError(message)):
                self.view.onError(with: message)
            case let .failure(error):
                self.view.onError(with: error.localizedDescription)
            }
        })
    }
    
    func showPhoto(with urlString: String) {
        router.showPhoto(with: urlString)
    }
}
