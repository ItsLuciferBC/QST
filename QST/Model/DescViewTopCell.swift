//
//  descViewTopCell.swift
//  QST
//
//  Created by Fahad Mansuri on 14.07.23.

import UIKit
import youtube_ios_player_helper

class DescViewTopCell: UITableViewCell {
    var link: DescViewController?
    var watchListButtonHandler: (() -> Void)?
    var play: (() -> Void)?
    @IBOutlet weak var descViewTopCellImage: UIImageView!
    @IBOutlet weak var descViewTopCellTitle: UILabel!
    @IBOutlet weak var descViewTopCellRating: UILabel!
    @IBOutlet weak var descViewTopCellWatchlist: UIButton!
    @IBOutlet weak var descViewTopCellTrailer: UIButton!
    
    @IBOutlet var playerView: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descViewTopCellWatchlist.addTarget(self, action: #selector(watchListButtonPressed), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func watchListButtonPressed(_ sender: UIButton) {
        print("watchlist Pressedsssss")
        watchListButtonHandler?()
    }
    
    func configure(with title: String){
        descViewTopCellWatchlist.setTitle(title, for: .normal)
        descViewTopCellWatchlist.titleLabel?.font = .systemFont(ofSize: 10)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("hello world")
        play?()
    }
}
