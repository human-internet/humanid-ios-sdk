import Swinject

internal class RegisterConfigurator: Assembly {

    func assemble(container: Container) {
        container.register(RegisterInteractorOutput.self) { (r, output: RegisterPresenterOutput) in
            return RegisterPresenter(output: output)
        }

        container.register(RegisterWorkerDelegate.self) { (r) in
            let datasource = r.resolve(Network.self)!
            return RegisterWorker(datasource: datasource)
        }

        container.register(RegisterInteractorInput.self) { (r, output: RegisterPresenterOutput) in
            let output = r.resolve(RegisterInteractorOutput.self, argument: output)!
            let worker = r.resolve(RegisterWorkerDelegate.self)!

            return RegisterInteractor(output: output, worker: worker)
        }

        container.register(RegisterRoutingLogic.self) { (r, view: RegisterViewController) in
            return RegisterRouter(view: view)
        }

        container.register(RegisterViewController.self) { (r) in
            let view = RegisterViewController()
            let input = r.resolve(RegisterInteractorInput.self, argument: view as RegisterPresenterOutput)!
            let router = r.resolve(RegisterRoutingLogic.self, argument: view)!

            view.input = input
            view.router = router

            return view
        }
    }
}
