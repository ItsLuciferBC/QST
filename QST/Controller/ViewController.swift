//
//  ViewController.swift
//  QST
//
//  Created by Fahad Mansuri on 04.07.23.

import UIKit

class ViewController: UIViewController {
    
    var rowPressed: Int?
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = [
        Movie(id: UUID(), title: "Tenet", desc: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.", rating: 7.8, dur: "2h 30 min", genre: "Action, Sci-Fi", relDt: "2020, 3 September", url: "LdOM0x0XDMo", watchlist: false),
        Movie(id: UUID(),title: "Spider-Man: Into the Spider-Verse", desc: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.", rating: 8.4, dur: "1h 57min", genre: "Action, Animation, Adventure", relDt: "2018, 14 December", url: "tg52up16eq0", watchlist: false),
        Movie(id: UUID(),title: "Knives Out", desc: "A detective investigates the death of a patriarch of an eccentric, combative family.", rating: 7.9, dur: "2h 10min", genre: "Comedy, Crime, Drama", relDt: "2019, 27 November", url: "qGqiHJTsRkQ", watchlist: false),
        Movie(id: UUID(),title: "Guardians of the Galaxy", desc: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.", rating: 8.0, dur: "2h 1min", genre: "Action, Adventure, Comedy", relDt: "2014, 1 August", url: "d96cjJhvlMA", watchlist: false),
        Movie(id: UUID(),title: "Avengers: Age of Ultron", desc: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.", rating: 7.3, dur: "2h 21min", genre: "Action, Adventure, Sci-Fi", relDt: "2015, 1 May", url: "tmeOjFno6Do", watchlist: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(self.sortTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func sortTapped() {
        print("tapped")
        showActionSheet()
    }
    
    func showActionSheet(){
        let actionSheet = UIAlertController(title: "", message: "Sort By", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Name Asc", style: .default) { action1 in
            self.movies.sort{$0.title < $1.title}
            self.tableView.reloadData()
        }
        let action2 = UIAlertAction(title: "Name Desc", style: .default) { action2 in
            self.movies.sort{$1.title < $0.title}
            self.tableView.reloadData()
        }
        let action3 = UIAlertAction(title: "Release Date Asc", style: .default) { action3 in
            self.movies.sort{$0.relDt < $1.relDt}
            self.tableView.reloadData()
        }
        let action4 = UIAlertAction(title: "Release Date Desc", style: .default) { action4 in
            self.movies.sort{$1.relDt < $0.relDt}
            self.tableView.reloadData()
        }
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.iconImageView.image = UIImage(named: movies[indexPath.row].title)
        cell.titleView.text = "\(movies[indexPath.row].title) (\(movies[indexPath.row].relDt.prefix(4)))"
        cell.oView.text = "\(movies[indexPath.row].dur) - \(movies[indexPath.row].genre)"
        cell.configure(with: movies[indexPath.row].watchlist == true ? "ON MY WATCHLIST" : "")
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        rowPressed = indexPath.row
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            if let destVC = segue.destination as? DescViewController {
                destVC.movie = movies[rowPressed!]
                destVC.delegate = self
            }
        }
    }
}


extension ViewController: DescViewControllerDelegate{
    func updateWatchListStatus(for movie: Movie) {
        if let index = movies.firstIndex(where: {$0.id == movie.id}) {
            movies[index].watchlist = movie.watchlist
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
