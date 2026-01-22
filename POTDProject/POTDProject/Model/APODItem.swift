//
//  APODItem.swift
//  POTDProject
//
//  Created by Dev3 on 22/1/2569 BE.
//

struct APODItem: Decodable {
    let date: String
    let title: String
    let explanation: String
    let url: String
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case date, title, explanation, url
        case mediaType = "media_type"
    }
}
