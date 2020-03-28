//
//  AddNewAddressVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 3/23/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit
import GoogleMaps
import TPKeyboardAvoiding

class AddNewAddressVC: CustomController,GMSMapViewDelegate,UITextFieldDelegate,UIScrollViewDelegate
{
    @IBOutlet var bottomContraint_BlurView: NSLayoutConstraint!
    
    @IBOutlet var scrollVIEW: UIScrollView!
    @IBOutlet var tfHouseNumber: CustomTextField!
    @IBOutlet var tfCity: CustomTextField!
    @IBOutlet var tfAddress: CustomTextField!
    
    @IBOutlet var ivHome: UIImageView!
    @IBOutlet var ivWork: UIImageView!
    @IBOutlet var ivOther: UIImageView!
    
    
    @IBOutlet var btnAddressType_Home: CustomButton!
    @IBOutlet var btnAddressType_Work: CustomButton!
    @IBOutlet var btnAddressType_Hotel: CustomButton!
    
    
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var btnBack: UIBarButtonItem!
    @IBOutlet var View_GoogleMap: GMSMapView!
    
    @IBOutlet var btnAdd: CustomButton!
    @IBOutlet var btnSaveAddress: CustomButton!
    
    var addressType = "Home"
    var viewModel:AddNewAddress_ViewModel?
    var lat = ""
    var long = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.viewModel = AddNewAddress_ViewModel.init(view: self)
        View_GoogleMap.delegate = self
        View_GoogleMap.isMyLocationEnabled = true
        View_GoogleMap.settings.myLocationButton = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews()
    {
       // self.scrollVIEW.contentSize = CGSize(width: self.scrollVIEW.frame.size.width, height: 650)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       HideDetailsView()
       setUI()
    }
    
    @IBAction func actionMoveBack(_ sender: Any)
    {
        self.moveBACK(controller: self)
    }
    
    
    
    @IBAction func HomeSelected(_ sender: Any)
    {
        self.ivHome.image = UIImage(named: "radio_selectedWhite")
        self.ivWork.image = UIImage(named: "radio_unselectedWhite")
        self.ivOther.image = UIImage(named: "radio_unselectedWhite")
        addressType = "Home"
    }
    @IBAction func WorkSelected(_ sender: Any)
    {
        self.ivHome.image = UIImage(named: "radio_unselectedWhite")
        self.ivWork.image = UIImage(named: "radio_selectedWhite")
        self.ivOther.image = UIImage(named: "radio_unselectedWhite")
        addressType = "Work"
    }
    @IBAction func HotelSelected(_ sender: Any)
    {
        self.ivHome.image = UIImage(named: "radio_unselectedWhite")
        self.ivWork.image = UIImage(named: "radio_unselectedWhite")
        self.ivOther.image = UIImage(named: "radio_selectedWhite")
        addressType = "Other"
    }
    
    
    @IBAction func actionCancelAddressDetails(_ sender: Any)
    {
        self.view.endEditing(true)
        HideDetailsView()
    }
    
    @IBAction func actionAddAddress(_ sender: Any)
    {
        ShowDetailsView()
    }
    
    
    @IBAction func actionSaveFinalAddress(_ sender: UIButton)
    {
        self.AddNewAddress_onServer(sender:sender)
    }
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition)
    {
        let coordinate = mapView.projection.coordinate(for: mapView.center)
        
        print(coordinate.latitude as Any)
        
        self.lat = "\(coordinate.latitude)"
        self.long = "\(coordinate.longitude)"
        
        self.getAddressFrom_LatLong(lat: "\(coordinate.latitude)", long: "\(coordinate.longitude)")
        { (adrs) in
            
            self.lblLocation.text = adrs as String
            self.tfAddress.text = self.lblLocation.text
        }
    }
    
    //MARK:- HANDLING UI
    func setUI()
    {
        self.HomeSelected(UIButton.self)
        self.tfHouseNumber.backgroundColor = Appcolor.kTextFieldBackgroundColor
        self.tfAddress.backgroundColor = Appcolor.kTextFieldBackgroundColor
        self.tfCity.backgroundColor = Appcolor.kTextFieldBackgroundColor
        
        self.tfHouseNumber.makeRound_Boarders_with_leftPadding()
        self.tfAddress.makeRound_Boarders_with_leftPadding()
        self.tfCity.makeRound_Boarders_with_leftPadding()
        
        self.btnAdd.backgroundColor = Appcolor.kButtonBackgroundColor
        self.btnAdd.setTitleColor(Appcolor.kTextColorWhite, for: UIControl.State.normal)
        
        self.btnAdd.backgroundColor = Appcolor.kButtonBackgroundColor
        self.btnAdd.setTitleColor(Appcolor.kTextColorWhite, for: UIControl.State.normal)
        
        self.btnSaveAddress.backgroundColor = Appcolor.kButtonBackgroundColor
        self.btnSaveAddress.setTitleColor(Appcolor.kTextColorWhite, for: UIControl.State.normal)
        
    }
    
    
  
    
}
