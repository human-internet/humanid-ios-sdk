import RxSwift

internal protocol RegisterWorkerDelegate {

    func register(with request: Register.Request) -> Observable<BaseResponse<Register.Response>>
    func verify(with request: Verify.Request) -> Observable<BaseResponse<NetworkResponse>>
}

internal class RegisterWorker: RegisterWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func register(with request: Register.Request) -> Observable<BaseResponse<Register.Response>> {
        return datasource.register(url: .register, request: request)
    }

    func verify(with request: Verify.Request) -> Observable<BaseResponse<NetworkResponse>> {
        return datasource.verify(url: .verify, request: request)
    }
}
