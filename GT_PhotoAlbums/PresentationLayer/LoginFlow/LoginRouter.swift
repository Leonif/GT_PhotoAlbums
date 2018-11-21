//
//  LoginRouter.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/10/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

import UIKit

protocol LoginRouter: BaseRouter {
    func showAlbums()
}

class LoginRouterImpl: LoginRouter {
    
    private var vc: BaseView!
    
    init(vc: BaseView) {
        self.vc = vc
    }
    
    func showAlbums() {
        
        let albumView = PhotoAlbumAssembler().assemble()
        
        let view = UINavigationController(rootViewController: albumView)
        
        presentController(fromModule: vc, to: view)
    }
}
