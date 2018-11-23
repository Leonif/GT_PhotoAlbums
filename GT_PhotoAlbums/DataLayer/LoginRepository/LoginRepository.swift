//
//  LoginFlowProvider.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookLogin


protocol LoginRepository {
    func login(callback: @escaping (LoginRepositoryResult<Void>) -> Void)
}


enum LoginRepositoryError: Error {
    case loginError(String)
}


typealias LoginRepositoryResult<T> = ResultType<T, LoginRepositoryError>


class LoginCloudRepository: LoginRepository {
    
    var manager: LoginManager!
    
    init(_ manager: LoginManager) {
        self.manager = manager
    }
    
    func login(callback: @escaping (LoginRepositoryResult<Void>) -> Void) {
        self.manager.logIn(readPermissions: [.publicProfile, .userPhotos], viewController: nil) { (result) in
            switch result {
            case .failed(let error):
                callback(LoginRepositoryResult.failure(.loginError(error.localizedDescription)))
            case .cancelled:
                callback(LoginRepositoryResult.failure(.loginError("user cancel enter")))
            case .success:
                callback(LoginRepositoryResult.success(()))
            }
        }
    }
}
