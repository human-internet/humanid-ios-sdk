internal protocol RegisterPresenterOutput: class {

    func showLoading()
    func hideLoading()
    func successRegister(with viewModel: Register.ViewModel)
    func errorRegister(with message: String)
    func errorVerify(with message: String)
}

internal class RegisterPresenter: RegisterInteractorOutput {

    weak var output: RegisterPresenterOutput?

    init(output: RegisterPresenterOutput) {
        self.output = output
    }

    func showLoading() {
        output?.showLoading()
    }

    func hideLoading() {
        output?.hideLoading()
    }

    func successRegister(with response: Register.Response) {
        guard
            let isSuccess = response.success,
            let message = response.message else {
                return
        }

        switch isSuccess {
        case true:
            guard
                let data = response.data,
                let token = data.exchangeToken,
                let hash = data.userHash else { return }

            let viewModel = Register.ViewModel(token: token, hash: hash)
            output?.successRegister(with: viewModel)
        default:
            output?.errorRegister(with: message)
        }
    }

    func successVerify(with response: Verify.Response) {
        guard
            let isSuccess = response.success,
            let message = response.message else {
                return
        }

        switch isSuccess {
        case false:
            output?.errorVerify(with: message)
        default:
            break
        }
    }

    func errorRegister(with errorResponse: Error) {
        output?.errorRegister(with: errorResponse.localizedDescription)
    }

    func errorVerify(with errorResponse: Error) {
        output?.errorVerify(with: errorResponse.localizedDescription)
    }
}
