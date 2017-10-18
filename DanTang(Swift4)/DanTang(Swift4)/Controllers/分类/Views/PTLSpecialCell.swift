//
//  PTLSpecialCell.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/30.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLSpecialCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
     lazy var dataArray:NSMutableArray = { [] }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PTLSpCollectionCell",bundle: nil), forCellWithReuseIdentifier: "PTLSpCollectionCell")
       collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: 查看全部事件
       @IBAction func searchAllButtonClick(_ sender: AnyObject) {
        print(#function)
    }
}

extension PTLSpecialCell {
     func getData(_ array: [PTLCollection]) {
        
        dataArray.removeAllObjects()
        dataArray.addObjects(from: array)
        collectionView.reloadData()
    }
}

extension PTLSpecialCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTLSpCollectionCell", for: indexPath) as! PTLSpCollectionCell
        let url = (dataArray[indexPath.item] as! PTLCollection).banner_image_url
        cell.imageView.sd_setImage(with: URL(string: url!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (kScreenWidth - 30) / 5
        let height: CGFloat = 80
        return CGSize(width: width*2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
}

extension PTLSpecialCell{

    // 类方法 重用标识符
    class func cellID () -> String {
        return "PTLSpecialCell"
    }
}
