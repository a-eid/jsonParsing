// Actor Modal.
import Foundation


//struct Actor: Codable {
//  let name: String
//  let img: String
//}

struct Actor: Codable {
  let name: String
  let image: String
  let img: String?
}


struct Actors: Codable {
  let actors: [Actor]
}
