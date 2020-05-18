import Swinject

internal class VerifyConfigurator: Assembly {

    func assemble(container: Container) {
        container.register(VerifyInteractorOutput.self) { (r, output: VerifyPresenterOutput) in
            return VerifyPresenter(output: output)
        }

        container.register(VerifyWorkerDelegate.self) { (r) in
            let datasource = r.resolve(Network.self)!
            return VerifyWorker(datasource: datasource)
        }

        container.register(VerifyInteractorInput.self) { (r, output: VerifyPresenterOutput) in
            let output = r.resolve(VerifyInteractorOutput.self, argument: output)!
            let worker = r.resolve(VerifyWorkerDelegate.self)!

            return VerifyInteractor(output: output, worker: worker)
        }

        container.register(VerifyRoutingLogic.self) { (r, view: VerifyViewController) in
            return VerifyRouter(view: view)
        }

        container.register(VerifyViewController.self) { (r) in
            let view = VerifyViewController()
            let input = r.resolve(VerifyInteractorInput.self, argument: view as VerifyPresenterOutput)!
            let router = r.resolve(VerifyRoutingLogic.self, argument: view)!

            view.input = input
            view.router = router

            return view
        }
    }
}
