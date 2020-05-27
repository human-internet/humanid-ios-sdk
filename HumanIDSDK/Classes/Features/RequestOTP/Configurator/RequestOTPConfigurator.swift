import Swinject

internal class RequestOTPConfigurator: Assembly {

    func assemble(container: Container) {
        container.register(RequestOTPInteractorOutput.self) { (r, output: RequestOTPPresenterOutput) in
            return RequestOTPPresenter(output: output)
        }

        container.register(RequestOTPWorkerDelegate.self) { (r) in
            let datasource = r.resolve(Network.self)!
            return RequestOTPWorker(datasource: datasource)
        }

        container.register(RequestOTPInteractorInput.self) { (r, output: RequestOTPPresenterOutput) in
            let output = r.resolve(RequestOTPInteractorOutput.self, argument: output)!
            let worker = r.resolve(RequestOTPWorkerDelegate.self)!

            return RequestOTPInteractor(output: output, worker: worker)
        }

        container.register(RequestOTPRoutingLogic.self) { (r, view: RequestOTPViewController) in
            return RequestOTPRouter(view: view)
        }

        container.register(RequestOTPViewController.self) { (r) in
            let view = RequestOTPViewController()
            let input = r.resolve(RequestOTPInteractorInput.self, argument: view as RequestOTPPresenterOutput)!
            let router = r.resolve(RequestOTPRoutingLogic.self, argument: view)!

            view.input = input
            view.router = router

            return view
        }
    }
}
