internal protocol VerifyRoutingLogic {

    func presentAlert(message: String)
    func pushRegisterVC(with request: Verify.Request)
    func openTnc()
}

internal class VerifyRouter: VerifyRoutingLogic {

    weak var view: VerifyViewController?

    init(view: VerifyViewController) {
        self.view = view
    }

    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Close", style: .default))

        view?.present(alertVC, animated: true)
    }

    func pushRegisterVC(with request: Verify.Request) {
        // TODO Assembler configure not yet implemented

        let registerVC = RegisterViewController(phoneNumber: request.phone, countryCode: request.countryCode)
        // TODO Implement delegate protocol

        if #available(iOS 13.0, *) {
            registerVC.modalPresentationStyle = .automatic
        } else {
            registerVC.modalPresentationStyle = .formSheet
        }

        view?.present(registerVC, animated: true)
    }

    func openTnc() {
        // TODO Show TnC page on browser
    }
}
