import Swinject

internal class LoginConfigurator: Assembly {

    func assemble(container: Container) {
        container.register(LoginInteractorOutput.self) { (r, output: LoginPresenterOutput) in
            return LoginPresenter(output: output)
        }

        container.register(LoginWorkerDelegate.self) { (r) in
            let datasource = r.resolve(Network.self)!
            return LoginWorker(datasource: datasource)
        }

        container.register(LoginInteractorInput.self) { (r, output: LoginPresenterOutput) in
            let output = r.resolve(LoginInteractorOutput.self, argument: output)!
            let worker = r.resolve(LoginWorkerDelegate.self)!

            return LoginInteractor(output: output, worker: worker)
        }

        container.register(LoginRoutingLogic.self) { (r, view: LoginViewController) in
            return LoginRouter(view: view)
        }

        container.register(LoginViewController.self) { (r) in
            let view = LoginViewController()
            let input = r.resolve(LoginInteractorInput.self, argument: view as LoginPresenterOutput)!
            let router = r.resolve(LoginRoutingLogic.self, argument: view)!

            view.input = input
            view.router = router

            return view
        }
    }
}
