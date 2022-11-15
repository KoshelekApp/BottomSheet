import UIKit

public final class BSNavigationView: UIView {

    public let navigationBar = UINavigationBar()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createView() {
        addSubview(navigationBar)

        setupConstraints()
        configure()
    }

    private var navigationBarConstraints: [NSLayoutConstraint] {
        [
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
    }

    private func setupConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            navigationBarConstraints
        )
    }

    private func configure() {
        backgroundColor = .secondaryBackground
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(color: .secondaryBackground), for: .default)
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.primaryText
        ]
    }

    override public func addSubview(_ view: UIView) {
        super.addSubview(view)
        bringSubviewToFront(navigationBar)
    }

    override public func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        bringSubviewToFront(navigationBar)
    }

    public func setNavigationBarHidden(_ hidden: Bool) {
        navigationBar.isHidden = hidden
    }
}
