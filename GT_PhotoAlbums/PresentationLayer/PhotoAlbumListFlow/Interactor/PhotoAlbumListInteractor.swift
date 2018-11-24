//
//  PhotoAlbumListInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumListInteractor {
    func fetchAlbumList(completion: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void)
}

class PhotoAlbumListInteractorImpl: PhotoAlbumListInteractor {
    
    var repository: PhotoAlbumRepository!
    var presenter: PhotoAlbumListPresenter!
    
    func fetchAlbumList(completion: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void) {
        repository.fetchAlbumList { (result) in
            switch result {
            case let .success(entities):
                completion(PhotoAlbumResult.success(entities))
            case let .failure(error):
                completion(PhotoAlbumResult.failure(error))
            }
        }
        
        
//        repository.testOperation { (result) in
//            debugPrint(result)
//        }
    }
}

