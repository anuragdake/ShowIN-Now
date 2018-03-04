//
//  ShowDetailsViewController.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController{
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showSummaryLabel: UILabel!
    
    public var show: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBarTitle()
        initialiseUI()
    }
    
    private func updateNavigationBarTitle(){
        self.title = show?.name ?? ""
        self.navigationController?.navigationBar.topItem?.title = "Home"
    }
    
    private func initialiseUI(){
        showSummaryLabel.text = show?.summary?.htmlString ?? "NA"
        if let url = show?.imageUrl{
            showImageView.loadImageUsingCache(withUrl: url)
        }
    }
}
