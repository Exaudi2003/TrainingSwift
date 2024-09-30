//
//  LoginRouter.swift
//  myXL
//
//  Created by Aleph-VHV29 on 25/09/24.
//

import UIKit

class LoginRouter {
    static func createModule() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view)
        view.presenter = presenter
        return view
    }
}

