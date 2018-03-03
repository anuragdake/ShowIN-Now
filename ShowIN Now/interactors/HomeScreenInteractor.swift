//
//  HomeScreenInteractor.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit
import CoreData

class HomeScreenInteractor: DataSyncDelegate{
    
    private weak var dataSyncDelegate: DataSyncDelegate?
    
    func getAllShowsFromDB() -> [Show]{
        guard let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext else{
            return []
        }
        let showsRepo = CoreDataService.sharedInstance.showsRepo(context: managedObjectContext)
        return showsRepo.allShows()
    }
    
    func startSyncingMetaData(dataSyncDelegate: DataSyncDelegate){
        guard let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext else{
            return
        }
        self.dataSyncDelegate = dataSyncDelegate
        let syncOperation = DataSyncer(managedObjectContext: managedObjectContext, urlString: URLConstants.SCHEDULE, syncDelegate: self)
        OperationQueue().addOperation(syncOperation)
    }
    
    func onDataSyncComplete(status: Bool, errorTitle: String?, errorMessage: String?) {
        dataSyncDelegate?.onDataSyncComplete(status: status, errorTitle: errorTitle, errorMessage: errorMessage)
    }
}
