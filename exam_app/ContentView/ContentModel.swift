//
//  ContentModel.swift
//  exam_app
//
//  Created by br3nd4nt on 19.03.2024.
//

import Foundation

struct ContentTile: Decodable {
  let url: String
}

struct Cat: Decodable {
    let url: String
    let id: String
}

struct Dog: Decodable {
    let message: String
    let status: String
}

struct Fox: Decodable {
    let image: String
    let link: String
}

struct Duck: Decodable {
    let message: String
    let url: String
}
