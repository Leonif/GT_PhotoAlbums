//
//  PhotosInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotosInteractor {
    func fetchPhotos(album id: String, completion: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void)
}

class PhotosInteractorImpl: PhotosInteractor {
    
    var repository: PhotoRepository!
    var presenter: PhotosPresenter!
    
    func fetchPhotos(album id: String, completion: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void) {
        repository.fetchPhotos(album: id) { (result) in
            switch result {
            case let .success(entities):
                completion(PhotoRepositoryResult.success(entities))
            case let .failure(error):
                completion(PhotoRepositoryResult.failure(error))
            }
        }
    }
}
