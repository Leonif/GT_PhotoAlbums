//
//  LoginAssembler.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/9/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

import UIKit
import DataLayer
import FacebookLogin

class LoginAssembler {
    
    func assemble() -> UIViewController {
        let view = LoginVC.initFromStoryboard()
        let presenter = LoginPresenterImpl()
        view.presenter = presenter
        presenter.view = view
        
        let manager = LoginManager()
        
        let repository = LoginCloudRepository(manager)
        let interactor = LoginInteractorImpl()
        interactor.repository = repository
        
        let router = LoginRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
