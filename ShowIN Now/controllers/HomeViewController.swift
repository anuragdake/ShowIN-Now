//
//  ViewController.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, DataSyncDelegate {

    @IBOutlet weak var homeScreenTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let homeScreenInteractor = HomeScreenInteractor()
    private let homeScreenTableViewAdapter = HomeScreenTableViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
        startDataSync()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(onHomeScreenTableCellClicked(_:)), name: NSNotification.Name(rawValue: AppConstants.TABLE_VIEW_SELECTION_NOTIFICATION), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: AppConstants.TABLE_VIEW_SELECTION_NOTIFICATION), object: nil)
    }
    
    private func initialise(){
        configure(tableView: homeScreenTableView)
        loadData()
    }
    
    private func startDataSync(){
        showActivityIndicator()
        homeScreenInteractor.startSyncingMetaData(dataSyncDelegate: self)
    }
    
    private func configure(tableView: UITableView){
        tableView.delegate = homeScreenTableViewAdapter
        tableView.dataSource = homeScreenTableViewAdapter
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        tableView.register(homeScreenTableViewAdapter.homescreenTableViewCell(), forCellReuseIdentifier: homeScreenTableViewAdapter.homescreenTableViewCellReuseIdentifier())
    }
    
    private func loadData(){
        homeScreenTableViewAdapter.showsList.removeAll()
        homeScreenTableViewAdapter.showsList.append(contentsOf: homeScreenInteractor.getAllShowsFromDB())
        homeScreenTableView.reloadData()
    }
    
    func onDataSyncComplete(status: Bool, errorTitle: String?, errorMessage: String?) {
        if status{
            loadData()
        }else{
            let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        hideActivityIndicator()
    }
    
    @objc private func onHomeScreenTableCellClicked(_ notification: NSNotification){
        guard let show = notification.userInfo?["data"] as? Show else{ return }
        guard let showDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier:"ShowDetailsViewController") as? ShowDetailsViewController else{
            return
        }
        showDetailsViewController.show = show
        self.present(showDetailsViewController, animated: true, completion: nil)
    }
    
    private func showActivityIndicator(){
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator(){
        activityIndicator.stopAnimating()
    }
}

