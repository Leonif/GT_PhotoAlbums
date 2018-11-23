//
//  PhotoAlbumListInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

protocol PhotoAlbumListInteractor {
    func fetchAlbumList(completion: @escaping (LoginRepositoryResult<Void>) -> Void)
}

class PhotoAlbumListInteractorImpl: PhotoAlbumListInteractor {
    
    var repository: PhotoAlbumListRepository!
    
    func fetchAlbumList(completion: @escaping (LoginRepositoryResult<Void>) -> Void) {
        repository.fetchAlbumList { (result) in
            debugPrint(result)
        }
    }
}

