//
//  ResponseValidator.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation

class ResponseValidator{
    
    func responseWithValidation(response: URLResponse?, data: Data?, error: Error?, objectMapper: ObjectMapper) -> (responseStatus: ResponseStatus, responseData: [String: AnyObject]){
        
        guard error == nil && response != nil else {
            return (.error, defaultErrorDictionary())
        }
        guard let httpStatus = response as? HTTPURLResponse else {
            return (.error, defaultErrorDictionary())
        }
        
        let httpStatusCode = httpStatus.statusCode
        let jsonData = objectMapper.getJSON(from: data)
        
        switch httpStatusCode {
        case 200:
            return (.success, jsonData ?? [:])
        default:
            return (.error, defaultErrorDictionary())
        }
    }
    
    private func defaultErrorDictionary() -> [String : AnyObject] {
        var defaultError = [String : AnyObject]()
        defaultError[AppConstants.DEFAULT_ERROR_KEY] = "default_error_message".localized as AnyObject?
        return defaultError
    }
}
