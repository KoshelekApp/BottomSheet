import UIKit

class RootViewController: UIViewController {

    private let contentView = RootView()

    override func loadView() {
        view = contentView
    }

    @objc
    func presentVCAsBottomSheet() {
        let vc = TextViewController()
        present(vc, animated: true)
    }
}
