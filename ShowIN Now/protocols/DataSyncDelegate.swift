//
//  DataSyncDelegate.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation

protocol DataSyncDelegate: class {
    func onDataSyncComplete(status:Bool, errorTitle:String?, errorMessage:String?)
}
