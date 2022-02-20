import RxSwift

internal protocol WebLoginWorkerProtocol: AnyObject {

    func webLogin(with header: BaseRequest, and request: WebLogin.Request) -> Observable<BaseResponse<WebLogin.Response>>
}

internal final class WebLoginWorker: WebLoginWorkerProtocol {

    var datasource: Network!

    func webLogin(with header: BaseRequest, and request: WebLogin.Request) -> Observable<BaseResponse<WebLogin.Response>> {
        let path = "\(URL.baseV2)mobile/users/web-login"
        return datasource.webLogin(path: path, header: header, request: request)
    }
}
