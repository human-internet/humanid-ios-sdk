import RxSwift

internal protocol VerifyInteractorInput {

    func verify(with request: Verify.Request)
}

internal protocol VerifyInteractorOutput {

    func showLoading()
    func hideLoading()
    func success(with response: Verify.Response)
    func error(with errorResponse: Error)
}

internal class VerifyInteractor: VerifyInteractorInput {

    var output: VerifyInteractorOutput?
    var worker: VerifyWorkerDelegate?

    private let disposeBag = DisposeBag()

    init(output: VerifyInteractorOutput, worker: VerifyWorkerDelegate) {
        self.output = output
        self.worker = worker
    }

    func verify(with request: Verify.Request) {
        output?.showLoading()
        worker?.verify(with: request)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] (response) in
                    self?.output?.hideLoading()
                    self?.output?.success(with: response)
                },
                onError: {[weak self] (error) in
                    self?.output?.hideLoading()
                    self?.output?.error(with: error)
            }).disposed(by: disposeBag)
    }
}
