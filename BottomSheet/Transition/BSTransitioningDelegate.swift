import UIKit

final class BSTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private var driver: BSTransitionDriver?

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        driver = BSTransitionDriver(controller: presented)

        return BSPresentationController(
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

    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
}
