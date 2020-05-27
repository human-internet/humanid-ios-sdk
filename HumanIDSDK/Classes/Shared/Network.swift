import RxAlamofire
import RxSwift

internal final class Network {

    private let scheduler: ConcurrentDispatchQueueScheduler
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init() {
        let dispatchQoS = DispatchQoS.QoSClass.background
        let qos = DispatchQoS(qosClass: dispatchQoS, relativePriority: 1)

        self.scheduler = ConcurrentDispatchQueueScheduler(qos: qos)
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    func requestOtp(url: URL, request: RequestOTP.Request) -> Observable<BaseResponse<NetworkResponse>> {
        let requestBody = try! encoder.encode(request)

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.method = .post
        urlRequest.httpBody = requestBody

        return RxAlamofire
            .request(urlRequest)
            .validate(statusCode: 200..<401)
            .responseJSON()
            .asObservable()
            .observeOn(scheduler)
            .map({ (response) -> BaseResponse<NetworkResponse> in
                return try self.decoder.decode(BaseResponse<NetworkResponse>.self, from: response.data!)
            })
    }

    func register(url: URL, request: Register.Request) -> Observable<BaseResponse<Register.Response>> {
        let requestBody = try! encoder.encode(request)

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.method = .post
        urlRequest.httpBody = requestBody

        return RxAlamofire
            .request(urlRequest)
            .validate(statusCode: 200..<401)
            .responseJSON()
            .asObservable()
            .observeOn(scheduler)
            .map({ (response) -> BaseResponse<Register.Response> in
                return try self.decoder.decode(BaseResponse<Register.Response>.self, from: response.data!)
            })
    }
}
