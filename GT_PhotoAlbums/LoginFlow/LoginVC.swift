//
//  LoginVC.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/9/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

import UIKit
import FacebookLogin

protocol LoginView: BaseView {
}

class LoginVC: UIViewController, LoginView {
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        
        self.view.backgroundColor = .red
        
        
//        presenter.login()
    }
    func close() { }

}
