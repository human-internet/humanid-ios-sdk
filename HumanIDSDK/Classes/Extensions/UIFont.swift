internal enum FontType {
    case titiliumWebRegular
    case titiliumWebBold
    case titiliumWebSemiBold
}

internal extension UIFont {

    static func font(type: FontType, size: CGFloat) -> UIFont? {
        switch type {
        case .titiliumWebRegular:
            return UIFont(name: "Roboto-Regular", size: size)
        case .titiliumWebBold:
            return UIFont(name: "Roboto-Bold", size: size)
        case .titiliumWebSemiBold:
            return UIFont(name: "Roboto-SemiBold", size: size)
        }
    }

    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return font(type: .titiliumWebSemiBold, size: size)!
    }

    private func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
}
