//
//  PhotoSelectorController.swift
//  Instagram
//
//  Created by 宋超 on 2019/9/14.
//  Copyright © 2019 宋超. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupNavigationButtons()
        
        collectionView.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView.reloadData()
    }
    
    var selectedImage: UIImage?
    var images = [UIImage]()
    
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        //fetchOptions是要传入 PHAsset.fetchAssets 的第二个参数
        let fetchOptions = PHFetchOptions()
        //fetchOptions.fetchLimit = 10
        //根据创建的时间
        //TODO:此处需要实现最新的照片在最前面显示的功能，目前是报错，还没找到解决办法
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        return fetchOptions
    }
    
    fileprivate func fetchPhotos() {
        
        let allphotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        DispatchQueue.global(qos: .background).async {
            allphotos.enumerateObjects { (asset, count, stop) in
                print(asset)
                let imageManager = PHImageManager.default()
                
                //从350*350变成600*600之后，读取时间变长了
                let targetSize = CGSize(width: 600, height: 600)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    //之所以有这样一个语句是因为只想让reload方法执行一次
                    if count == allphotos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
                
            }
        }
        
    }
    //
    //与头部的大图之间的顶部距离
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    //大图的view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
        header.photoImageView.image = selectedImage
        return header
    }
    //大cell的size layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    //小cell的size layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
        
    }
    //横线间隔为1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //竖线间隔为1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //小cell的个数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext() {
        
    }
}
