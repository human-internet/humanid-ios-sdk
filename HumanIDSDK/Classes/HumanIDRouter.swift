import Swinject

internal class HumanIDRouter {

    public static let shared = HumanIDRouter()

    private init() {}

    func resolvedVerifyVC(name appName: String, image appImage: String) -> VerifyViewController {
        let assembler = Assembler()
        assembler.apply(assembly: VerifyConfigurator())

        let verifyVC = assembler.resolver.resolve(VerifyViewController.self)!
        verifyVC.appName = appName
        verifyVC.appImage = appImage

        return verifyVC
    }
}
