//
//  LoginViewProtocol.swift
//  myXL
//
//  Created by Aleph-VHV29 on 25/09/24.
//

import UIKit

protocol MyLoginViewProtocol: AnyObject {
    func navigateToOTP(with msisdn: String)
    func displayError(message: String)
}


