//
//  Track.swift
//  iTunesMusicFinder
//
//  Created by Георгий on 18.03.2022.
//

import Foundation

struct Track: Codable {
    let artistName: String
    let trackName: String?

    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
    }
}
