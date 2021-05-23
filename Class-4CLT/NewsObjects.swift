import Foundation


class LocalNews: Codable {
    var name: String = ""
    var date: Int = 0
    var articles: [Article] = []
    
    init() {}
}

class Article: Codable {
    var title: String = ""
    var content: String = ""
    var image: String = ""
    var date: Int = 0
    
    init() {}
}
