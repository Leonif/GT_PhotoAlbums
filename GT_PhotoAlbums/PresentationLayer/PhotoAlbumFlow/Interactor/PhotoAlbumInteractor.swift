//
//  PhotoAlbumInteractor.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import DataLayer

protocol PhotoAlbumInteractor {
    func fetchAlbumList(completion: @escaping (PhotoAlbumListResult<Void>) -> Void)
}

class PhotoAlbumInteractorImpl: PhotoAlbumInteractor {
    
    var repository: PhotoAlbumListRepository!
    
    func fetchAlbumList(completion: @escaping (PhotoAlbumListResult<Void>) -> Void) {
        repository.fetchAlbumList { (result) in
            debugPrint(result)
        }
    }
}
