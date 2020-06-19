//
//  CoinData.swift
//  ByteCoin
//
//  Created by Mero on 2020-05-09.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable
{
    let asset_id_quote: String
    let rate: Double
}
