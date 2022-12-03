import UIKit

class CompactCollectionView: UICollectionView {

    override var contentSize: CGSize {
        didSet {
            fixHeight()
        }
    }

    private lazy var collectionHeightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 0)
        constraint.priority = .defaultLow
        constraint.isActive = true
        return constraint
    }()

    private func fixHeight() {
        var height = collectionViewLayout.collectionViewContentSize.height
        + contentInset.top
        + contentInset.bottom
        + safeAreaInsets.bottom
        (collectionViewLayout as? UICollectionViewFlowLayout).map { height += $0.sectionInset.top }
        (collectionViewLayout as? UICollectionViewFlowLayout).map { height += $0.sectionInset.bottom }

        if height != 0 && height != CGFloat.infinity {
            collectionHeightConstraint.constant = height
        }
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer === panGestureRecognizer else {
            return true
        }

        if contentOffset.y == -contentInset.top, panGestureRecognizer.velocity(in: nil).y > 0 {
            return false
        }

        if contentOffset.y < -contentInset.top {
            return false
        }

        return true
    }
}
