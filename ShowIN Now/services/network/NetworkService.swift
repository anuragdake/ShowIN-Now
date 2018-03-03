//
//  NetworkService.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation

public class NetworkService {
    
    public static let sharedInstance = NetworkService()
    public let networkClient: NetworkClient?
    
    private init() {
        networkClient = NetworkClient()
    }
    
}
