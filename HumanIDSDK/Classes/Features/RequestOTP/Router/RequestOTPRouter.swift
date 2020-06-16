internal protocol RequestOTPRoutingLogic {

    func pushLoginVC(with request: RequestOTP.Request)
    func openTnc()
}

internal class RequestOTPRouter: RequestOTPRoutingLogic {

    weak var view: RequestOTPViewController?

    init(view: RequestOTPViewController) {
        self.view = view
    }

    func pushLoginVC(with request: RequestOTP.Request) {
        let loginVC = Injector.shared.resolver.resolve(LoginViewController.self)!
        loginVC.modalPresentationStyle = .overFullScreen
        loginVC.countryCode = request.countryCode
        loginVC.phoneNumber = request.phone
        loginVC.delegate = self.view

        view?.present(loginVC, animated: true)
    }

    func openTnc() {
        UIApplication.shared.open(.tnc)
    }
}
