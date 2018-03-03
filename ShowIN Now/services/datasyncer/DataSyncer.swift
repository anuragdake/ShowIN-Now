//
//  DataSyncer.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import Foundation
import CoreData

class DataSyncer: Operation{
    var delegate: DataSyncDelegate?
    let mainManagedObjectContext: NSManagedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    private var isSyncError = false
    private var syncUrl = ""
    
    public init(managedObjectContext: NSManagedObjectContext, urlString: String, syncDelegate: DataSyncDelegate?) {
        mainManagedObjectContext = managedObjectContext
        delegate = syncDelegate
        syncUrl = urlString
        super.init()
    }
    
    override public func main() {
        if self.isCancelled { return }
        managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = mainManagedObjectContext
        callSyncApi()
    }
    
    /**
     Get data from server
     */
    private func callSyncApi(){
        let networkClient = NetworkService.sharedInstance.networkClient
        networkClient?.doGETRequest(requestURL: syncUrl, params: nil,httpBody:nil, completionHandler: { (status, response) -> Void in
            switch status {
            case .success:
                self.storeData(response: response)
                self.checkForSyncError()
                self.updateUIThread(status: true, errorTitle: nil, errorMessage: nil)
            case .error:
                self.updateUIThread(status: false, errorTitle: nil, errorMessage: "default_error_message".localized)
            }
        })
    }
    
    func storeData(response:[[String:AnyObject]]) {
        managedObjectContext.performAndWait {
            self.storeShowsData(data: response)
        }
    }
    
    private func checkForSyncError(){
        if isSyncError{
            managedObjectContext.rollback()
        }
    }
    
    private func storeShowsData(data: [[String : AnyObject]]?){
        let showsRepo = ShowRepo(managedContext: mainManagedObjectContext)
        
        if !showsRepo.deleteAllShows() {
            isSyncError = true
        }
        if !showsRepo.createShows(showsArray: data ?? []){
            isSyncError = true
        }
    }
    
    private func updateUIThread(status:Bool, errorTitle:String?, errorMessage:String?){
        DispatchQueue.main.async{
            self.delegate?.onDataSyncComplete(status: status, errorTitle: errorTitle, errorMessage: errorMessage)
        }
    }
    
}
