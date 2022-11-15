import UIKit

final class CoverVerticalPresentAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.35

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = makeAnimator(using: transitionContext)
        animator?.startAnimation()
    }

    private func makeAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating? {
        guard let toView = transitionContext.view(forKey: .to)
        else {
            return nil
        }

        let containerView = transitionContext.containerView
        containerView.layoutIfNeeded()

        toView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: toView.frame.height)

        let animator = UIViewPropertyAnimator(
            duration: duration,
            controlPoint1: CGPoint(x: 0.2, y: 1),
            controlPoint2: CGPoint(x: 0.42, y: 1)
        ) {
            toView.transform = .identity
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}
