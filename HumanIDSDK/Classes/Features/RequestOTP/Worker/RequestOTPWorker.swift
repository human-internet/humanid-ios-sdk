import RxSwift

internal protocol RequestOTPWorkerDelegate {

    func requestOtp(with request: RequestOTP.Request) -> Observable<BaseResponse<NetworkResponse>>
}

internal class RequestOTPWorker: RequestOTPWorkerDelegate {

    var datasource: Network

    init(datasource: Network) {
        self.datasource = datasource
    }

    func requestOtp(with request: RequestOTP.Request) -> Observable<BaseResponse<NetworkResponse>> {
        return datasource.requestOtp(url: .requestOtp, request: request)
    }
}
