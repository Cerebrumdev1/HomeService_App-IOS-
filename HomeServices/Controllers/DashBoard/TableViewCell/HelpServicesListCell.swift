//
//  HelpServicesListCell.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 21/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class HelpServicesListCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var kCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHelpServiceList: UICollectionView!
    
    //MARK:- Variables
    let margin: CGFloat = 18
    var servicesList = [Service]()
    var listCount: Int?
    var delegateService:ServicesDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //collectionDelegate call
        collectionViewHelpServiceList.dataSource = self
        collectionViewHelpServiceList.delegate = self
        collectionViewHelpServiceList?.collectionViewLayout.invalidateLayout()
        
        //MARK:- SetLayout Collection Cell
        guard let collectionView = collectionViewHelpServiceList, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionViewHelpServiceList.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK:- SetView
    func setView()
    {
        listCount = servicesList.count
        kCollectionHeight.constant = ((kCollectionHeight.constant / 2) * CGFloat(listCount!)) + 70
        collectionViewHelpServiceList.reloadData()
    }
    
}

//MARK:- CollectionView DataSource and Delegate
extension HelpServicesListCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servicesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.ServiceHelpCollectionCell, for: indexPath) as? ServiceHelpCollectionCell
        {
            cell.setView(data: servicesList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
         if let cell = collectionView.cellForItem(at: indexPath) as? ServiceHelpCollectionCell {
                       cell.viewBack.dropShadow(radius: 20)
                    cell.viewBack.backgroundColor = UIColor.init(netHex: 0xFFA400)//UIColor.init(hex: KColors.kOrangeColor)
                       cell.viewBack.layer.borderWidth = 0.6
                       cell.viewBack.layer.borderColor = UIColor.white.cgColor
                   }
                   delegateService?.otherServicesDetail(index:indexPath.row)
    }
       
       func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
       {
           guard let cell = collectionView.cellForItem(at: indexPath) as? ServiceHelpCollectionCell else {
               return
           }
           cell.viewBack.backgroundColor = .white
           cell.viewBack.layer.borderWidth = 0.5
           cell.viewBack.layer.borderColor = UIColor.init(netHex:0xD9D4D4).cgColor
           cell.viewBack.removeShadow()
       }
    
    //MARK:- FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let noOfCellsInRow = 2  //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 128)
    }
}
