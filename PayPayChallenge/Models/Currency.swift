//
//  Currency.swift
//  EcbCurrencyConverter
//
//  Created by Vassilis Voutsas on 31/07/2018.
//  Copyright © 2018 Vassilis Voutsas. All rights reserved.
//

struct Currency: Decodable {
    var success:Bool?
    var terms:String?
    var privacy:String?
    var currencies:Dictionary<String,String>?
}
