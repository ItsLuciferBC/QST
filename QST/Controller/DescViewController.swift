//
//  DescViewController.swift
//  QST
//
//  Created by Fahad Mansuri on 07.07.23.
import UIKit
import youtube_ios_player_helper

protocol DescViewControllerDelegate: AnyObject {
    func updateWatchListStatus(for movie: Movie)
}


class DescViewController: UIViewController{
    
    weak var delegate: DescViewControllerDelegate?
    var movie: Movie?
    var tvc = ViewController()
    var rowSelected : Int?
    @IBOutlet var descTableView: UITableView!
    
    @IBOutlet var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descTableView.dataSource = self
        descTableView.delegate = self
        descTableView.rowHeight = 205
        descTableView.register(UINib.init(nibName: "descViewTopCell", bundle: .main), forCellReuseIdentifier: "descViewTopCell")
        descTableView.register(UINib.init(nibName: "descViewCentreCell", bundle: .main), forCellReuseIdentifier: "descViewCentreCell")
        descTableView.register(UINib.init(nibName: "descViewBottomCell", bundle: .main), forCellReuseIdentifier: "descViewBottomCell")
    }
}


extension DescViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = descTableView.dequeueReusableCell(withIdentifier: "descViewTopCell", for: indexPath) as! DescViewTopCell
            cell.configure(with: movie?.watchlist == true ? "REMOVE FROM WATCHLIST" : "ADD TO WATCHLIST")
            cell.watchListButtonHandler = {[weak self] in
                self?.toggleWatchList()
                cell.configure(with: self?.movie?.watchlist == true ? "REMOVE FROM WATCHLIST" : "ADD TO WATCHLIST")
            }
            cell.play = {[weak self] in
                self?.playerView.load(withVideoId: self?.movie?.url ?? "")
                self?.playerView.playVideo()
            }
            cell.selectionStyle = .none
            cell.descViewTopCellImage.image = UIImage(named: movie?.title ?? "")
            cell.descViewTopCellTitle.text = movie?.title ?? ""
            cell.descViewTopCellRating.text = "\(movie?.rating ?? 0)/10"
            return cell
            
        } else if indexPath.row == 1 {
            let cell = descTableView.dequeueReusableCell(withIdentifier: "descViewCentreCell", for: indexPath) as! DescViewCentreCell
            cell.selectionStyle = .none
            cell.descViewCentreCellDescription.text = movie?.desc ?? ""
            return cell
        } else {
            let cell = descTableView.dequeueReusableCell(withIdentifier: "descViewBottomCell", for: indexPath) as! DescViewBottomCell
            cell.selectionStyle = .none
            cell.descViewBottomCellGenre.text = movie?.genre ?? ""
            cell.descViewBottomCellReleaseDate.text = movie?.relDt ?? ""
            return cell
        }
    }
}

extension DescViewController: UITableViewDelegate{
    func updateWatchListButtonTitle (cell: DescViewTopCell){
        guard let indexPath = descTableView.indexPath(for: cell) else {
            return
        }
        let isAddedToWatchlist = movie?.watchlist ?? false
    }
    
    func toggleWatchList(){
        movie?.watchlist.toggle()
        delegate?.updateWatchListStatus(for: movie ?? Movie(id: UUID(), title: "", desc: "", rating: 0, dur: "", genre: "", relDt: "", url: "", watchlist: false))
    }
}
