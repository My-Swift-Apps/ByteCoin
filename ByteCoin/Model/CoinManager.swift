//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

protocol CoinManagerDelegate
{
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

//MARK: - CoinManager

struct CoinManager {
    
    
    var delegate: CoinManagerDelegate?
    
    let baseURL="https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C091C317-E531-46AC-9CEA-11ABD0A6F1BA"
    
    let currencyArray =
        ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice (for currency: String)
    {
        let URL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: URL, currencyValue: currency)
        print(URL)
    }
    
//MARK: - performRequest
    
    func performRequest (with urlString: String, currencyValue currency: String )
    {
        if let url = URL (string: urlString)
        {
            let Session = URLSession(configuration: .default)
            let Task = Session.dataTask(with: url) {(data, response, error)
                in
                if error != nil
                {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data
                {
                    // this function is calling the the parseJSON that will have the infro that we need
                    if let bitcoinPrice = self.parseJSON(safeData)
                    {
                        //Optional: round the price down to 2 decimal places.
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        //Call the delegate method in the delegate (ViewController) and
                        //pass along the necessary data.
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            Task.resume()
        }
    }
    
//MARK: - JASON
    //use BitCoinModel to initialize all the variables 
    func parseJSON (_ bitcoindata: Data) -> Double?
    {
        let decoder = JSONDecoder()
        do
        {
            let DecodedData = try decoder.decode(CoinData.self, from: bitcoindata)
            let lastPrice = DecodedData.rate
            return lastPrice
        }
        catch
        {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
