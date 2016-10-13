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
    
    private lazy var dataArray = [AnyObject]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "PTLSpCollectionCell",bundle: nil), forCellWithReuseIdentifier: "PTLSpCollectionCell")
       collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: 查看全部事件
    
    @IBAction func searchAllButtonClick(sender: UIButton) {
        print(#function)
    }
}

extension PTLSpecialCell {
     func getData(array: [PTLCollection]) {
        
        dataArray.removeAll()
        dataArray.append(array)
        collectionView.reloadData()
    }
}

extension PTLSpecialCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray[0].count ?? 0
    }

    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PTLSpCollectionCell", forIndexPath: indexPath) as! PTLSpCollectionCell
    
        let url = (dataArray[0][indexPath.item] as! PTLCollection).banner_image_url
        cell.imageView.sd_setImageWithURL(NSURL(string: url!))

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (kScreenWidth - 30) / 5
        let height: CGFloat = 80
        return CGSize(width: width*2, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 10
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
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
