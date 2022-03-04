import Alamofire
import RxAlamofire
import RxSwift

internal final class Network {

    private let scheduler: ConcurrentDispatchQueueScheduler
    private let encoding: URLEncoding
    private let decoder: JSONDecoder

    init() {
        let dispatchQoS = DispatchQoS.QoSClass.background
        let qos = DispatchQoS(qosClass: dispatchQoS, relativePriority: 1)

        self.scheduler = ConcurrentDispatchQueueScheduler(qos: qos)
        self.encoding = URLEncoding(destination: .queryString)
        self.decoder = JSONDecoder()
    }

    func webLogin(path: String, header: BaseRequest, request: WebLogin.Request) -> Observable<BaseResponse<WebLogin.Response>> {
        let params = request.param
        let headers = HTTPHeaders([
            "Content-Type": "application/json",
            "client-id": header.clientID,
            "client-secret": header.clientSecret
        ])

        return RxAlamofire.request(
            .post,
            path,
            parameters: params,
            encoding: encoding,
            headers: headers)
            .validate(statusCode: 200..<401)
            .responseJSON()
            .asObservable()
            .observeOn(scheduler)
            .map({ (response) -> BaseResponse<WebLogin.Response> in
                return try self.decoder.decode(BaseResponse<WebLogin.Response>.self, from: response.data!)
            })
    }
}
