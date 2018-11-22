//
//  FaceboookAPI.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

class FacebookApi: BackendInterface {
    var manager: LoginManager!
    
    init(manager: LoginManager) {
        self.manager = manager
    }
    
    func fetchUserAlbums() {
        let request = GraphRequest(graphPath: "/me/albums",
                             httpMethod: .GET)
        request.start { (response, result) in
            switch result {
            case let .success(response: response):
                debugPrint(response)
            case let .failed(error):
                debugPrint(error)
            }
        }
    }
    
    
    func login(callback: @escaping (BackendResult<Void>) -> Void) {
        self.manager.logIn(readPermissions: [.publicProfile, .userPhotos], viewController: nil) { (result) in
            switch result {
            case .failed(let error):
                callback(ResultType.failure(.loginError(error.localizedDescription)))
            case .cancelled:
                callback(ResultType.failure(.loginError("user cancel enter")))
            case .success:
                self.fetchUserAlbums()
                callback(ResultType.success(()))
            }
        }
    }
}
