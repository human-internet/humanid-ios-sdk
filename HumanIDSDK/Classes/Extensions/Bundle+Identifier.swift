internal extension Bundle {

    static var humanID: Bundle {
        guard let path = Bundle(for: HumanIDSDK.self).path(forResource: "HumanIDSDKResources", ofType: "bundle") else { return .main }
        return Bundle(path: path)!
    }
}
