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

    func verify(url: URL, request: Verify.Request) -> Observable<Verify.Response> {
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
            .map({ (response) -> Verify.Response in
                return try self.decoder.decode(Verify.Response.self, from: response.data!)
            })
    }

    func register(url: URL, request: Register.Request) -> Observable<Register.Response> {
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
            .map({ (response) -> Register.Response in
                return try self.decoder.decode(Register.Response.self, from: response.data!)
            })
    }

    func revoke() {}
}
