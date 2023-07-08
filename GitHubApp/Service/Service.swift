import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        
        // TODO
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else {
            print("URL inválida")
            return
        }
        
        network.performGet(url: url) { data in
            if let data = data {
                do {
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                    completion(repositories)
                } catch {
                    print("Error \(error.localizedDescription)")
                }
            } else {
                completion(nil)
            }
        }
    }
}
