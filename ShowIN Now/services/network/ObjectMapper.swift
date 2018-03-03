//
//  ObjectMapper.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation

class ObjectMapper: NSObject {
    
    func getJSON(from data:Data?) -> [String:AnyObject]?{
        guard let responseData = data else{
            return nil
        }
        do{
            let responseJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as? [String : AnyObject]
            return responseJSON
        }catch{
            return nil
        }
    }
}
