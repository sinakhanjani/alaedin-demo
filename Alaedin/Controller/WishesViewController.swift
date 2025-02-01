//
//  ColectionViewController.swift
//  alladein
//
//  Created by Teodik Abrami on 1/12/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import AVKit

class WishesViewController: UIViewController, UICollectionViewDelegateFlowLayout,AVPlayerViewControllerDelegate {

    let cellIdentifier = "wishesCell"
    
    fileprivate let videoPlayURL = "http://cheraghjadoo.com/media/video02.mp4"


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ginieImageView: UIImageView!
    
    var categories: [Category]?
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicatorAnimate()
        collectionView.collectionViewLayout.invalidateLayout()
        
        let layout = CustomUPCarouselFlowLayout()
        layout.itemSize = CGSize(width:260, height:400)
        layout.scrollDirection = .horizontal
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 0.0)
        self.collectionView.collectionViewLayout = layout
        updateUI()
        ginieImageView.transform = CGAffineTransform.init(translationX: ginieImageView.frame.origin.x, y: ginieImageView.frame.origin.y + 14)
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: GO_TO_MAIN_NOTIFY, object: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            if !DataManager.shared.playVideo3 {
                self.justDownloadVideo(videoPlayName: self.videoPlayURL, encodeName: "video02") {
                    self.present(VideoPlayerViewController.showModal(videoPlayURL: self.videoPlayURL, encodeName: "video02", key: "3", showCloseButton: true), animated: true, completion: nil)
                }
            }
        }
    }
    
    func updateUI() {
        WebServices.instance.getCategory { (categories) in
            DispatchQueue.main.async {
                self.categories = categories
                WebServices.instance.getProducts(catId: self.categories?[0].id ?? 1, completion: { (product) in
                    DispatchQueue.main.async {
                        if let product = product {
                            self.products = product
                            self.collectionView.reloadData()
                            self.stopIndicatorAnimate()
                        } else {
                            self.iSConnected {
                                DispatchQueue.main.async {
                                    self.updateUI()
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    
    @objc func goToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.6, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.repeat,.allowUserInteraction,.curveEaseOut,.autoreverse], animations: {
            self.ginieImageView.transform = CGAffineTransform.identity
        }) { (status) in
            //
        }


    }
    
    func playVideo(url: URL) {
        let player = AVPlayer.init(url: url)
        let playerController = AVPlayerViewController()
        playerController.delegate = self
        playerController.player = player
        //self.addChildViewController(playerController)
        //self.view.addSubview(playerController.view)
        //playerController.view.frame = self.view.frame
        present(playerController, animated: true, completion: nil)
        player.play()
    }
    

    @IBAction func detailButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        let buttonPosition = button.convert(CGPoint.zero, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: buttonPosition)
        presentGiftDetailViewController(product: products![(indexPath?.row)!])
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        guard Authorization.shared.isLoggedIn else { presentSignUpViewController() ; return }
        let button = sender as! UIButton
        let buttonPosition = button.convert(CGPoint.zero, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: buttonPosition)
        let product = products![(indexPath?.row)!]
        performSegue(withIdentifier: "wishesToNewFactor", sender: product)
    }
    
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        self.presentMenuViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewFactorViewController {
            vc.product = sender as! Product
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func unwindToWishes(segue: UIStoryboardSegue) {}
    
    func justDownloadVideo(videoPlayName: String, encodeName: String, escape: @escaping () -> Void) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destURL = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
        if FileManager.default.fileExists(atPath: destURL.path) {
            print("file already exist at \(destURL)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    escape()
                }
            }
            return
        }
        if let videoURL = URL.init(string: videoPlayName) {
            print(videoURL)
            let task = URLSession.shared.downloadTask(with: videoURL) { (location, response, error) in
                if let _ = error {
                    return
                }
                if let location = location {
                    do {
                        try FileManager.default.moveItem(at: location, to: destURL)
                        DispatchQueue.main.async {
                            escape()
                            print("download video complete")
                        }
                    } catch {
                        print(error as Any)
                    }
                } else {
                    
                }
            }
            task.resume()
        }
    }
    
}

extension WishesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! WishesCollectionViewCell
        guard let product = products?[indexPath.row] else { return cell }
        let price = "\(product.discount! + product.priceToWish!)"
        cell.priceToPayLabel.text = price.prefix(price.count - 3) + " هزار تومان"
        cell.prizeImageView.loadImageUsingCache(withUrl: product.avatarURL ?? "")
        cell.prizeNameLabel.text = product.name
        return cell
    }

}


public enum UPCarouselFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}


open class CustomUPCarouselFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate struct LayoutState {
        var size: CGSize
        var direction: UICollectionView.ScrollDirection
        func isEqual(_ otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }
    
    @IBInspectable open var sideItemScale: CGFloat = 0.6
    @IBInspectable open var sideItemAlpha: CGFloat = 0.6
    @IBInspectable open var sideItemShift: CGFloat = 0.0
    open var spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 5)
    
    fileprivate var state = LayoutState(size: CGSize.zero, direction: .horizontal)
    
    
    override open func prepare() {
        super.prepare()
        let currentState = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)
        
        if !self.state.isEqual(currentState) {
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }
    
    fileprivate func setupCollectionView() {
        guard let collectionView = self.collectionView else { return }
        if collectionView.decelerationRate != UIScrollView.DecelerationRate.fast {
            collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        }
    }
    
    fileprivate func updateLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionSize = collectionView.bounds.size
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let side = isHorizontal ? self.itemSize.width : self.itemSize.height
        let scaledItemOffset =  (side - side*self.sideItemScale) / 2
        switch self.spacingMode {
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = isHorizontal ? xInset : yInset
            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }
    
    fileprivate func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let collectionCenter = isHorizontal ? collectionView.frame.size.width/2 : collectionView.frame.size.height/2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset
        
        let maxDistance = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        let shift = (1 - ratio) * self.sideItemShift
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
        
        if isHorizontal {
            attributes.center.y = attributes.center.y + shift
        } else {
            attributes.center.x = attributes.center.x + shift
        }
        
        return attributes
    }
    
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView , !collectionView.isPagingEnabled,
            let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds)
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }
        
        let isHorizontal = (self.scrollDirection == .horizontal)
        
        let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
        let proposedContentOffsetCenterOrigin = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide
        
        var targetContentOffset: CGPoint
        if isHorizontal {
            let closest = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        }
        else {
            let closest = layoutAttributes.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
        }
        
        return targetContentOffset
    }
}

