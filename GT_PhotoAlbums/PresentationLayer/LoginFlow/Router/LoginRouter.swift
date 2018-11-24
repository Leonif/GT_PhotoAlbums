//
//  LoginRouter.swift
//  PriceBar
//
//  Created by Leonid Nifantyev on 11/10/18.
//  Copyright © 2018 LionLife. All rights reserved.
//

import UIKit

protocol LoginRouter: BaseRouter {
    func showAlbumList()
}

class LoginRouterImpl: LoginRouter {
    
    private var vc: BaseView!
    
    init(vc: BaseView) {
        self.vc = vc
    }
    
    func showAlbumList() {
        
        let albumView = PhotoAlbumListAssembler().assemble()
        
        
        presentController(fromModule: vc, to: albumView)
    }
}
