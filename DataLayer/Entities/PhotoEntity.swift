//
//  PhotoEntity.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

public struct PhotoEntity: Parceable {
    public let id: String?
    public var link: String?
    
    public init(object: JSONObject) {
        id = object["id"] as? String
        link = nil
    }
}
