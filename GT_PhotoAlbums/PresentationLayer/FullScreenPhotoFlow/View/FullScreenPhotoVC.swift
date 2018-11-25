//
//  FullScreenPhotoVC.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit
import DataLayer

protocol FullScreenPhotoView: BaseView {
    func update(urlString: String)
}

class FullScreenPhotoVC: UIViewController, FullScreenPhotoView {
    @IBOutlet private var imageView: UIImageView!
    var presenter: FullScreenPhotoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func update(urlString: String) {
        self.imageView.downloadImage(for: urlString)
    }
    
    func close() {
        navigationController?.popViewController(animated: true)
    }
}
