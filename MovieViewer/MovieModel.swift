//
//  MovieModel.swift
//  MovieViewer
//
//  Created by William Johnson on 2/4/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class MovieModel: NSObject {
    var title: String?
    var backdrop: String?
    var popularity: Int?
    var releaseDate: String?
    var overview: String?
    var poster: String?
    var genreIds: [Int]?
    
    init(json: NSDictionary){
        if let title = json["title"] {
            self.title = title as? String
        }
        if let backdrop = json["backdrop_path"] {
            self.backdrop = backdrop as? String
        }
        if let popularity = json["popularity"] {
            self.popularity = popularity as? Int
        }
        if let releaseDate = json["release_date"] {
            self.releaseDate = releaseDate as? String
        }
        if let overview = json["overview"] {
            self.overview = overview as? String
        }
        if let poster = json["poster_path"] {
            self.poster = poster as? String
        }
        if let genreIds = json["genre_ids"] {
            self.genreIds = genreIds as? [Int]
        }
    }

}
