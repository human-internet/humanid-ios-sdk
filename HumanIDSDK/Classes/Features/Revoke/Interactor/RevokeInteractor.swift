internal protocol RevokeInteractorInput {

    func revoke(with request: Revoke.Request)
}

internal protocol RevokeInteractorOutput {

    func success(with response: BaseResponse<NetworkResponse>)
    func error(with error: Error)
}

internal class RevokeInteractor: RevokeInteractorInput {

    var output: RevokeInteractorOutput?
    var worker: RevokeWorkerDelegate?

    init(output: RevokeInteractorOutput, worker: RevokeWorkerDelegate) {
        self.output = output
        self.worker = worker
    }

    func revoke(with request: Revoke.Request) {
        worker?.revoke(with: request) { result in
            switch result {
            case .success(let response):
                self.output?.success(with: response)
            case .failure(let error):
                self.output?.error(with: error)
            }
        }
    }
}
