//
//  LoginFlowProvider.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/23/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import FacebookLogin
import FacebookCore

public protocol LoginRepository {
    func login(callback: @escaping (LoginRepositoryResult<Void>) -> Void)
}

public enum LoginRepositoryError: Error {
    case loginError(String)
}

public typealias LoginRepositoryResult<T> = ResultType<T, LoginRepositoryError>

public class LoginCloudRepository: LoginRepository {
    
    var manager: LoginManager!
    
    public init(_ manager: LoginManager) {
        self.manager = manager
    }
    
    public func login(callback: @escaping (LoginRepositoryResult<Void>) -> Void) {
        
        if AccessToken.current != nil {
            callback(LoginRepositoryResult.success(()))
            return
        }
        
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
