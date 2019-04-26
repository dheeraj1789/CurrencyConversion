//
//  CountryRate.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//

import Foundation
struct CountryRate:Codable
{
    var success:Bool?
    var terms:String?
    var privacy:String?
    var timestamp:Int?
    var source:String?
    var quotes:Dictionary<String,Float>?
}
