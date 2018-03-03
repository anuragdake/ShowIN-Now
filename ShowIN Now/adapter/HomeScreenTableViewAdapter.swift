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
    private let TABLEVIEW_HEIGHT: CGFloat = 100
    
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
//        cell.item = item
        return cell
        
    }
}
