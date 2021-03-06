//
//  PhotoAlbumListRepository.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookCore

public typealias JSONObject = [String: Any]

public class PhotoCloudRepository: PhotoRepository {
    public init() { }
    
    public func fetchAlbumList(callback: @escaping (PhotoRepositoryResult<[PhotoAlbumEntity]>) -> Void) {
        let request = GraphRequest(graphPath: "/me/albums",
                                   parameters: ["fields": "id, name, cover_photo"],
                                   httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                guard
                    let dict = response.dictionaryValue,
                    let data = dict["data"] as? [JSONObject] else {
                        callback(PhotoRepositoryResult.failure(.unknown("Some unpredictable happen 💩")))
                        return
                }
                
                let output: [PhotoAlbumEntity] = data.map { unbox(from: $0) }
                callback(PhotoRepositoryResult.success(output))
            case .failed:
                callback(PhotoRepositoryResult.failure(.facebookError("Facebook access info is restricted ")))
            }
        }
    }
    
    public func fetchPhotoWith(id: String, callback: @escaping (PhotoRepositoryResult<String>) -> Void) {
        let params: [String: Any] = ["fields": "link, picture.type(large)"]
        
        let request = GraphRequest(graphPath: id,
                                   parameters: params,
                                    httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                guard let link = response.dictionaryValue!["picture"] as? String else { fatalError() }
                callback(PhotoRepositoryResult.success(link))
            case .failed:
                callback(PhotoRepositoryResult.failure(.facebookError("Facebook access info is restricted ")))
            }
        }
    }
    
    public func fetchPhotos(album id: String, callback: @escaping (PhotoRepositoryResult<[PhotoEntity]>) -> Void) {
        let params: [String: Any] = ["fields": "link, picture"]
        
        let request = GraphRequest(graphPath: "\(id)/photos",
                                            parameters: params,
                                            httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                guard
                    let dict = response.dictionaryValue,
                    let data = dict["data"] as? [JSONObject] else { return }
                
                let output: [PhotoEntity] = data.map { unbox(from: $0) }
                callback(PhotoRepositoryResult.success(output))
            case .failed:
                callback(PhotoRepositoryResult.failure(.facebookError("Facebook access info is restricted ")))
            }
        }
    }
}
