//
//  LoginAssembler.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/9/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

import UIKit


class LoginAssembler {
    
    func assemble() -> UIViewController {
        let view = LoginVC.initFromStoryboard()
        let presenter = LoginPresenterImpl()
        view.presenter = presenter
        
        let provider = FacebookApi()
        let interactor = LoginInteractorImpl()
        interactor.provider = provider
        
        let router = LoginRouterImpl(vc: view)
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
}






