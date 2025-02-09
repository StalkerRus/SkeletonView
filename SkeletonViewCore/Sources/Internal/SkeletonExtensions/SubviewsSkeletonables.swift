//  Copyright © 2018 SkeletonView. All rights reserved.

import UIKit

extension UIView {
    
    @objc var subviewsSkeletonables: [UIView] {
        subviewsToSkeleton.filter { $0.isSkeletonable }
    }

    @objc var subviewsToSkeleton: [UIView] {
        subviews
    }
    
}

extension UITableView {
    
    override var subviewsToSkeleton: [UIView] {
		// on `UIViewController'S onViewDidLoad`, the window is still nil.
		// Some developer trying to call `view.showAnimatedSkeleton()`
		// when the request or data is loading which sometimes happens before the ViewDidAppear
		guard window != nil else { return [] }
        
        var result = [UIView]()

        for subview in subviews {
            if String(describing: type(of: subview)) == "UITableViewWrapperView" {
                result.append(contentsOf: subview.subviews)
            } else {
                result.append(subview)
            }
        }
        
        return result
    }
    
}

extension UITableViewCell {
    override var subviewsToSkeleton: [UIView] {
        contentView.subviews
    }
}

extension UITableViewHeaderFooterView {
    override var subviewsToSkeleton: [UIView] {
        contentView.subviews
    }
}

extension UICollectionView {
    override var subviewsToSkeleton: [UIView] {
        subviews
    }
}

extension UICollectionViewCell {
    override var subviewsToSkeleton: [UIView] {
        contentView.subviews
    }
}

extension UIStackView {
    override var subviewsToSkeleton: [UIView] {
        arrangedSubviews
    }
}

extension UIScrollView {
    var isOrthogonalScrollView: Bool {
        let isInCollectionView = superview as? UICollectionView != nil
        return isInCollectionView && subviews.contains { $0.isSkeletonable }
    }

    override public var isSkeletonable: Bool {
        get {
            super.isSkeletonable || isOrthogonalScrollView
        }
        set {
            super.isSkeletonable = newValue
        }
    }
}
