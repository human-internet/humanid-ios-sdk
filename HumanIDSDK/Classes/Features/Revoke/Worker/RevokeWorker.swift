internal protocol RevokeWorkerDelegate {

    func revoke(with request: Revoke.Request, completion: @escaping (NetworkResult<Revoke.Response>) -> Void)
}

internal class RevokeWorker: RevokeWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func revoke(with request: Revoke.Request, completion: @escaping (NetworkResult<Revoke.Response>) -> Void) {
        datasource.revoke(url: .revoke, request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
