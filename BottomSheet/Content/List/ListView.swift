import UIKit

final class ListView: UIView {

    lazy var collectionView: CompactCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width - (Constants.inset * 2),
            height: Constants.itemHeight
        )
        layout.minimumLineSpacing = Constants.spacing
        layout.sectionInset = UIEdgeInsets(
            top: Constants.inset,
            left: Constants.inset,
            bottom: 0,
            right: Constants.inset
        )
        let collectionView = CompactCollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .secondaryBackground
        layer.cornerRadius = 16
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        collectionView.backgroundColor = .secondaryBackground
        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private enum Constants {
        static let inset: CGFloat = 16
        static let spacing: CGFloat = 16
        static let itemHeight: CGFloat = 56
    }
}
