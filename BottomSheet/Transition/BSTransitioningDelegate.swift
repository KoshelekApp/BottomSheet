import UIKit

final class BSTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        BSPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
    }

    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CoverVerticalPresentAnimatedTransitioning()
    }

    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CoverVerticalDismissAnimatedTransitioning()
    }
}
