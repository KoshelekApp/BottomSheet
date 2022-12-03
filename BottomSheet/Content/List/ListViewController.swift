import UIKit

final class ListViewController: UIViewController, UICollectionViewDataSource {

    private lazy var contentView = ListView()
    private lazy var dataProvider = ListDataProvider()
    private let cellIdentifier = String.init(describing: ListCell.self)

    override func loadView() {
        view = contentView
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(
            ListCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataProvider.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ListCell
        let item = dataProvider.items[indexPath.item]
        cell.imageView.image = item.image
        cell.titleLabel.text = item.title

        return cell
    }
}
