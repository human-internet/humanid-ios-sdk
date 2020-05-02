import UIKit

internal extension TimeInterval {

    func toMinutesSeconds() -> String {
        let time = Int(self)
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02i : %02i", minutes, seconds)
    }
}
