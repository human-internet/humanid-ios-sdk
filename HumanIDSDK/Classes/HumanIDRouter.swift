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

    func resolvedRevoke() {
        let assembler = Assembler()
        assembler.apply(assembly: RevokeConfigurator())

        guard
            let appId = KeyChain.retrieveString(key: .appIDKey),
            let appSecret = KeyChain.retrieveString(key: .appSecretKey),
            let deviceHash = KeyChain.retrieveString(key: .deviceHash) else {
                return
        }

        let request = Revoke.Request(appId: appId, appSecret: appSecret, userHash: deviceHash)
        let input = assembler.resolver.resolve(RevokeInteractorInput.self)!
        input.revoke(with: request)
    }
}
