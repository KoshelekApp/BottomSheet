import UIKit

final class FirstViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .header2
        label.text = "Steps to Raising a Puppy"
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .common
        label.text = "Step 1: commit to all the pros/cons of having a dog"
        label.numberOfLines = 0
        return label
    }()

    var nextTapHandler: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let nextButton = UIButton()
        nextButton.transform = .init(scaleX: -1, y: 1)
        nextButton.titleLabel?.transform = .init(scaleX: -1, y: 1)
        nextButton.imageView?.transform = .init(scaleX: -1, y: 1)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.primaryAction, for: .normal)
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        nextButton.setImage(UIImage(named: "ic_next"), for: .normal)
        nextButton.addTarget(self, action: #selector(handleNextTap), for: .touchUpInside)
        let nextItem = UIBarButtonItem(customView: nextButton)
        navigationItem.title = "Navigation"
        navigationItem.rightBarButtonItem = nextItem
    }

    @objc func handleNextTap() {
        nextTapHandler()
    }
}
