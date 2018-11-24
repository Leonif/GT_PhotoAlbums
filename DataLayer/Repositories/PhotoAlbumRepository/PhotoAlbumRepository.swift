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
    case unknown(String)
    case facebookError(String)
}

public typealias PhotoAlbumResult<T> = ResultType<T, PhotoAlbumListRepositoryError>

public protocol PhotoAlbumRepository {
    func fetchAlbumList(callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void)
    func fetchPhotoWith(id: String, callback: @escaping (PhotoAlbumResult<String>) -> Void)
}

public class PhotoAlbumListCloudRepository: PhotoAlbumRepository {
    public init() { }
    
    public func fetchAlbumList(callback: @escaping (PhotoAlbumResult<[PhotoAlbumEntity]>) -> Void) {
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
                callback(PhotoAlbumResult.success(output))
            case .failed:
                callback(PhotoAlbumResult.failure(.facebookError("Facebook access info is restricted ")))
            }
        }
    }
    
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoAlbumResult<String>) -> Void) {
        let request = GraphRequest(graphPath: id,
                                   parameters: ["fields": "link, picture.type(large)"],
                                    httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                guard let link = response.dictionaryValue!["picture"] as? String else { fatalError() }
                callback(PhotoAlbumResult.success(link))
            case .failed:
                callback(PhotoAlbumResult.failure(.facebookError("Facebook access info is restricted ")))
            }
        }
    }
}
