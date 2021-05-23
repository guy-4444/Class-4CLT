import Foundation


protocol CallBack_ApiManager {
    func dataReady(ln: LocalNews)
    func onError(error: Error?)
}

class ApiManager {
    
    var delegate: CallBack_ApiManager?
    
    init() {}
    
    func callApi(link: String, _delegate: CallBack_ApiManager?) {
        self.delegate = _delegate
        
        if let url = URL(string: link) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handler(data:urlResponse:error:))
            
            task.resume()
        }
    }
    
    func handler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if (error != nil) {
            print("error = \(error)")
            delegate?.onError(error: error)
            return
        }
        
        
        if let safeData = data {
            // How to convert Data object to String
            let dataString = String(data: safeData, encoding: .utf8)
            
            
            var ln: LocalNews! = jsonToLocalNews(data: safeData)
            sleep(2)
            
            print("success = \(ln.name)")
            delegate?.dataReady(ln: ln)
        }
    }
    
    func jsonToLocalNews(data: Data) -> LocalNews? {
        let decoder = JSONDecoder()

        do {
            var ln = try decoder.decode(LocalNews.self, from: data)
            return ln
        } catch {
            print("error = \(error)")
        }
        
        return nil
    }
}
