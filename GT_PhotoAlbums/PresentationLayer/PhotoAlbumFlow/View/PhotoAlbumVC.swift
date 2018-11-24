//
//  PhotoAlbumVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

protocol PhotoAlbumView: BaseView {
}

class PhotoAlbumVC: UIViewController, PhotoAlbumView {
    var presenter: PhotoAlbumPresenter!
    var interactor: PhotoAlbumInteractor!
    var adapter: PhotoAdapter<PhotoCell, PhotoViewItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func close() { }
}
