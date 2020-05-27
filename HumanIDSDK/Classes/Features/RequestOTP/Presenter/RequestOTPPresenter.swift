internal protocol RequestOTPPresenterOutput: class {

    func showLoading()
    func hideLoading()
    func success()
    func error(with message: String)
}

internal class RequestOTPPresenter: RequestOTPInteractorOutput {

    weak var output: RequestOTPPresenterOutput?

    init(output: RequestOTPPresenterOutput) {
        self.output = output
    }

    func showLoading() {
        output?.showLoading()
    }

    func hideLoading() {
        output?.hideLoading()
    }

    func success(with response: BaseResponse<NetworkResponse>) {
        guard
            let isSuccess = response.success,
            let message = response.message else {
                return
        }

        switch isSuccess {
        case true:
            output?.success()
        default:
            output?.error(with: message)
        }
    }

    func error(with errorResponse: Error) {
        output?.error(with: errorResponse.localizedDescription)
    }
}
