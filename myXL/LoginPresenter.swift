//
//  LoginPresenter.swift
//  myXL
//
//  Created by Aleph-VHV29 on 25/09/24.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func handleLogin(msisdn: String)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: MyLoginViewProtocol?
    var interactor: LoginInteractorProtocol?

    init(view: MyLoginViewProtocol) {
        self.view = view
        self.interactor = LoginInteractor()
    }

    func handleLogin(msisdn: String) {
        // Validasi input nomor HP
        guard !msisdn.isEmpty else {
            view?.displayError(message: "MSISDN tidak boleh kosong")
            return
        }

        // Menyimpan nomor HP
        interactor?.saveMsisdn(msisdn: msisdn)
        
        // Mengambil harga Bitcoin
        interactor?.fetchBitcoinPrice { [weak self] price in
            guard let price = price else {
                self?.view?.displayError(message: "Gagal mengambil harga Bitcoin")
                return
            }
            print("Harga Bitcoin: \(price)")
            
            // Navigasi ke OTPViewController setelah mendapatkan harga Bitcoin
            DispatchQueue.main.async {
                self?.view?.navigateToOTP(with: msisdn)
            }
        }
    }
}
