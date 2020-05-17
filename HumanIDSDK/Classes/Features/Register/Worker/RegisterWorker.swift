import RxSwift

internal protocol RegisterWorkerDelegate {

    func register(with request: Register.Request) -> Observable<Register.Response>
    func verify(with request: Verify.Request) -> Observable<Verify.Response>
}

internal class RegisterWorker: RegisterWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func register(with request: Register.Request) -> Observable<Register.Response> {
        return datasource.register(url: .register, request: request)
    }

    func verify(with request: Verify.Request) -> Observable<Verify.Response> {
        return datasource.verify(url: .verify, request: request)
    }
}
