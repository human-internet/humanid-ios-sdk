import Foundation

open class HumanIDSDK {

    public static let shared = HumanIDSDK()

    private init() {}

    open func config(appID: String, appSecret: String) {
        // MARK: - Retrieve current deviceID automatically
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()

        _ = KeyChain.isStoreSuccess(key: .appIDKey, value: appID)
        _ = KeyChain.isStoreSuccess(key: .appSecretKey, value: appSecret)
        _ = KeyChain.isStoreSuccess(key: .deviceID, value: deviceID)
    }

    open func authorize(view viewController: UIViewController, name appName: String, image appImage: String) {
        let authorizeVC = AuthorizeWelcomeViewController(appName: appName, appImage: appImage)
        authorizeVC.delegate = viewController as? AuthorizeDelegate

        viewController.present(authorizeVC, animated: true)
    }

    open func verifyPhone(phoneNumber: String, countryCode: String, completion: @escaping (_ success: Bool, _ data: BaseResponse<DefaultResponse>) -> ()) {
        guard
            let appID = KeyChain.retrieveString(key: .appIDKey),
            let appSecret = KeyChain.retrieveString(key: .appSecretKey) else {
                completion(false, BaseResponse(message: "appID or appSecret not found", data: nil))
                return
        }

        let data = VerifyPhone(countryCode: countryCode, phone: phoneNumber, appId: appID, appSecret: appSecret)

        let jsonData = try? JSONEncoder().encode(data)
        Rest.post(url: .verifyPhone, data: jsonData, completion: {
            success, object, errormessage in

            guard
                let body = object,
                let response = try? JSONDecoder().decode(DefaultResponse.self, from: body) else {
                    completion(success, BaseResponse(message: errormessage, data: nil))
                    return
            }

            completion(success, BaseResponse(message: success.description, data: response))
        })
    }

    open func userRegistration(phoneNumber: String, countryCode: String, verificationCode: String, completion: @escaping (_ success: Bool, _ data: BaseResponse<DetailResponse>) -> ()) {
        guard
            let appID = KeyChain.retrieveString(key: .appIDKey),
            let appSecret = KeyChain.retrieveString(key: .appSecretKey),
            let deviceID = KeyChain.retrieveString(key: .deviceID) else {
                completion(false, BaseResponse(message: "appID, appSecret or deviceID not found", data: nil))
                return
        }

        let data = UserRegistration(countryCode: countryCode, phone: phoneNumber, deviceId: deviceID, verificationCode: verificationCode, notifId: "NONE", appId: appID, appSecret: appSecret)

        let jsonData = try? JSONEncoder().encode(data)
        Rest.post(url: .userRegistration, data: jsonData, completion: {
            success, object, errormessage in

            guard
                let body = object,
                let response = try? JSONDecoder().decode(DetailResponse.self, from: body) else {
                    let errorResponse = try? JSONDecoder().decode(DefaultResponse.self, from: errormessage!.data(using: .utf8)!)
                    completion(success, BaseResponse(message: errorResponse?.message, data: nil))
                    return
            }

            completion(success, BaseResponse(message: success.description, data: response))
        })
    }
}
