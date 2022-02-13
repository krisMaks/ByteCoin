//
//  CoinData.swift
//  ByteCoin
//
//  Created by Кристина Максимова on 08.02.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData {
    let rate: Double
    let quote: String
    
    var rateTo: String {
        return String(format: "%.1f", rate)
    }
    var coinImageString: String {
        switch quote {
        case "AUD": return "dollarsign.circle"
        case "BRL": return "brazilianrealsign.circle"
        case "CAD": return "dollarsign.circle"
        case "CNY": return "yensign.circle"
        case "EUR": return "eurosign.circle"
        case "GBP": return "sterlingsign.circle"
        case "HKD": return "dollarsign.circle"
        default: return "rublesign.circle"
            
        }
    }
}
