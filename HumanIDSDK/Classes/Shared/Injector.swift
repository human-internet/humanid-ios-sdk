import Swinject

internal class Injector {

    static let shared = Injector.resolved()

    private static func resolved() -> Assembler {
        let assembler = Assembler()
        assembler.apply(assemblies: [
            Configurator(),
            VerifyConfigurator(),
            RegisterConfigurator()
        ])

        return assembler
    }
}
