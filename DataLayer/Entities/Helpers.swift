//
//  Helpers.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//
public protocol Parceable {
    init(object: JSONObject)
}

func unbox<T: Parceable>(from object: JSONObject) -> T {
    return T(object: object)
}
