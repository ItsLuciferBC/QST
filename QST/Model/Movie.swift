//
//  Movie.swift
//  QST
//
//  Created by Fahad Mansuri on 06.07.23.
//

import Foundation

struct Movie {
    var id: UUID
    let title: String
    let desc: String
    let rating: Double
    let dur: String
    let genre: String
    let relDt: String
    let url: String
    var watchlist: Bool
}
