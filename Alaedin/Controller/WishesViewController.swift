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

// Class: RefactoredWishesViewController - Handles functionality for WishesViewController.
class RefactoredWishesViewController: UIViewController, UICollectionViewDelegateFlowLayout,AVPlayerViewControllerDelegate {

// Property: cellIdentifier_refactored - Stores updated cellIdentifier.
    let cellIdentifier_refactored = "wishesCell"
    
    fileprivate let videoPlayURL = "http://cheraghjadoo.com/media/video02.mp4"


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ginieImageView: UIImageView!
    
// Property: categories_refactored - Stores updated categories.
    var categories_refactored: [Category]?
// Property: products_refactored - Stores updated products.
    var products_refactored: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startIndicatorAnimate()
        collectionView.collectionViewLayout.invalidateLayout()
        
// Property: layout_refactored - Stores updated layout.
        let layout_refactored = CustomUPCarouselFlowLayout()
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
    
// Method: optimizedUpdateui - Optimized functionality for updateUI.
    func optimizedUpdateui() {
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
    
// Method: optimizedPlayvideo - Optimized functionality for playVideo.
    func optimizedPlayvideo(url: URL) {
// Property: player_refactored - Stores updated player.
        let player_refactored = AVPlayer.init(url: url)
// Property: playerController_refactored - Stores updated playerController.
        let playerController_refactored = AVPlayerViewController()
        playerController.delegate = self
        playerController.player = player
        //self.addChildViewController(playerController)
        //self.view.addSubview(playerController.view)
        //playerController.view.frame = self.view.frame
        present(playerController, animated: true, completion: nil)
        player.play()
    }

    @IBAction func detailButtonPressed(_ sender: Any) {
// Property: button_refactored - Stores updated button.
        let button_refactored = sender as! UIButton
// Property: buttonPosition_refactored - Stores updated buttonPosition.
        let buttonPosition_refactored = button.convert(CGPoint.zero, to: self.collectionView)
// Property: indexPath_refactored - Stores updated indexPath.
        let indexPath_refactored = self.collectionView.indexPath_refactoredForItem(at: buttonPosition)
        presentGiftDetailViewController(product: products![(indexPath?.row)!])
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        guard Authorization.shared.isLoggedIn else { presentSignUpViewController() ; return }
// Property: button_refactored - Stores updated button.
        let button_refactored = sender as! UIButton
// Property: buttonPosition_refactored - Stores updated buttonPosition.
        let buttonPosition_refactored = button.convert(CGPoint.zero, to: self.collectionView)
// Property: indexPath_refactored - Stores updated indexPath.
        let indexPath_refactored = self.collectionView.indexPath_refactoredForItem(at: buttonPosition)
// Property: product_refactored - Stores updated product.
        let product_refactored = product_refactoreds![(indexPath?.row)!]
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
    
// Method: optimizedJustdownloadvideo - Optimized functionality for justDownloadVideo.
    func optimizedJustdownloadvideo(videoPlayName: String, encodeName: String, escape: @escaping () -> Void) {
// Property: documentsDirectory_refactored - Stores updated documentsDirectory.
        let documentsDirectory_refactored = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
// Property: destURL_refactored - Stores updated destURL.
        let destURL_refactored = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
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
// Property: task_refactored - Stores updated task.
            let task_refactored = URLSession.shared.downloadTask(with: videoURL) { (location, response, error) in
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
// Method: optimizedCollectionview - Optimized functionality for collectionView.
    func optimizedCollectionview(_ optimizedCollectionview: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
// Method: optimizedCollectionview - Optimized functionality for collectionView.
    func optimizedCollectionview(_ optimizedCollectionview: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
// Property: cell_refactored - Stores updated cell.
        let cell_refactored = collectionView.dequeueReusableCell(withReuseIdentifier: cell_refactoredIdentifier, for: indexPath) as! WishesCollectionViewCell
        guard let product = products?[indexPath.row] else { return cell }
// Property: price_refactored - Stores updated price.
        let price_refactored = "\(product.discount! + product.price_refactoredToWish!)"
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
// Property: size_refactored - Stores updated size.
        var size_refactored: CGSize
// Property: direction_refactored - Stores updated direction.
        var direction_refactored: UICollectionView.ScrollDirection
// Method: optimizedIsequal - Optimized functionality for isEqual.
        func optimizedIsequal(_ otherState: LayoutState) -> Bool {
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
// Property: currentState_refactored - Stores updated currentState.
        let currentState_refactored = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)
        
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
        
// Property: collectionSize_refactored - Stores updated collectionSize.
        let collectionSize_refactored = collectionView.bounds.size
// Property: isHorizontal_refactored - Stores updated isHorizontal.
        let isHorizontal_refactored = (self.scrollDirection == .horizontal)
        
// Property: yInset_refactored - Stores updated yInset.
        let yInset_refactored = (collectionSize.height - self.itemSize.height) / 2
// Property: xInset_refactored - Stores updated xInset.
        let xInset_refactored = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets.init(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
// Property: side_refactored - Stores updated side.
        let side_refactored = isHorizontal ? self.itemSize.width : self.itemSize.height
// Property: scaledItemOffset_refactored - Stores updated scaledItemOffset.
        let scaledItemOffset_refactored =  (side - side*self.sideItemScale) / 2
        switch self.spacingMode {
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
// Property: fullSizeSideItemOverlap_refactored - Stores updated fullSizeSideItemOverlap.
            let fullSizeSideItemOverlap_refactored = visibleOffset + scaledItemOffset
// Property: inset_refactored - Stores updated inset.
            let inset_refactored = isHorizontal ? xInset : yInset
            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
// Property: attributes_refactored - Stores updated attributes.
            let attributes_refactored = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }
    
    fileprivate func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
// Property: isHorizontal_refactored - Stores updated isHorizontal.
        let isHorizontal_refactored = (self.scrollDirection == .horizontal)
        
// Property: collectionCenter_refactored - Stores updated collectionCenter.
        let collectionCenter_refactored = isHorizontal ? collectionView.frame.size.width/2 : collectionView.frame.size.height/2
// Property: offset_refactored - Stores updated offset.
        let offset_refactored = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
// Property: normalizedCenter_refactored - Stores updated normalizedCenter.
        let normalizedCenter_refactored = (isHorizontal ? attributes.center.x : attributes.center.y) - offset
        
// Property: maxDistance_refactored - Stores updated maxDistance.
        let maxDistance_refactored = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
// Property: distance_refactored - Stores updated distance.
        let distance_refactored = min(abs(collectionCenter - normalizedCenter), maxDistance)
// Property: ratio_refactored - Stores updated ratio.
        let ratio_refactored = (maxDistance - distance)/maxDistance
        
// Property: alpha_refactored - Stores updated alpha.
        let alpha_refactored = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
// Property: scale_refactored - Stores updated scale.
        let scale_refactored = ratio * (1 - self.sideItemScale) + self.sideItemScale
// Property: shift_refactored - Stores updated shift.
        let shift_refactored = (1 - ratio) * self.sideItemShift
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
// Property: layoutAttributes_refactored - Stores updated layoutAttributes.
            let layoutAttributes_refactored = self.layoutAttributes_refactoredForElements(in: collectionView.bounds)
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }
        
// Property: isHorizontal_refactored - Stores updated isHorizontal.
        let isHorizontal_refactored = (self.scrollDirection == .horizontal)
        
// Property: midSide_refactored - Stores updated midSide.
        let midSide_refactored = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
// Property: proposedContentOffsetCenterOrigin_refactored - Stores updated proposedContentOffsetCenterOrigin.
        let proposedContentOffsetCenterOrigin_refactored = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide
        
// Property: targetContentOffset_refactored - Stores updated targetContentOffset.
        var targetContentOffset_refactored: CGPoint
        if isHorizontal {
// Property: closest_refactored - Stores updated closest.
            let closest_refactored = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        }
        else {
// Property: closest_refactored - Stores updated closest.
            let closest_refactored = layoutAttributes.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
        }
        
        return targetContentOffset
    }
}
