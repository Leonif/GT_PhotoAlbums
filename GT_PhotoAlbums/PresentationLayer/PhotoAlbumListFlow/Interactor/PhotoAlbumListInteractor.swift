//
//  PhotoAlbumListInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumListInteractor {
    func fetchAlbumList(completion: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void)
}

class PhotoAlbumListInteractorImpl: PhotoAlbumListInteractor {
    
    var repository: PhotoRepository!
    var presenter: PhotoAlbumListPresenter!
    
    func fetchAlbumList(completion: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        repository.fetchAlbumList { (result) in
            switch result {
            case let .success(entities):
                completion(PhotoRepositoryResult.success(entities))
            case let .failure(error):
                completion(PhotoRepositoryResult.failure(error))
            }
        }
    }
}

