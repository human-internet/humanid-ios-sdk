import Swinject

class RevokeConfigurator: Assembly {

    func assemble(container: Container) {
        container.register(Network.self) { _ in
            return Network()
        }

        container.register(RevokeInteractorOutput.self) { _ in
            return RevokePresenter()
        }

        container.register(RevokeWorkerDelegate.self) { (r) in
            let datasource = r.resolve(Network.self)!
            return RevokeWorker(datasource: datasource)
        }

        container.register(RevokeInteractorInput.self) { (r) in
            let output = r.resolve(RevokeInteractorOutput.self)!
            let worker = r.resolve(RevokeWorkerDelegate.self)!

            return RevokeInteractor(output: output, worker: worker)
        }
    }
}
