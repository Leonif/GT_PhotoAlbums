//
//  LoginInteractor.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/9/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

protocol LoginInteractor {
    func login(completion: @escaping (LoginRepositoryResult<Void>) -> Void)
}

class LoginInteractorImpl: LoginInteractor {
    
    var repository: LoginRepository!
    
    func login(completion: @escaping (LoginRepositoryResult<Void>) -> Void) {
        repository.login { (result) in
            completion(result)
        }
    }
}
