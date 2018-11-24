//
//  PhotoAlbumInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumInteractor {
    func fetchPhotos(album id: String, completion: @escaping (PhotoAlbumResult<[PhotoEntity]>) -> Void)
}

class PhotoAlbumInteractorImpl: PhotoAlbumInteractor {
    
    var repository: PhotoAlbumRepository!
    var presenter: PhotoAlbumPresenter!
    
    func fetchPhotos(album id: String, completion: @escaping (PhotoAlbumResult<[PhotoEntity]>) -> Void) {
        repository.fetchPhotos(album: id) { (result) in
            switch result {
            case let .success(entities):
                completion(PhotoAlbumResult.success(entities))
            case let .failure(error):
                completion(PhotoAlbumResult.failure(error))
            }
        }
    }
}
