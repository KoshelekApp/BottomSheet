import UIKit

public final class BSNavigationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createView() {
        setupConstraints()
        configure()
    }

    private func setupConstraints() {
        
    }

    private func configure() {
        backgroundColor = .secondaryBackground
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
