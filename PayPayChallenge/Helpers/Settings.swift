//
//  Setting.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//


class GlobalSettings {
    static let shared = GlobalSettings()
     let ratesExchangeApiKey = "3"
}

struct Routes {
    private static let s = GlobalSettings.shared
    
    static let apiBaseUrl = "https://apilayer.net/api/"
    static let available_country = "\(apiBaseUrl)/list"
    static let conversion_rate = "\(apiBaseUrl)/live"
    static let apiKeyParam = "?access_key=\(s.ratesExchangeApiKey)"
   
}
