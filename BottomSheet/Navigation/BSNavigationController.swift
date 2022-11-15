import UIKit

public final class BSNavigationController: UIViewController {

    private let contentView = BSNavigationView()
    private let customTransitioningDelegate = BSTransitioningDelegate()
    private(set) var viewControllers: [UIViewController] = []

    public var topViewController: UIViewController? {
        viewControllers.last
    }

    public var navigationBar: UINavigationBar {
        contentView.navigationBar
    }

    private(set) var isNavigationBarHidden: Bool = false {
        didSet {
            updateAdditionalSafeAreaInsets()
        }
    }

    convenience init(rootViewController: UIViewController) {
        self.init()
        setRootViewController(rootViewController)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = customTransitioningDelegate
        modalPresentationStyle = .custom
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = contentView
        updateAdditionalSafeAreaInsets()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateAdditionalSafeAreaInsets()
    }

    private func updateAdditionalSafeAreaInsets() {
        let top = isNavigationBarHidden
        ? 0
        : max(contentView.navigationBar.bounds.height, Constants.navBarHeight)
        additionalSafeAreaInsets = UIEdgeInsets(
            top: top,
            left: 0,
            bottom: 0,
            right: 0
        )
    }

    private func setRootViewController(_ viewController: UIViewController) {
        viewControllers = [viewController]
        navigationBar.setItems(viewControllers.map { $0.navigationItem }, animated: false)

        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        guard let to = viewControllers.last else {
            return
        }

        if let from = topViewController {
            pushTransition(from: from, to: to, animated: animated)
        } else {
            setRootViewController(to)
        }

        self.viewControllers = viewControllers
        navigationBar.setItems(viewControllers.map { $0.navigationItem }, animated: animated)
    }

    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let from = topViewController else {
            setRootViewController(viewController)
            return
        }

        pushTransition(from: from, to: viewController, animated: animated)
        self.viewControllers.append(viewController)
        navigationBar.setItems(viewControllers.map { $0.navigationItem }, animated: animated)
    }

    @discardableResult
    public func popViewController(animated: Bool) -> UIViewController? {
        guard let from = topViewController, from != viewControllers.first else { return nil }

        viewControllers.removeLast()
        if let to = topViewController {
            popTransition(from: from, to: to, animated: animated)
        }
        navigationBar.setItems(viewControllers.map { $0.navigationItem }, animated: animated)
        return from
    }

    private var contentMaxHeight: CGFloat {
        let keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)
        let topInset = keyWindow?.safeAreaInsets.top ?? 0
        return UIScreen.main.bounds.height - topInset
    }

    private func pushTransition(from: UIViewController, to: UIViewController, animated: Bool) {
        guard let containerView = presentationController?.containerView else {
            return
        }

        addChild(to)
        view.addSubview(to.view)
        from.willMove(toParent: nil)
        to.willMove(toParent: self)

        view.removeConstraints(view.constraints.filter { $0.firstItem === from.view || $0.secondItem === from.view })

        from.view.translatesAutoresizingMaskIntoConstraints = false
        to.view.translatesAutoresizingMaskIntoConstraints = false

        let fromTop = from.view.topAnchor.constraint(equalTo: view.topAnchor)
        let fromLeading = from.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)

        let toTop = to.view.topAnchor.constraint(equalTo: view.topAnchor)
        let toLeading = to.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width)

        NSLayoutConstraint.activate([
            fromTop,
            fromLeading,
            from.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            from.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            from.view.heightAnchor.constraint(lessThanOrEqualToConstant: contentMaxHeight),

            toLeading,
            to.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            to.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            to.view.heightAnchor.constraint(lessThanOrEqualToConstant: contentMaxHeight)
        ])

        view.layoutIfNeeded()

        fromTop.isActive = false
        fromLeading.constant = -view.bounds.width * 0.3
        toTop.isActive = true
        toLeading.constant = 0

        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(Constants.timingFunction)
        CATransaction.setDisableActions(!animated)

        UIView.animate(
            withDuration: Constants.duration,
            animations: {
                containerView.layoutIfNeeded()
            }, completion: { _ in
                to.didMove(toParent: self)
                from.removeFromParent()
                from.view.removeFromSuperview()
                from.didMove(toParent: nil)
            }
        )

        CATransaction.commit()
    }

    private func popTransition(from: UIViewController, to: UIViewController, animated: Bool) {
        guard let containerView = presentationController?.containerView else {
            return
        }

        addChild(to)
        view.insertSubview(to.view, at: 0)
        from.willMove(toParent: nil)
        to.willMove(toParent: self)

        from.view.translatesAutoresizingMaskIntoConstraints = false
        to.view.translatesAutoresizingMaskIntoConstraints = false

        view.removeConstraints(view.constraints.filter { $0.firstItem === from.view || $0.secondItem === from.view })

        let fromTop = from.view.topAnchor.constraint(equalTo: view.topAnchor)
        let fromLeading = from.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)

        let toTop = to.view.topAnchor.constraint(equalTo: view.topAnchor)
        let toLeading = to.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -view.bounds.width * 0.3)

        NSLayoutConstraint.activate([
            fromTop,
            fromLeading,
            from.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            from.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            from.view.heightAnchor.constraint(lessThanOrEqualToConstant: contentMaxHeight),

            toLeading,
            to.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            to.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            to.view.heightAnchor.constraint(lessThanOrEqualToConstant: contentMaxHeight)
        ])

        view.layoutIfNeeded()

        fromTop.isActive = false
        fromLeading.constant = view.bounds.width
        toTop.isActive = true
        toLeading.constant = 0

        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(Constants.timingFunction)
        CATransaction.setDisableActions(!animated)
        UIView.animate(
            withDuration: Constants.duration,
            animations: {
                containerView.layoutIfNeeded()
            }, completion: { _ in
                to.didMove(toParent: self)
                from.removeFromParent()
                from.view.removeFromSuperview()
                from.didMove(toParent: nil)
            }
        )

        CATransaction.commit()
    }

    private enum Constants {
        static let duration: TimeInterval = 0.35
        static let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 1, 0.42, 1)
        static let navBarHeight: CGFloat = 44
    }
}
