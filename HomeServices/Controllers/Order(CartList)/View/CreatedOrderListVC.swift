//
//  CreatedOrderListVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 09/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class CreatedOrderListVC: CustomController {
    
    //MARK:- Outlet and Variables
    
    @IBOutlet var tableviewOrders: UITableView!
    @IBOutlet var btnDrawer: UIBarButtonItem!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    var isSkeleton_Service = true
    var skeletonItems_Service = 2
    var apiData = [OrderModel.Body]()
    let cellID = "CellClass_OrderList"
    let cellIDCellTable = "CellClass_CellTable"
    var viewModel:CreatedOrderViewModel?
    var approach = "orderList"
    var progressStatus = 0
    var page = 1
    var limit = 10
    var serviceDateTime : String?
    var ordertime : String?
    var orderDate : String?
    var didEndReached:Bool=false
    var isFetching:Bool = false
    var isScroll = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setView()
        
        
    }
    //MARK:- Other functions
    
    func setView(){
        btnDrawer.target = self.revealViewController()
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)
        
        self.viewModel = CreatedOrderViewModel.init(Delegate: self, view: self)
        
        tableviewOrders.delegate = self
        tableviewOrders.dataSource = self
        
        if (self.approach == "orderList")
        {
            self.title = "Orders"
            lblNoRecord.text = "Orders not available!"
        }
        else
        {
            self.title = "Booking History"
            lblNoRecord.text = "Bookings not available!"
        }
        
        getOrderListApi()
    }
    
    func convertDateFormate(date:String?)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        dateFormatter.formatterBehavior = .default
        let date = dateFormatter.date(from: date ?? "")
        let dateTime = "\(date!)"
        if let date = dateTime.components(separatedBy: "+").first
        {
            self.serviceDateTime = date
        }
        
        let dateFormatterGet = DateFormatter()
        //Fri Apr 3 2020 2:00 PM
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //MonthFormateWithDay
        let dateFormatterMonth = DateFormatter()
        //2020-03-30 14:00:00
        dateFormatterMonth.dateFormat = "E d MMM yyyy"
        if let date = dateFormatterGet.date(from: self.serviceDateTime ?? "")
        {
            orderDate = dateFormatterMonth.string(from: date)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        //TimeFormate
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "h:mm a"
        if let time = dateFormatterGet.date(from: self.serviceDateTime ?? "")
        {
            ordertime = dateFormatterTime.string(from: time)
        }
        else
        {
            print("There was an error decoding the string")
        }
    }
    
    //MARK:- Hit Apis
    func getOrderListApi()
    {
        self.viewModel?.getOrderList(progressStatus: progressStatus, page: page, limit: limit, completion: { (responce) in
            print(responce)
            if (responce.body?.count ?? 0 > 0){
                if let data = responce.body{
                self.isFetching = true
                self.apiData += data
                self.tableviewOrders.isHidden = false
                self.lblNoRecord.isHidden = true
                self.tableviewOrders.reloadData()
                }
            }
            else
            {
                if self.isScroll == true{}
                else
                {
                    self.lblNoRecord.isHidden = false
                    self.tableviewOrders.isHidden = true
                }
                self.isFetching = false
            }
            
        })
    }
    
    
    //MARK:- Actions
    @IBAction func cellAction_CancelOrder(_ sender: UIButton)
    {
        let obj = self.apiData[sender.tag]
        
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Are you sure you want to cancel this order?", Target: self)
        { (actn) in
            if (actn == KYes)
            {
                self.viewModel?.cancelOrderAPi(Id: obj.id, completion: { (responce) in
                    self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self)
                    {
                        self.getOrderListApi()
                    }
                })
            }
        }
    }
}

//MARK:- TableView Delegateand DataSource
extension CreatedOrderListVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //                if isSkeleton_Service == true
        //                {
        //                    return skeletonItems_Service
        //                }
        return apiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cellNew = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)as! CellClass_OrderList
        if apiData.count > 0
        {
         let obj = apiData[indexPath.row]
        //{
            cellNew.btnCencel.tag = indexPath.row
            let intvals = obj.createdAt
            cellNew.lblBookedOn.text = self.intToDate(intval:intvals ?? 0)
            cellNew.lblTotal.text = "$ \(obj.totalOrderPrice!)"
            
            cellNew.cellCollectionView.tag = indexPath.row
            cellNew.cellCollectionView.delegate = self
            cellNew.cellCollectionView.dataSource = self
            cellNew.cellCollectionView.reloadData()
            self.setCollection_Layout(collc: cellNew.cellCollectionView, layouts: cellNew.cellCollectionHeight)
            
            if (obj.progressStatus == 0)//"pending")
            {
                cellNew.btnCencel.setTitle("CANCEL", for: .normal)
            }
            else
            {
                cellNew.btnCencel.setTitle("CANCELED", for: .normal)
            }
            
            if (self.approach == "orderList")
            {
                cellNew.btnCencel.isHidden = false
            }
            else
            {
                cellNew.btnCencel.isHidden = true
            }
            
            cellNew.hideAnimation()
        }
        else
        {
            cellNew.showAnimation()
        }
        
        return cellNew
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 298.0
    }
    
    
    func setCollection_Layout(collc:UICollectionView,layouts:NSLayoutConstraint)
    {
        let height = collc.collectionViewLayout.collectionViewContentSize.height
        layouts.constant = height
        // self.view.setNeedsLayout()
    }
}




//MARK:- Collection View Delegate and DataSource
extension CreatedOrderListVC : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count = apiData[collectionView.tag].suborders?.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellnew = collectionView.dequeueReusableCell(withReuseIdentifier: "CellClass_CellCollection", for: indexPath)as! CellClass_CellCollection
        
        let data = apiData[collectionView.tag]
        let obj = data.suborders
        if (obj?.count ?? 0 > 0)
        {
            let serviceData = obj![indexPath.item]
            cellnew.lblSrviceName.text = serviceData.service?.name
            self.convertDateFormate(date : data.serviceDateTime)
            cellnew.lblDate.text = orderDate
            cellnew.lblTime.text = ordertime
            cellnew.lblQuantity.text = "Quantity: \(serviceData.quantity!)"
            let img = serviceData.service?.thumbnail ?? ""
            cellnew.iv.setImage(with: img, placeholder: KImages.kNoImage)
            cellnew.iv.CornerRadius(radius: 10.0)
        }
        
        return cellnew
    }
    
    
    
    
}

//MARK:- Collection View FlowLayout
extension CreatedOrderListVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width, height: 122)
    }
}

extension CreatedOrderListVC : UIScrollViewDelegate{
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableviewOrders.contentOffset.y + tableviewOrders.frame.size.height) >= tableviewOrders.contentSize.height)
        {
            if isFetching == true
            {
                isScroll = true
                isFetching = false
                self.page = self.page+1
                getOrderListApi()
            }
            else{
              isScroll = false
            }
        }
    }
}
