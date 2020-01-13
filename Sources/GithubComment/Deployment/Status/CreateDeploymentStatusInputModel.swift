import Foundation

struct CreateDeploymentStatusInputModel: Encodable {
    let environment: String
    let state: String
    let targetUrl: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case environment
        case state
        case targetUrl = "target_url"
        case description
    }
}
