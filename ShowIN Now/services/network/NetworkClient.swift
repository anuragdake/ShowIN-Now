//
//  NetworkClient.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation

public class NetworkClient{
    
    let responseValidator: ResponseValidator!
    let objectMapper: ObjectMapper!
    let networkChecker: NetworkChecker!
    
    init() {
        responseValidator = ResponseValidator()
        objectMapper = ObjectMapper()
        networkChecker = NetworkChecker()
    }
    
    /**
     Perform GET network request.
     */
    public func doGETRequest(requestURL: String, params: [String:AnyObject]?,httpBody:[String:AnyObject]?, completionHandler:@escaping (_ status: ResponseStatus, _ response: [[String:AnyObject]]) -> Void){
        if networkChecker.isConnectedToNetwork(){
            doNetworkRequest(requestType: "GET", requestURL: requestURL, params: params,httpBody: httpBody, completionHandler: completionHandler)
        }else{
            completionHandler(.error, networkNotConnectedDictionary())
        }
    }
    
    /**
     Perform POST network request.
     */
    public func doPOSTRequest(requestURL: String, params: [String:AnyObject]?,httpBody:[String:AnyObject]?, completionHandler:@escaping (_ status: ResponseStatus, _ response: [[String:AnyObject]]) -> Void){
        if networkChecker.isConnectedToNetwork(){
            doNetworkRequest(requestType: "POST", requestURL: requestURL, params: params,httpBody: httpBody, completionHandler: completionHandler)
        }else{
            completionHandler(.error, networkNotConnectedDictionary())
        }
    }
    
    private func doNetworkRequest(requestType: String, requestURL: String, params: [String:AnyObject]?, httpBody:[String:AnyObject]?, completionHandler:@escaping (_ status: ResponseStatus,_ response: [[String:AnyObject]]) -> Void){
        let request = NSMutableURLRequest()
        request.url = URL.init(string: requestURL)
        request.httpMethod = requestType
        setRequestParams(request: request, params: params,httpBody: httpBody)
        createDataTask(with: request, completionHandler: completionHandler)
    }
    
    private func setRequestParams(request: NSMutableURLRequest, params: [String:AnyObject]?,httpBody:[String:AnyObject]?){
        do {
            if let httpBody = httpBody,  httpBody.count > 0 {
                let httpBodyString = (httpBody.flatMap({ (key, value) -> String in
                    return "\(key)=\(value)"
                }) as Array).joined(separator: "&")
                let encodedUrl = httpBodyString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                request.httpBody = encodedUrl?.data(using: .utf8, allowLossyConversion: true)
            }
        }
        if let params = params,  params.count > 0 {
            var urlWithParam = (request.url?.absoluteString)! + "?"
            for (index,param) in params.enumerated() {
                urlWithParam.append("\(param.key)=\(param.value)")
                if index < (params.count - 1){
                    urlWithParam.append("&")
                }
            }
            let encodedUrl = urlWithParam.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            request.url = URL(string: encodedUrl ?? "")
        }
    }
    
    private func createDataTask(with request: NSMutableURLRequest, completionHandler:@escaping (_ status: ResponseStatus, _ response: [[String:AnyObject]]) -> Void){
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let validatedResponse = self.responseValidator.responseWithValidation(response: response, data: data, error: error, objectMapper: self.objectMapper)
            completionHandler(validatedResponse.responseStatus, validatedResponse.responseData)
            
        }
        task.resume()
    }
    
    private func networkNotConnectedDictionary() -> [[String:AnyObject]]{
        var networkErrorDictionary = [String:AnyObject]()
        networkErrorDictionary["title"] = "network_error_title".localized as AnyObject?
        networkErrorDictionary["message"] = "network_error_message".localized as AnyObject?
        return [networkErrorDictionary]
    }
}
