//
//  TrendingServiceListCell.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 21/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit




class TrendingServiceListCell: UITableViewCell {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var collectionViewTrendingServiceList: UICollectionView!
    
    var delegateTrendingService:ServicesDetailDelegate?
    var trendingServicesList = [TrendingService]()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewTrendingServiceList.delegate = self
        collectionViewTrendingServiceList.dataSource = self
         collectionViewTrendingServiceList?.collectionViewLayout.invalidateLayout()
        collectionViewTrendingServiceList.reloadData()
    }

    //MARK:- Other functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK:- SetCollectionViewDelegate
      func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
          collectionViewTrendingServiceList.delegate = dataSourceDelegate
          collectionViewTrendingServiceList.dataSource = dataSourceDelegate
          collectionViewTrendingServiceList.tag = row
          collectionViewTrendingServiceList.reloadData()
      }

}
//MARK:- Delegate and DataSource

extension TrendingServiceListCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingServicesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.TrendingServiceCollectionCell, for: indexPath) as? TrendingServiceCollectionCell
            {
                cell.setView(data: trendingServicesList[indexPath.row])
                return cell
            }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.delegateTrendingService?.trendingServicesDetail(index:indexPath.row)
        
    }
    

   // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2  //number of column you want
               let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               let totalSpace = flowLayout.sectionInset.left
                   + flowLayout.sectionInset.right
                   + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
               let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
               return CGSize(width: size, height: 112)
       //return CGSize(width: 233.0, height: 120.0)
    }

   
}
