import RxSwift

internal protocol VerifyWorkerDelegate {

    func verify(with request: Verify.Request) -> Observable<BaseResponse<NetworkResponse>>
}

internal class VerifyWorker: VerifyWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func verify(with request: Verify.Request) -> Observable<BaseResponse<NetworkResponse>> {
        return datasource.verify(url: .verify, request: request)
    }
}
