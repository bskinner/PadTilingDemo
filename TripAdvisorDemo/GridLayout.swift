import UIKit

protocol CollectionViewDelegateGridLayout: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, sizeForItemAtIndexPath: NSIndexPath) -> CGSize
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
    
    required init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        
    }
    
}
