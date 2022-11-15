import UIKit

final class RootView: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "koshelek_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.textAlignment = .center
        label.font = .header1
        label.text = "Bottom Sheet Examples"
        return label
    }()

    private lazy var openAsBottomSheetButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(named: "ic_open_vc"), for: .normal)
        button.setTitle("Open as bottom sheet", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.setTitleColor(.primaryText, for: .normal)
        button.backgroundColor = .primaryAction
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(
            nil,
            action: #selector(RootViewController.presentVCAsBottomSheet),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var openInBottomSheetButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(named: "ic_open_nav"), for: .normal)
        button.setTitle("Open bottom sheet navigation ", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.setTitleColor(.primaryText, for: .normal)
        button.backgroundColor = .primaryAction
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(
            nil,
            action: #selector(RootViewController.presentVCInBottomSheet),
            for: .touchUpInside
        )
        return button
    }()

    init() {
        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(openAsBottomSheetButton)
        stackView.addArrangedSubview(openInBottomSheetButton)

        stackView.setCustomSpacing(40, after: logoImageView)
        stackView.setCustomSpacing(30, after: titleLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            openAsBottomSheetButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            openInBottomSheetButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])

        backgroundColor = .primaryBackground
    }

    enum Constants {
        static let buttonHeight: CGFloat = 80
        static let buttonCornerRadius: CGFloat = 10
    }
}
