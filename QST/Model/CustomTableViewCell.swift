//
//  CustomTableViewCell.swift
//  QST
//
//  Created by Fahad Mansuri on 06.07.23.

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var oView: UILabel!
    @IBOutlet weak var watchList: UILabel!
    
    func configure (with title: String){
        watchList.text = title
    }
}
