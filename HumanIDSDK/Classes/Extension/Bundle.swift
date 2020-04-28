import PodAsset

internal extension Bundle {

    static var humanID: Bundle? {
        return PodAsset.bundle(forPod: "HumanIDSDK")
    }
}
