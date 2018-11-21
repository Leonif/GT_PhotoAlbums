//
//  FaceboookAPI.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation
import FacebookLogin

class FacebookApi: BackendInterface {
    var manager: LoginManager!
    
    init(manager: LoginManager) {
        self.manager = manager
    }
    
    func login(callback: @escaping (BackendResult<Void>) -> Void) {
        self.manager.logIn(readPermissions: [.publicProfile], viewController: nil) { (result) in
            switch result {
            case .failed(let error):
                callback(ResultType.failure(.loginError(error.localizedDescription)))
            case .cancelled:
                callback(ResultType.failure(.loginError("user cancel enter")))
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                callback(ResultType.success(()))
            }
        }
    }
}
