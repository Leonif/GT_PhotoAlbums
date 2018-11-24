//
//  PhotoAlbumInfo.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

public struct PhotoAlbumEntity: Parceable {
    public let id: String?
    public let name: String?
    public var link: String? {
        get { return coverPhoto?.link }
        set { coverPhoto?.link = newValue }
    }
    
    public var coverPhotoId: String? {
        return coverPhoto?.id
    }
    
    var coverPhoto: PhotoEntity?
    
    public init(object: JSONObject) {
        id = object["id"] as? String
        name = object["name"] as? String
        
        guard let object = object["cover_photo"] as? JSONObject
            else {
                coverPhoto = nil
                return
        }
        coverPhoto = unbox(from: object)
    }
}

