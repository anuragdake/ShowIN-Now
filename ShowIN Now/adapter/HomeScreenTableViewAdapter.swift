//
//  HomeScreenTableViewAdapter.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit

class HomeScreenTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var showsList = [Show]()
    private let homescreenTableViewCellIdentifier = "ShowTableViewCell"
    private let TABLEVIEW_HEIGHT: CGFloat = 150
    
    func homescreenTableViewCell() -> UINib{
        return UINib(nibName: homescreenTableViewCellIdentifier, bundle: nil)
    }
    
    func  homescreenTableViewCellReuseIdentifier() -> String{
        return homescreenTableViewCellIdentifier
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TABLEVIEW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: homescreenTableViewCellIdentifier, for: indexPath) as? ShowTableViewCell else{
            return UITableViewCell()
        }
        let showItem = showsList[indexPath.row]
        cell.setData(show: showItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postNotification(data: showsList[indexPath.row])
    }
    
    func postNotification(data: AnyObject){
        let userInfoData:Dictionary<String, AnyObject> = ["data": data]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.TABLE_VIEW_SELECTION_NOTIFICATION), object: nil, userInfo: userInfoData)
    }
}
