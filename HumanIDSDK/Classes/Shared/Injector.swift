import Swinject

internal class Injector {

    static let shared = Injector.resolved()

    private static func resolved() -> Assembler {
        let assembler = Assembler()
        assembler.apply(assemblies: [
            Configurator(),
            RequestOTPConfigurator(),
            LoginConfigurator()
        ])

        return assembler
    }
}
