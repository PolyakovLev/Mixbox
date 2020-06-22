#if MIXBOX_ENABLE_IN_APP_SERVICES
import Foundation
import UIKit

public protocol FakeCellManagerForCollectionViewCell: class {
    func isFakeCell(forCell: UICollectionViewCell) -> Bool
    func startCollectionViewUpdates(forCollectionView: UICollectionView) -> MixboxCollectionViewUpdatesActivity
    func getConfigureAsFakeCell(forCell: UICollectionViewCell) -> (() -> ())?
    func setConfigureAsFakeCell(configureAsFakeCell: (() -> ())?, forCell: UICollectionViewCell)
}

#endif
