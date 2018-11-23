//
//  Helpers.swift
//  DataLayer
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

func unbox<T: Parceable>(from object: JSONObject) -> T {
    return T(object: object)
}
