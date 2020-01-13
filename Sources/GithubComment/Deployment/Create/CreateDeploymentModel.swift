import Foundation

struct CreateDeploymentModel : Encodable {
    let ref: String
    let description: String
    let payload: String = ""
}
