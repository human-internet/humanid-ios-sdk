import RxSwift

internal protocol VerifyWorkerDelegate {

    func verify(with request: Verify.Request) -> Observable<Verify.Response>
}

internal class VerifyWorker: VerifyWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func verify(with request: Verify.Request) -> Observable<Verify.Response> {
        return datasource.verify(url: .verify, request: request)
    }
}
