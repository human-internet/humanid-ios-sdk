import Alamofire
import RxAlamofire
import RxSwift

internal final class Network {

    private let scheduler: ConcurrentDispatchQueueScheduler
    private let encoding: URLEncoding
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init() {
        let dispatchQoS = DispatchQoS.QoSClass.background
        let qos = DispatchQoS(qosClass: dispatchQoS, relativePriority: 1)

        self.scheduler = ConcurrentDispatchQueueScheduler(qos: qos)
        self.encoding = URLEncoding(destination: .queryString, arrayEncoding: .brackets)
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    func requestOtp(url: URL, header: BaseRequest, request: RequestOTP.Request) -> Observable<BaseResponse<RequestOTP.Response>> {
        let requestBody = try! encoder.encode(request)

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(header.clientId, forHTTPHeaderField: "client-id")
        urlRequest.setValue(header.clientSecret, forHTTPHeaderField: "client-secret")
        urlRequest.method = .post
        urlRequest.httpBody = requestBody

        return RxAlamofire
            .request(urlRequest)
            .validate(statusCode: 200..<401)
            .responseJSON()
            .asObservable()
            .observeOn(scheduler)
            .map({ (response) -> BaseResponse<RequestOTP.Response> in
                return try self.decoder.decode(BaseResponse<RequestOTP.Response>.self, from: response.data!)
            })
    }

    func login(url: URL, header: BaseRequest, request: Login.Request) -> Observable<BaseResponse<Login.Response>> {
        let requestBody = try! encoder.encode(request)

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(header.clientId, forHTTPHeaderField: "client-id")
        urlRequest.setValue(header.clientSecret, forHTTPHeaderField: "client-secret")
        urlRequest.method = .post
        urlRequest.httpBody = requestBody

        return RxAlamofire
            .request(urlRequest)
            .validate(statusCode: 200..<401)
            .responseJSON()
            .asObservable()
            .observeOn(scheduler)
            .map({ (response) -> BaseResponse<Login.Response> in
                return try self.decoder.decode(BaseResponse<Login.Response>.self, from: response.data!)
            })
    }

    func webLogin(path: String, header: BaseRequest, request: WebLogin.Request) -> Observable<BaseResponse<WebLogin.Response>> {
        let params = request.param
        let headers = HTTPHeaders([
            "Content-Type": "application/json",
            "client-id": header.clientId,
            "client-secret": header.clientSecret
        ])

        return RxAlamofire.request(
            .post,
            path,
            parameters: params,
            encoding: encoding,
            headers: headers)
            .asObservable()
            .observeOn(scheduler)
            .validate(statusCode: 200..<500)
            .responseJSON()
            .map { (response) -> BaseResponse<WebLogin.Response> in
                return try self.decoder.decode(BaseResponse<WebLogin.Response>.self, from: response.data ?? Data())
            }
    }
}
