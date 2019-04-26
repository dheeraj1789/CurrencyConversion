//
//  ApiHandler.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//
import Foundation

struct ApiService {

    static let shared = ApiService()
    
    

    func fetchApiData(urlString: String, completion: @escaping (String?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        print("Endpoint url: \(url)")
        print("*************")
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to get data:", err)
                return
            }
       if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                     completion(jsonString)
                }
            }
        
        }.resume()

    }


 
}
