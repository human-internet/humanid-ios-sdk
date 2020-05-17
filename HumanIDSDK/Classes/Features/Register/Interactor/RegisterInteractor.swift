import RxSwift

internal protocol RegisterInteractorInput {

    func register(with request: Register.Request)
    func verify(with request: Verify.Request)
}

internal protocol RegisterInteractorOutput {

    func showLoading()
    func hideLoading()
    func successRegister(with response: Register.Response)
    func successVerify(with response: Verify.Response)
    func errorRegister(with errorResponse: Error)
    func errorVerify(with errorResponse: Error)
}

internal class RegisterInteractor: RegisterInteractorInput {

    var output: RegisterInteractorOutput?
    var worker: RegisterWorkerDelegate?

    private let disposeBag = DisposeBag()

    init(output: RegisterInteractorOutput, worker: RegisterWorkerDelegate) {
        self.output = output
        self.worker = worker
    }

    func register(with request: Register.Request) {
        output?.showLoading()
        worker?.register(with: request)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] (response) in
                    self?.output?.hideLoading()
                    self?.output?.successRegister(with: response)
                },
                onError: {[weak self] (error) in
                    self?.output?.hideLoading()
                    self?.output?.errorRegister(with: error)
            }).disposed(by: disposeBag)
    }

    func verify(with request: Verify.Request) {
        output?.showLoading()
        worker?.verify(with: request)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {[weak self] (response) in
                    self?.output?.hideLoading()
                    self?.output?.successVerify(with: response)
                },
                onError: {[weak self] (error) in
                    self?.output?.hideLoading()
                    self?.output?.errorVerify(with: error)
            }).disposed(by: disposeBag)
    }
}
