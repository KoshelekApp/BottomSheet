import UIKit

class RootViewController: UIViewController {

    private let contentView = RootView()
    private let customTransitioningDelegate = BSTransitioningDelegate()

    override func loadView() {
        view = contentView
    }

    @objc
    func presentVCAsBottomSheet() {
        let vc = TextViewController()
        vc.transitioningDelegate = customTransitioningDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
}
