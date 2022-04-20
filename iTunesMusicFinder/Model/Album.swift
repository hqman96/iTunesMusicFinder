//
//  Album.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 18.03.2022.
//

import Foundation

struct Album: Codable {
    let artistName: String
    let albumName: String
    let collectionId: Int
    let artworkUrl100: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case collectionId
        case artworkUrl100
    }
}
