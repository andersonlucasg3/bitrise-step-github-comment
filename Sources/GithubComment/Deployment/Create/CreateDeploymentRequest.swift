import Foundation

class CreateDeploymentRequest: Request {
    private let model: CreateDeploymentModel
    
    private let owner: String
    private let repo: String
    
    var callback: ((CreateDeploymentResponseModel?, Error?) -> Void)?
    
    init(model: CreateDeploymentModel, owner: String, repo: String, token: String) {
        self.model = model
        self.owner = owner
        self.repo = repo
        super.init(token: token)
    }
    
    override func endPointString() -> String {
        return super.endPointString()
            .appending("repos/\(owner)/\(repo)/deployments")
    }
    
    override func createRequest() throws -> URLRequest {
        var request = try super.createRequest()
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder.init().encode(model)
        return request
    }
    
    override func didFinishWithResult(data: Data?, error: Request.Error?) {
        guard let data = data else {
            print(error as Any)
            return
        }
        
        let decoder = JSONDecoder.init()
        do {
            let model = try decoder.decode(CreateDeploymentResponseModel.self, from: data)
            callback?(model, nil)
        } catch {
            callback?(nil, .error(error: error))
        }
    }
}
