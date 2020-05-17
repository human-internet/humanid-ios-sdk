internal class RevokePresenter: RevokeInteractorOutput {

    func success(with response: Revoke.Response) {
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
