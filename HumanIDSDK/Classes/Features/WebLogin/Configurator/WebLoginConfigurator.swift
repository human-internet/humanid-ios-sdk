import Swinject

internal final class WebLoginConfigurator: Assembly {

    func assemble(container: Container) {
        container.register(WebLoginWorkerProtocol.self) { (r) in
            let datasource = r.resolve(Network.self)!
            let worker = WebLoginWorker()

            worker.datasource = datasource

            return worker
        }

        container.register(WebLoginInteractorOutput.self) { (r, output: WebLoginPresenterOutput) in
            let presenter = WebLoginPresenter()
            presenter.output = output

            return presenter
        }

        container.register(WebLoginInteractorInput.self) { (r, output: WebLoginPresenterOutput) in
            let output = r.resolve(WebLoginInteractorOutput.self, argument: output)!
            let worker = r.resolve(WebLoginWorkerProtocol.self)!
            let interactor = WebLoginInteractor()

            interactor.output = output
            interactor.worker = worker

            return interactor
        }

        container.register(WebLoginViewController.self) { (r) in
            let controller = WebLoginViewController()
            let input = r.resolve(WebLoginInteractorInput.self, argument: controller as WebLoginPresenterOutput)!

            controller.input = input

            return controller
        }
    }
}
