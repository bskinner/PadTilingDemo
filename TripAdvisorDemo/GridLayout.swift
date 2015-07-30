import UIKit

protocol CollectionViewDelegateGridLayout: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

func /(lhs: Int, rhs: Int) -> Int {
    return Int(floor(Double(lhs) / Double(rhs)))
}

class GridLayout: UICollectionViewLayout {
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var numberOfItems: Int = 0
    private var columnWidth: CGFloat = 0
    private var delegate: CollectionViewDelegateGridLayout? {
        get {
            if let delegate = self.collectionView?.delegate as? CollectionViewDelegateGridLayout {
                return delegate
            } else {
                return nil
            }
        }
    }
    
    var numberOfColumns: Int = 4 {
        willSet(newNumberOfColums) {
            assert(newNumberOfColums > 0, "number of colums must be greater than 0")
        }
        
        didSet {
            self.invalidateLayout()
        }
    }
    
    convenience override init() {
        self.init(numberOfColumns: 4)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
        super.init()
    }
    
    func columnWidthForCollectionView() -> CGFloat {
        return self.columnWidth
    }
    
    // MARK: - Overrides
    override func prepareLayout() {
        super.prepareLayout()
        
        if let collectionView = self.collectionView {
            let bounds = collectionView.bounds
            self.attributes = []
            self.numberOfItems = self.numberOfItemsInCollectionView()
        } else {
            self.columnWidth = 0
        }
    }
    
    // MARK: Required
    override func collectionViewContentSize() -> CGSize {
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    // MARK: Optional
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    override func initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    override func initialLayoutAttributesForAppearingDecorationElementOfKind(elementKind: String, atIndexPath decorationIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    override func finalLayoutAttributesForDisappearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    override func finalLayoutAttributesForDisappearingDecorationElementOfKind(elementKind: String, atIndexPath decorationIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
    
    // MARK: - Helpers
    private func resetLayout() {
        self.columnWidth = 0
        self.numberOfItems = 0
        self.attributes = nil
    }
    
    private func numberOfItemsInCollectionView() -> Int {
        guard let collectionView = self.collectionView else {
            return 0
        }
        
        guard collectionView.numberOfSections() > 0 else {
            return 0
        }
        
        return collectionView.numberOfItemsInSection(0)
    }
    
    private func frameForItem(indexPath: NSIndexPath) -> CGRect {
        guard let size = self.sizeForItem(indexPath) else {
            return CGRect.zeroRect
        }
        
        guard let origin = self.originForItem(indexPath) else {
            return CGRect.zeroRect
        }
        
        return CGRect(origin: origin, size: size)
    }
    
    private func sizeForItem(indexPath: NSIndexPath) -> CGSize? {
        guard let collectionView = self.collectionView else {
            return nil
        }
        
        guard let delegate = self.delegate else {
            return nil
        }
        
        let height = delegate.collectionView(collectionView, heightForItemAtIndexPath: indexPath)
        return CGSize(width: self.columnWidth, height: height)
    }
    
    private func originForItem(indexPath: NSIndexPath) -> CGPoint? {
        let column = indexPath.item % self.numberOfColumns
        let row = indexPath.item / self.numberOfColumns
        
        var origin = CGPoint.zeroPoint
        if column > 0 {
            let previousIndexPath = indexPathForItem(row, column: column - 1)
            let previousCellOrigin = self.originForItem(previousIndexPath)!
            origin.x = previousCellOrigin.x
        }
        
        if row > 0 {
            let previousIndexPath = indexPathForItem(row - 1, column: column)
            let previousCellOrigin = self.originForItem(previousIndexPath)!
            let previousCellSize = self.sizeForItem(previousIndexPath)!
            origin.y = previousCellOrigin.y + previousCellSize.width
        }
        
        return origin
    }
    
    private func indexPathForItem(row: Int, column: Int) -> NSIndexPath {
        let item = (row * self.numberOfColumns) + column
        let section = 0
        return NSIndexPath(forItem: item, inSection: section)
    }
    
}
