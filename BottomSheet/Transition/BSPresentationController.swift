import UIKit

final class BSPresentationController: UIPresentationController {

    override var shouldPresentInFullscreen: Bool {
        false
    }

    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        return recognizer
    }()

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView,
              let presentedView = presentedView
        else { return }

        presentedView.translatesAutoresizingMaskIntoConstraints = false
        dimmView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(dimmView)
        containerView.addSubview(presentedView)

        dimmView.alpha = 0
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 1
        }

        NSLayoutConstraint.activate(
            [
                dimmView.topAnchor.constraint(equalTo: containerView.topAnchor),
                dimmView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                dimmView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                dimmView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                presentedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                presentedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                presentedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                presentedView.heightAnchor.constraint(
                    lessThanOrEqualTo: containerView.heightAnchor,
                    constant: -containerView.safeAreaInsets.top
                )
            ]
        )
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmView.removeFromSuperview()
            presentedView?.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 0
        }
    }

    private func performAlongsideTransitionIfPossible(_ animation: @escaping () -> Void ) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            animation()
            return
        }

        coordinator.animate { _ in
            animation()
        }
    }

    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
