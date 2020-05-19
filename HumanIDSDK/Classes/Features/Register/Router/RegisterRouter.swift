internal protocol RegisterRoutingLogic {

    func openTnc()
}

internal class RegisterRouter: RegisterRoutingLogic {

    weak var view: RegisterViewController?

    init(view: RegisterViewController) {
        self.view = view
    }

    func openTnc() {
        UIApplication.shared.open(.tnc)
    }
}
