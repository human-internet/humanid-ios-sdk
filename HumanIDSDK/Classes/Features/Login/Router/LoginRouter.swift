internal protocol LoginRoutingLogic {

    func openTnc()
}

internal class LoginRouter: LoginRoutingLogic {

    weak var view: LoginViewController?

    init(view: LoginViewController) {
        self.view = view
    }

    func openTnc() {
        UIApplication.shared.open(.tnc)
    }
}
