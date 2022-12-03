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

    @objc
    func presentVCInBottomSheet() {
        let firstVC = FirstViewController()
        let bottomSheet = BSNavigationController(rootViewController: firstVC)
        firstVC.nextTapHandler = {
            let secondVC = SecondViewController()
            secondVC.backTapHandler = {
                bottomSheet.popViewController(animated: true)
            }
            bottomSheet.pushViewController(secondVC, animated: true)
        }
        present(bottomSheet, animated: true)
    }

    @objc
    func presentCollectionAsBottomSheet() {

    }
}
