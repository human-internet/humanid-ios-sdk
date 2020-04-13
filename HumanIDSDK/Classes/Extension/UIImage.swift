import Foundation

extension UIImage {

    static func fromSDK(name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle(identifier: "org.humanid.HumanIDSDK"), compatibleWith: nil)
    }
}
