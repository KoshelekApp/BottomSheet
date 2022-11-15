import UIKit

final class TextViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .common
        label.text = "Pets, especially dogs, can reduce stress, anxiety, and depression, ease loneliness, encourage exercise and playfulness, and even improve your cardiovascular health. Caring for an animal can help children grow up more secure and active. Pets also provide valuable companionship for older adults."
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
