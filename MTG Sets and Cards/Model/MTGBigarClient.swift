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
    
    //MARK: Generate URL
   
    class func generateUrl(for expansion: String? = nil) -> URL? {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host =   "cdn.bigar.com"
        components.path =   "/mtg/cardjson/expansions\(expansion ?? "")"
        
        guard let url = components.url else {return nil}
        
        return url
    }
    
    //MARK: Task for GET Request
    
    class func taskForGetRequest(url: URL?, handler: @escaping (JSON?, Error?) -> Void) {
        
        guard let url = url else {return}
        
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                DispatchQueue.main.async {
                    handler(json, nil)
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    handler(nil, error)
                }
            }
        })
    }
}
