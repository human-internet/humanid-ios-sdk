internal protocol VerifyRoutingLogic {

    func pushRegisterVC(with request: Verify.Request)
    func openTnc()
}

internal class VerifyRouter: VerifyRoutingLogic {

    weak var view: VerifyViewController?

    init(view: VerifyViewController) {
        self.view = view
    }

    func pushRegisterVC(with request: Verify.Request) {
        let registerVC = Injector.shared.resolver.resolve(RegisterViewController.self)!
        registerVC.countryCode = request.countryCode
        registerVC.phoneNumber = request.phone
        registerVC.delegate = self.view

        if #available(iOS 13.0, *) {
            registerVC.modalPresentationStyle = .automatic
        } else {
            registerVC.modalPresentationStyle = .formSheet
        }

        view?.present(registerVC, animated: true)
    }

    func openTnc() {
        UIApplication.shared.open(.tnc)
    }
}
