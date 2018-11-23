//
//  LoginPresenter.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/9/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

protocol LoginPresenter: BasePresenter {
    func login()
}

class LoginPresenterImpl: LoginPresenter {
    func viewDidLoad() {}
    
    var interactor: LoginInteractor!
    weak var view: LoginVC!
    var router: LoginRouter!
    
    func login() {
        interactor.login { [weak self] (result) in
            switch result {
            case .success:
                self?.router.showAlbumList()
            case let .failure(.loginError(message)):
                self?.view.onError(with: message)
            }
        }
    }
}
