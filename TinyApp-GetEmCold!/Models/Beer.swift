//
//  Beer.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation


struct Beer: Codable {
    //let beerUID: String
    let id: Int
    let name: String
    let tagline: String
    let first_brewed: String
    let description: String
    let abv: Double
    var image_url: String
    func beerToJSON() -> Any? {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}



