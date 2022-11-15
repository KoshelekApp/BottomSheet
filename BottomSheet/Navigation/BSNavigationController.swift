import UIKit

public final class BSNavigationController: UIViewController {

    private let contentView = BSNavigationView()

    override public func loadView() {
        view = contentView
    }
}
