import Foundation

class Request : NSObject, URLSessionDelegate {
    private var dataTask: URLSessionDataTask!
    
    private let accessToken: String
    
    init(token: String) {
        accessToken = token
        
        super.init()
    }
    
    func endPointString() -> String {
        return "https://api.github.com/"
    }
    
    func createRequest() throws -> URLRequest {
        let urlString = endPointString()
        print("Requesting url: \(urlString)")
        guard let url = URL.init(string: urlString) else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func startRequest() throws {
        let request = try createRequest()
        dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            self.didFinishWithResult(data: data, error: .error(error: error))
        })
        dataTask.resume()
    }
    
    func didFinishWithResult(data: Data?, error: Error?) { }
    
    enum Error: Swift.Error {
        case invalidUrl
        case error(error: Swift.Error?)
    }
}
