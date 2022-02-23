import RxSwift

internal protocol WebLoginInteractorInput: AnyObject {

    var disposeBag: DisposeBag { get }

    func hideLoading()
    func webLogin(with header: BaseRequest, and request: WebLogin.Request)
}

internal protocol WebLoginInteractorOutput: AnyObject {

    func showLoading()
    func hideLoading()
    func success(with response: BaseResponse<WebLogin.Response>)
    func error(with response: Error)
}

internal final class WebLoginInteractor: WebLoginInteractorInput {

    var output: WebLoginInteractorOutput!
    var worker: WebLoginWorkerProtocol!

    var disposeBag: DisposeBag = DisposeBag()

    func hideLoading() {
        output.hideLoading()
    }

    func webLogin(with header: BaseRequest, and request: WebLogin.Request) {
        output.showLoading()
        worker.webLogin(with: header, and: request)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] (response) in
                    self?.output.success(with: response)
                },
                onError: {[weak self] (error) in
                    self?.output.hideLoading()
                    self?.output.error(with: error)
            }).disposed(by: disposeBag)
    }
}
