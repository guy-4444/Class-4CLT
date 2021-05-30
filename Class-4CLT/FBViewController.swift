import UIKit
import Firebase

class FBViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("FB - START")
        
        
        //let URL = "https://class4news-default-rtdb.europe-west1.firebasedatabase.app"
        //ref = Database.database(url: URL).reference()
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child("AAAA").setValue(["username": "Avi Shakuri"])
        
        
        
        //ref.child("articles").setValue(["localNews": localNews.toDictionary()])
        
        
        ref.child("articles").child("localNews").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            
            var ln = LocalNews(snapshot: snapshot)
            print(name)
            
            for ar in ln.articles {
                print("\(ar.title) - \(ar.content)")
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        print("FB - DONE")
    }
    
    func uploadArticle(article: Article) {
        
    }
    
}
