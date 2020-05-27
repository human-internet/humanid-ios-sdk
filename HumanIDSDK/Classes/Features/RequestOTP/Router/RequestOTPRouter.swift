internal protocol RequestOTPRoutingLogic {

    func pushRegisterVC(with request: RequestOTP.Request)
    func openTnc()
}

internal class RequestOTPRouter: RequestOTPRoutingLogic {

    weak var view: RequestOTPViewController?

    init(view: RequestOTPViewController) {
        self.view = view
    }

    func pushRegisterVC(with request: RequestOTP.Request) {
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
