//
//  PhotoAlbumListRepository.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookCore


struct PhotoAlbumInfo {
    let name: String
    let coverPhoto: UIImage
}

enum PhotoAlbumListRepositoryError: Error {
    
}

typealias PhotoAlbumListResult<T> = ResultType<T, PhotoAlbumListRepositoryError>

protocol PhotoAlbumListRepository {
    func fetchAlbumList(callback: @escaping (PhotoAlbumListResult<Void>) -> Void)
}

class PhotoAlbumListCloudRepository: PhotoAlbumListRepository {
    func fetchAlbumList(callback: @escaping (PhotoAlbumListResult<Void>) -> Void) {
        let request = GraphRequest(graphPath: "/me/albums",
                                   httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                debugPrint(response)
            case let .failed(error):
                debugPrint(error)
            }
        }
        
            
            //
            //        let request2 = GraphRequest(graphPath: "10205002490527004",
            //                                   httpMethod: .GET)
            //        request2.start { (response, result) in
            //            switch result {
            //            case let .success(response: response):
            //                debugPrint(response)
            //            case let .failed(error):
            //                debugPrint(error)
            //            }
            //        }
            //
            //
            //    }
    }
}
