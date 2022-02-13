//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Кристина Максимова on 08.02.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCurrentCoin(_ coin: CoinData)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "B3E096B6-7C6C-4013-BF6B-6BB3704FA70D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    
    func performRequest(with url: String) {
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            if let data = data {
                if let currentCoin = parseJSON(data: data) {
                    delegate?.didUpdateCurrentCoin(currentCoin)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decode = try decoder.decode(CoinModel.self, from: data)
            let rate = decode.rate
            let quote = decode.asset_id_quote
            let curentCoin = CoinData(rate: rate, quote: quote)
            return curentCoin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
