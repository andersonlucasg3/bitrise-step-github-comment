import Foundation

class CreateDeploymentStatusRequest: Request {
    private let inputModel: CreateDeploymentStatusInputModel
    
    private let owner: String
    private let repo: String
    private let deploymentId: String
    
    init(inputModel: CreateDeploymentStatusInputModel, owner: String,
         repo: String, deploymentId: String, token: String) {
        self.inputModel = inputModel
        self.owner = owner
        self.repo = repo
        self.deploymentId = deploymentId
        super.init(token: token)
    }
    
    override func endPointString() -> String {
        return super.endPointString()
            .appending("repos/\(owner)/\(repo)/deployments/\(deploymentId)/statuses")
    }
    
    override func createRequest() throws -> URLRequest {
        var request = try super.createRequest()
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder.init().encode(inputModel)
        return request
    }
    
    override func didFinishWithResult(data: Data?, error: Request.Error?) {
        print(error as Any)
    }
}
