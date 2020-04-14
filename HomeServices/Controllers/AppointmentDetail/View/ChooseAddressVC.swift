//
//  ChooseAddressVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 4/7/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

protocol UpdateAddressOnCheckout_Delegate
{
    func addressFound(addrss:String,type:String,adrssID:String)
}

class ChooseAddressVC: UIViewController
{

    
    @IBOutlet var btnDone: CustomButton!
    @IBOutlet var viewBlur: UIVisualEffectView!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var tableViewAddress: UITableView!
    
    var apiDATA : [AddressList_Result]?
    let cellID = "CellClass_AddressList"
   // var viewModel:AddressList_ViewModel?
    var row = -2
    var isSkeleton = true
    var skeletonItems = 4
    var contr = AddressListVC()
    var delegateCheckout: UpdateAddressOnCheckout_Delegate?
    var addrssType = ""
    var addrssID = ""
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.btnDone.backgroundColor = Appcolor.kTheme_Color
        self.btnDone.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        
      //  self.viewModel = AddressList_ViewModel.init(Delegate: self, view: self)
       // self.viewModel?.getAddressList()
        self.viewBlur.layer.cornerRadius = 10
        self.viewBlur.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }

    @IBAction func actionDone(_ sender: Any)
    {
        self.delegateCheckout?.addressFound(addrss: self.lblAddress.text!, type: self.addrssType, adrssID: self.addrssID)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ChooseAddressVC : AddressListVCDelegate
{
    func nothingFound()
    {
        self.apiDATA = nil
        self.tableViewAddress.setEmptyMessage("Addresses Not Available!")
        self.skeletonItems = 0
        self.isSkeleton = false
        self.tableViewAddress.reloadData()
    }
    
    func getData(model: [AddressList_Result])
    {
        if (model.count > 0)
        {
            isSkeleton = false
            self.apiDATA = model
            self.tableViewAddress.reloadData()
            self.tableViewAddress.setEmptyMessage("")
        }
        else
        {
            isSkeleton = true
            skeletonItems = 0
            self.tableViewAddress.reloadData()
            self.tableViewAddress.setEmptyMessage("Addresses Not Available!")
        }
    }
}


extension ChooseAddressVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if (isSkeleton == false)
//        {
            return self.apiDATA?.count ?? 0
       // }
      //  return skeletonItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellClass_AddressList
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDefault.tag = indexPath.row
        
        if let data =  self.apiDATA?[indexPath.row]
        {
            cell.hideAnimation()
            cell.lblType.text = data.addressType
            cell.lblLocation.text = data.addressName
            
            if (indexPath.row == row)
            {
                cell.btnDefault.setBackgroundImage(UIImage(named: "radio_selected"), for: .normal)
            }
            else
            {
                cell.btnDefault.setBackgroundImage(UIImage(named: "radio_unselected"), for: .normal)
            }
            
            if (data.addressType == "Home")
            {
                cell.imageViewMarker.image = UIImage(named:"home")
            }
            else if (data.addressType == "Work")
            {
                cell.imageViewMarker.image = UIImage(named:"work")
            }
            else
            {
                cell.imageViewMarker.image = UIImage(named:"other")
            }
        }
        else
        {
            cell.showAnimation()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.row = indexPath.row
        let data =  self.apiDATA?[indexPath.row]
        self.lblAddress.text = data?.addressName
        self.addrssType = data?.addressType ?? ""
        self.addrssID = data?.id ?? "0"
        self.tableViewAddress.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
}
