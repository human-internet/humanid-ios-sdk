import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    var exchangeToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        messageLabel.text = "Your token is\n\n\(exchangeToken)"
    }
}
