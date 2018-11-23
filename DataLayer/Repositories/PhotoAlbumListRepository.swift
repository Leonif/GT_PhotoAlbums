//
//  PhotoAlbumListRepository.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookCore

public typealias JSONObject = [String: Any]

public enum PhotoAlbumListRepositoryError: Error {
}

public typealias PhotoAlbumListResult<T> = ResultType<T, PhotoAlbumListRepositoryError>

public protocol PhotoAlbumListRepository {
    func fetchAlbumList(callback: @escaping (PhotoAlbumListResult<[PhotoAlbumEntity]>) -> Void)
    func fetchPhotoWith(id: String, callback: @escaping (PhotoAlbumListResult<PhotoEntity>) -> Void)
}

public class PhotoAlbumListCloudRepository: PhotoAlbumListRepository {
    public init() { }
    
    public func fetchAlbumList(callback: @escaping (PhotoAlbumListResult<[PhotoAlbumEntity]>) -> Void) {
        let albumListRequest = GraphRequest(graphPath: "/me/albums",
                                   parameters: ["fields": "id, name, cover_photo"],
                                   httpMethod: .GET)
        albumListRequest.start { (response, result) in
            switch result {
            case let .success(response: response):
                guard
                    let dict = response.dictionaryValue,
                    let data = dict["data"] as? [JSONObject] else { return }
                
                let output: [PhotoAlbumEntity] = data.map { unbox(from: $0) }
                callback(PhotoAlbumListResult.success(output))
            case let .failed(error):
                debugPrint(error)
            }
        }
    }
        
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoAlbumListResult<PhotoEntity>) -> Void) {
        let request = GraphRequest(graphPath: id,
                                   parameters: ["fields": "link"],
                                    httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                debugPrint(response)
            case let .failed(error):
                debugPrint(error)
            }
        }
    }
}
