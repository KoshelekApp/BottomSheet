import UIKit

final class ListDataProvider {

    struct Item {
        let image: UIImage?
        let title: String
    }

    let items: [Item] = [
        .init(image: Constants.imageDog1, title: "Akita (yes, it’s Hatiko)"),
        .init(image: Constants.imageDog2, title: "Husky"),
        .init(image: Constants.imageDog3, title: "Samoyed")
    ]

    private enum Constants {
        static var imageDog1: UIImage { UIImage(named: "dog_1") ?? UIImage() }
        static var imageDog2: UIImage { UIImage(named: "dog_2") ?? UIImage() }
        static var imageDog3: UIImage { UIImage(named: "dog_3") ?? UIImage() }
    }
}
