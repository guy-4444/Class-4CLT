import Foundation
import Firebase


class LocalNews: Codable {
    var name: String = ""
    var date: Int = 0
    var articles: [Article] = []
    
    init() {}
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        name = snapshotValue["name"] as! String
        date = snapshotValue["date"] as! Int
        var articlesDict = snapshotValue["articles"] as! [Dictionary<String, Any>]

        for arD in articlesDict {
            articles.append(Article(dict: arD))
        }
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        var articlesDict = [Dictionary<String, Any>]()
        for ar in articles {
            articlesDict.append(ar.toDictionary())
        }
        
        return [
            "name" : name,
            "date": date,
            "articles": articlesDict,
        ]
    }
}

class Article: Codable {
    var key: String = ""
    var title: String = ""
    var content: String = ""
    var image: String = ""
    var date: Int = 0
    
    init() {}
    
    init(dict: Dictionary<String, Any>) {
        guard let _key = dict["key"] as? String,
              let _title = dict["title"] as? String,
              let _content = dict["content"] as? String,
              let _image = dict["image"] as? String,
              let _date = dict["date"] as? Int
        else {
            print("Something is not well")
            return
        }
        
        key = _key
        title = _title
        content = _content
        image = _image
        date = _date
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        key = snapshotValue["key"] as! String
        title = snapshotValue["title"] as! String
        content = snapshotValue["content"] as! String
        image = snapshotValue["image"] as! String
        date = snapshotValue["date"] as! Int
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "key" : key,
            "title": title,
            "content": content,
            "image": image,
            "date": date,
        ]
    }
}
