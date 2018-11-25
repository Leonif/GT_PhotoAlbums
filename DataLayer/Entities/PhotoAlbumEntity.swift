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
    public var coverImage: UIImage?
    public var link: String? {
        get { return coverPhoto?.link }
        set { coverPhoto?.link = newValue }
    }
    
    public var coverPhotoId: String? {
        return coverPhoto?.id
    }
    
    var coverPhoto: PhotoEntity?
    
    init(id: String, name: String, coverImage: UIImage, coverPhotoId: String? = nil) {
        self.id = id
        self.name = name
        self.coverImage = coverImage
    }
    
    public init(object: JSONObject) {
        id = object["id"] as? String
        name = object["name"] as? String
        coverImage = nil
        
        guard let object = object["cover_photo"] as? JSONObject
            else {
                coverPhoto = nil
                return
        }
        coverPhoto = unbox(from: object)
    }
}

