internal protocol RegisterRoutingLogic {

    func presentAlert(message: String)
    func openTnc()
}

internal class RegisterRouter: RegisterRoutingLogic {

    weak var view: RegisterViewController?

    init(view: RegisterViewController) {
        self.view = view
    }

    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Close", style: .default))

        view?.present(alertVC, animated: true)
    }

    func openTnc() {
        UIApplication.shared.open(.tnc)
    }
}
