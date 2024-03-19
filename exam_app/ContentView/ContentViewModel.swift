//
//  ContentViewModel.swift
//  exam_app
//
//  Created by br3nd4nt on 19.03.2024.
//

import Foundation

class ContentViewModel {
  
  private var content: [ContentTile] = []

    
  func fetchData() async throws {
      for _ in 0...20 {
          
          let rng = (0...4).randomElement()!
          if rng == 0 {
              let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=1")!
              let request = URLRequest(url: url)
              let (data, _) = try await URLSession.shared.data(for: request)
              let decodedData = try JSONDecoder().decode([Cat].self, from: data)
              for cat in decodedData {
                  content.append(ContentTile(url: cat.url))
              }
          } else if rng == 1 {
              let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
              let request = URLRequest(url: url)
              let (data, _) = try await URLSession.shared.data(for: request)
              let decodedData = try JSONDecoder().decode(Dog.self, from: data)
              content.append(ContentTile(url: decodedData.message))
              
          } else if rng == 2 {
              let url = URL(string: "https://randomfox.ca/floof/")!
              let request = URLRequest(url: url)
              let (data, _) = try await URLSession.shared.data(for: request)
              let decodedData = try JSONDecoder().decode(Fox.self, from: data)
              content.append(ContentTile(url: decodedData.image))
              
          } else {
              let url = URL(string: "https://random-d.uk/api/random")!
              let request = URLRequest(url: url)
              let (data, _) = try await URLSession.shared.data(for: request)
              let decodedData = try JSONDecoder().decode(Duck.self, from: data)
              content.append(ContentTile(url: decodedData.url))
              
          }
      }
  }
  
  func getContent() -> [ContentTile] {
    return content
  }
    
}
