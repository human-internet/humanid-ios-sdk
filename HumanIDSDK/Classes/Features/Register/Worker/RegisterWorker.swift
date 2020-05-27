import RxSwift

internal protocol RegisterWorkerDelegate {

    func register(with request: Register.Request) -> Observable<BaseResponse<Register.Response>>
    func verify(with request: RequestOTP.Request) -> Observable<BaseResponse<NetworkResponse>>
}

internal class RegisterWorker: RegisterWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func register(with request: Register.Request) -> Observable<BaseResponse<Register.Response>> {
        return datasource.register(url: .register, request: request)
    }

    func verify(with request: RequestOTP.Request) -> Observable<BaseResponse<NetworkResponse>> {
        return datasource.requestOtp(url: .requestOtp, request: request)
    }
}
