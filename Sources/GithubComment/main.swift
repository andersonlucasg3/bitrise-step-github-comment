import Foundation

// token: e2f51c1d39f50b977247a0cddd49513638aeb0cc

var isRequesting = true

func main() {
    guard let args = getArgs() else { return }
    
    createDeployment(branch: args.branch, description: "Deploying",
                     owner: args.owner, repo: args.repo, environment: args.environment,
                     targetUrl: args.targetUrl, token: args.token)
    
    
    while isRequesting { }
    
    exit(0)
}

func getArgs() -> (token: String, branch: String, owner: String, repo: String, environment: String, targetUrl: String)? {
    let args = ProcessInfo.processInfo.arguments
    let count = args.count
    
    guard count > 1 else { print("Token not provided..."); exit(1) }
    let token = args[1]
    guard count > 2 else { print("Branch not provided..."); exit(2) }
    let branch = args[2]
    guard count > 3 else { print("Owner not provided..."); exit(3) }
    let owner = args[3]
    guard count > 4 else { print("Repo not provided..."); exit(4) }
    let repo = args[4]
    guard count > 5 else { print("Environment not provided..."); exit(5) }
    let environment = args[5]
    guard count > 6 else { print("Target URL not provided..."); exit(6) }
    let targetUrl = args[6]
    
    return (token, branch, owner, repo, environment, targetUrl)
}

func createDeployment(branch: String, description: String, owner: String, repo: String, environment: String, targetUrl: String, token: String) {
    let request = CreateDeploymentRequest.init(model: .init(ref: branch, description: description),
                                               owner: owner, repo: repo, token: token)
    request.callback = { (response, error) in
        guard let response = response else {
            print(error as Any)
            return
        }
        createDeploymentStatus(deploymentId: "\(response.id)", environment: environment, state: "success",
                               targetUrl: targetUrl, owner: owner, repo: repo, token: token)
    }
    do {
        try request.startRequest()
    } catch {
        print(error)
    }
}

func createDeploymentStatus(deploymentId: String, environment: String, state: String, targetUrl: String,
                            owner: String, repo: String, token: String) {
    let request = CreateDeploymentStatusRequest.init(inputModel: .init(environment: "production", state: "success", targetUrl: targetUrl, description: "Deployment test finish"),
                                                     owner: owner, repo: repo, deploymentId: deploymentId, token: token)
    
    do {
        try request.startRequest()
    } catch {
        print(error)
    }
}

main()
