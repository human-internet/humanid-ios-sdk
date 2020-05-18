internal class RevokePresenter: RevokeInteractorOutput {

    func success(with response: BaseResponse<NetworkResponse>) {
        guard
            let isSuccess = response.success,
            let message = response.message else {
                return
        }

        switch isSuccess {
        case true:
            _ = KeyChain.isStoreSuccess(key: .deviceHash, value: "")
        default:
            print(message)
        }
    }

    func error(with error: Error) {
        print(error.localizedDescription)
    }
}
