import UIKit


class ImagesViewController: UICollectionViewController, CollectionViewDelegateGridLayout {
    private let cellIdentifier = "ImagesCollectionViewCellIdentifier"
    private var dataSource: ImagesDataSource?
    private var viewModel: ImagesViewModel?
    private var gridLayout: GridLayout {
        get {
            return self.collectionViewLayout as! GridLayout
        }
    }
    
    init() {
        let gridLayout = GridLayout(numberOfColumns: 4)
        super.init(collectionViewLayout: gridLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = ImagesDataSource()
        self.viewModel = ImagesViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(collectionView: UICollectionView) {
        collectionView.registerClass(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel!.numberOfImages()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
override     
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ImagesCollectionViewCell
        
        if let images = self.viewModel?[indexPath] {
            cell.images = images
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let viewModel = self.viewModel else {
            return self.gridLayout.columnWidthForCollectionView()
        }
        
        guard let images = viewModel[indexPath] else {
            return self.gridLayout.columnWidthForCollectionView()
        }
        
        let maxSize = images.reduce(CGSize.zeroSize) { (maxSize, image) -> CGSize in
            return CGSize(width: max(maxSize.width, image.size.width), height: max(maxSize.height,image.size.height))
        }
        
        return (maxSize.height / maxSize.width) * self.gridLayout.columnWidthForCollectionView()
    }
}

