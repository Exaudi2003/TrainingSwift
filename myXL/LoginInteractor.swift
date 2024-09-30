//
//  LoginInteractor.swift
//  myXL
//
//  Created by Aleph-VHV29 on 25/09/24.
//

import Foundation

// Protokol Interactor untuk mengambil data dan menyimpan MSISDN
protocol LoginInteractorProtocol: AnyObject {
    func saveMsisdn(msisdn: String)
    func fetchBitcoinPrice(completion: @escaping (Double?) -> Void)
}

class LoginInteractor: LoginInteractorProtocol {
    
    // Fungsi untuk menyimpan nomor HP
    func saveMsisdn(msisdn: String) {
        //  menyimpan ke UserDefaults atau database lokal
        UserDefaults.standard.set(msisdn, forKey: "savedMsisdn")
        print("MSISDN disimpan: \(msisdn)")
    }

    // Fungsi untuk mengambil harga Bitcoin dari API
    func fetchBitcoinPrice(completion: @escaping (Double?) -> Void) {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/BTC.json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let bpi = json["bpi"] as? [String: Any],
                   let usd = bpi["USD"] as? [String: Any],
                   let rate = usd["rate_float"] as? Double {
                    completion(rate) 
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
