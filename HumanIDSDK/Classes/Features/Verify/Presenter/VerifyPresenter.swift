internal protocol VerifyPresenterOutput: class {

    func showLoading()
    func hideLoading()
    func success()
    func error(with message: String)
}

internal class VerifyPresenter: VerifyInteractorOutput {

    weak var output: VerifyPresenterOutput?

    init(output: VerifyPresenterOutput) {
        self.output = output
    }

    func showLoading() {
        output?.showLoading()
    }

    func hideLoading() {
        output?.hideLoading()
    }

    func success(with response: Verify.Response) {
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
