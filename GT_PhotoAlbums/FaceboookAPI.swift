//
//  FaceboookAPI.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation

class FacebookApi: BackendInterface {
    func login(callback: (BackendResult<Void>) -> Void) {
        callback(ResultType.success(()))
    }
}
