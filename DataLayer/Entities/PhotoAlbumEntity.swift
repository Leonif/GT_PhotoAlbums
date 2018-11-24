//
//  PhotoAlbumInfo.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

public struct PhotoEntity: Parceable {
    let id: String?
    var link: String?
    
    public init(object: JSONObject) {
        id = object["id"] as? String
//        link = nil
        link = "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwj33s-fh-3eAhUGjCwKHdo0BfcQjRx6BAgBEAU&url=https%3A%2F%2Fmirpozitiva.ru%2Fphoto%2F1315-kartinki-kotiat-smeshnye.html&psig=AOvVaw3Pz93TmPFKOBnj_-xvTYbQ&ust=1543149833853604"
    }
}

public struct PhotoAlbumEntity: Parceable {
    public let id: String?
    public let name: String?
    public var link: String? {
        return coverPhoto?.link
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

