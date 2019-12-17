
import Foundation

struct TopLevelDictionary: Decodable {
    var televisionCharacters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case televisionCharacters = "RelatedTopics"
    }
}

struct Character: Decodable {
    var text: String
    let icon: Icon?
    var imageURLString: String? {
        return icon?.urlString
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case icon = "Icon"
    }
}

struct Icon: Decodable {
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case urlString = "URL"
    }
}
