internal protocol WebLoginPresenterOutput: AnyObject {

    func showLoading()
    func hideLoading()
    func success(with url: String)
    func error(with message: String)
}

internal final class WebLoginPresenter: WebLoginInteractorOutput {

    var output: WebLoginPresenterOutput!

    func showLoading() {
        output.showLoading()
    }

    func hideLoading() {
        output.hideLoading()
    }

    func success(with response: BaseResponse<WebLogin.Response>) {
        guard let url = response.data?.webLoginURL else {
            return output.error(with: "Web Login Not Found!")
        }

        output.success(with: url)
    }

    func error(with response: Error) {
        output.error(with: response.localizedDescription)
    }
}
