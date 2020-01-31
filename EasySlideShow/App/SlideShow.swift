//
//  EasySlideShow.swift
//  ImageSlideShow
//
//  Created by Daniel Hjärtström on 2020-01-30.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

public class Slideshow: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var imageAspect: UIView.ContentMode = .scaleAspectFit
    public var showsPageControl: Bool = false {
        didSet {
            if showsPageControl {
                pageControl.numberOfPages = items.count
            }
        }
    }
    
    private var items = [Any]()
    
    private lazy var pageControlView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 30).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var pageControl: UIPageControl = {
        let temp = UIPageControl()
        temp.currentPage = 0
        temp.currentPageIndicatorTintColor = UIColor.white
        temp.pageIndicatorTintColor = UIColor.lightGray
        pageControlView.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: pageControlView.leadingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: pageControlView.trailingAnchor, constant: -5.0).isActive = true
        temp.topAnchor.constraint(equalTo: pageControlView.topAnchor, constant: 5.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: pageControlView.bottomAnchor, constant: -5.0).isActive = true
        return temp
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let temp = UICollectionViewFlowLayout()
        temp.scrollDirection = .horizontal
        temp.minimumLineSpacing = 0
        temp.minimumInteritemSpacing = 0
        return temp
    }()
    
    private lazy var collectionView: UICollectionView = {
        let temp = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        temp.backgroundColor = UIColor.white
        temp.allowsMultipleSelection = false
        temp.dataSource = self
        temp.delegate = self
        temp.isPagingEnabled = true
        temp.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Cells.imageCollectionViewCell)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return temp
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        configureFrames()
    }
    
    public convenience init(images: [String]) {
        self.init(frame: .zero)
        items = images
    }
    
    public convenience init(images: [URL]) {
        self.init(frame: .zero)
        items = images
    }
    
    public convenience init(images: [UIImage?]) {
        self.init(frame: .zero)
        items = images
    }
    
    private func configureFrames() {}
    
    private func commonInit() {
        collectionView.reloadData()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        if showsPageControl {
            pageControl.currentPage = index
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.imageCollectionViewCell, for: indexPath) as? ImageCollectionViewCell {
            cell.configure(item, aspect: imageAspect)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }

    
}
