//
//  ShowTableViewCell.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell{
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    func setData(show: Show){
        if let url = show.imageUrl{
            showImageView.loadImageUsingCache(withUrl: url)
        }
        nameLabel.text = show.name ?? "NA"
        ratingsLabel.text = String(show.rating)
        typeLabel.text = show.type ?? "NA"
        genreLabel.text = genreText(genres: show.genres ?? [])
    }
    
    func genreText(genres: [String]) -> String{
        return (genres.count == 0) ? "NA" : genres.joined(separator: " | ")
    }
}
