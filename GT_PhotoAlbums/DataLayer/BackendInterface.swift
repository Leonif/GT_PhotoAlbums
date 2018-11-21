//
//  BackendInterface.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/21/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import Foundation


typealias BackendResult<T> = ResultType<T, BackendError>

enum BackendError: Error {
    case loginError(String)
}

protocol BackendInterface {
    func login(callback: @escaping (BackendResult<Void>) -> Void)
}
