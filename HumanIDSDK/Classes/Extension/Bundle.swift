import Foundation
import PodAsset

extension Bundle {

    static var humanID: Bundle? {
        let bundle = PodAsset.bundle(forPod: "HumanIDSDK")
        return bundle
    }
}
