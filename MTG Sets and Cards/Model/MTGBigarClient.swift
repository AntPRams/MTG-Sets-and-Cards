//
//  MTGBigarClient.swift
//  MTG Sets and Cards
//
//  Created by António Ramos on 04/10/2019.
//  Copyright © 2019 ARdev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MTGBigarClient {
   
    class func generateUrl(for expansion: String? = nil) -> URL? {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "cdn.bigar.com"
        components.path = "/mtg/cardjson/expansions\(expansion ?? "")"
        
        guard let url = components.url else {return nil}
        print(url)
        return url
    }
    
    class func taskForGetRequest(url: URL?/*, handler: @escaping ([MTGExpacList]?) -> Void*/) {
        
        guard let url = url else {return}
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            let data = Data(response)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                for expansion in data["allExpansions"].array! {
                    print(expansion["name"].stringValue)
                }
                print("the count is: \(data["allExpansions"].array!.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
