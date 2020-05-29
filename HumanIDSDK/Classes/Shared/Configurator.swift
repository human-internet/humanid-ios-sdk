import Swinject

internal class Configurator: Assembly {

    func assemble(container: Container) {
        container.register(Network.self) { _ in
            return Network()
        }
    }
}
