import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let INTERNET_CONNECTION_AVAILABLE = false
    
    let USA_DATA_API = "https://pastebin.com/raw/TAH6S6Qe"
    let EUR_DATA_API = "https://pastebin.com/raw/HEfLFeKi"

    var locationManager: CLLocationManager!
    
    var localNews: LocalNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("- - - - - - - - - - START - - - - - - - - - -")
        
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "customArticleCellId")
        
        
        if (INTERNET_CONNECTION_AVAILABLE) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        } else {
            let ln = getLocalSavedData()
            initList(ln: ln)
        }
        
        print("- - - - - - - - - - DONE - - - - - - - - - -")
    }

    func downloadArticlesByLocation(area: String) {
        if (area == "EAST") {
            ApiManager().callApi(link: EUR_DATA_API, _delegate: self)
        } else {
            ApiManager().callApi(link: USA_DATA_API, _delegate: self)
        }
    }
    
    func saveDataLocally(ln: LocalNews) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(ln)
        let localNewsJson: String = String(data: data, encoding: .utf8)!
        UserDefaults.standard.setValue(localNewsJson, forKey: "NEWS_DATA")
    }
    
    func getLocalSavedData() -> LocalNews? {
        var ln: LocalNews?
        let localNewsJson: String? = UserDefaults.standard.string(forKey: "NEWS_DATA")
        if let safeLocalNewsJson = localNewsJson {
            let decoder = JSONDecoder()
            let data = Data(safeLocalNewsJson.utf8)
            do {
                ln = try decoder.decode(LocalNews.self, from: data)
                print("playlistName=\(ln?.name)")
            } catch {}
        }
        
        return ln
    }
    
    func initList(ln: LocalNews?) {
        print("Listed")
        localNews = ln
        tableView.reloadData()
    }

}


// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        localNews?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleArticleCellId", for: indexPath)
//        cell.textLabel?.text = localNews?.articles[indexPath.row].title
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "customArticleCellId", for: indexPath) as! ArticleCell
        cell.article_LBL_title.text = localNews?.articles[indexPath.row].title
        cell.article_LBL_content.text = localNews?.articles[indexPath.row].content
        
        var timeStamp = localNews?.articles[indexPath.row].date ?? 0;
        timeStamp /= 1000
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yy HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        cell.article_LBL_date.text = strDate

        
        
        if let url = URL(string: localNews?.articles[indexPath.row].image ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.article_IMG_image.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
        
        return cell
    }
    
}

// MARK: API MANAGER Call Back
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locations ready.")
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            print("Location: \(lat) \(lon)")
            
            
            if lon < 35.5 {
                downloadArticlesByLocation(area: "EAST")
            } else {
                downloadArticlesByLocation(area: "WEST")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error: \(error)")
    }
    
}


// MARK: API MANAGER Call Back
extension ViewController: CallBack_ApiManager {
    func dataReady(ln: LocalNews) {
        print("\(ln.name): \(ln.articles.count) articles")
        saveDataLocally(ln: ln)

        // Run on UIThread
        DispatchQueue.main.async {
            self.initList(ln: ln)
        }
    }

    func onError(error: Error?) {
        print(error.debugDescription)
    }
}




//// Every second function:
//var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
//timer.fire()
//
//
//@objc func action(){
//    print("Hi")
//}
//
//
//// Date format
//func generateCurrentTimeStamp () -> String {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
//    return (formatter.string(from: Date()) as NSString) as String
//}




// //Json Parsing (Encoding and Decoding)
//        let ln = generateMockNewsData()
//
//
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        let data = try! encoder.encode(ln)
//        let localNewsJson: String = String(data: data, encoding: .utf8)!
//        UserDefaults.standard.setValue(localNewsJson, forKey: "NEWS_DATA")
//
//        print("\(localNewsJson)")
//        var ln: LocalNews?
//        let localNewsJson = UserDefaults.standard.string(forKey: "NEWS_DATA")
//        if let safeLocalNewsJson = localNewsJson {
//            let decoder = JSONDecoder()
//            let data = Data(safeLocalNewsJson.utf8)
//            do {
//                ln = try decoder.decode(LocalNews.self, from: data)
//                print("playlistName=\(ln?.name)")
//            } catch {}
//        }
//
//
//
//        print(localNewsJson)
