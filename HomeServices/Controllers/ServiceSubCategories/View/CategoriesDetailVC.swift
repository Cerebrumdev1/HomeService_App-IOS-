//
//  CategoriesDetailVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 30/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit
import Cosmos

class CategoriesDetailVC: CustomController {
    
    //MARK:- OUTLET AND VARIABLES
    @IBOutlet weak var viewImageBack: CustomUIView!
    @IBOutlet weak var imageViewBanner: UIImageView!
    @IBOutlet weak var btnHomeServices: CustomButton!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblCostReplaced: UILabel!
    @IBOutlet weak var lblUnits: UILabel!
    @IBOutlet weak var btnContinue: CustomButton!
    @IBOutlet weak var lblReparing: UILabel!
    @IBOutlet weak var lblPricing: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ktableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblPerPiece: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var viewStartFromBack: CustomUIView!
    @IBOutlet weak var viewDurationBack: CustomUIView!
    @IBOutlet weak var tableViewDetail: UITableView!
    
    var selectedId : String?
    var viewModel : SubCategoriesViewModel?
    var servicesArray = [[String:Any]]()
    var includedDict = [String:Any]()
    var selectedServiceId : String?
    var serviceDetail : BodyDetail?
    var isFromSubCategoriesList : Bool?
    
    //MARK:- LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- OTHER METHODS
    //setView
    func setView()
    {
        viewModel = SubCategoriesViewModel.init(Delegate: self, view: self)
        
        tableViewDetail.delegate = self
        tableViewDetail.dataSource = self
        tableViewDetail.separatorStyle = .none
        
        //setShadow
        self.addShadowToView(radius: 10,view:viewImageBack)
        self.addShadowToView(radius: 2,view:viewStartFromBack)
        self.addShadowToView(radius: 2,view:viewDurationBack)
        //setImageRadius
        imageViewBanner.layer.cornerRadius = 8
        imageViewBanner.layer.masksToBounds = true
        
        //setColor
         btnContinue.backgroundColor = Appcolor.kTheme_Color
        
        //Api
        getCategoriesListApi()
    }
    
    //setData
    func setData(data: BodyDetail)
    {
        self.serviceDetail = data
        selectedServiceId = data.id
        self.viewRating.rating = Double(data.rating ?? 0)
        if let url = data.thumbnail
        {
            self.imageViewBanner.setImage(with: url, placeholder: KImages.KDefaultIcon)
        }
        lblServiceName.text = data.name
        lblRate.text = "$ " + (data.price ?? "0")
        lblPerPiece.text = "/ " + (data.type ?? "N/A")
        lblDescription.text = data.description
        lblDuration.text = data.duration ?? "N/A"
        lblTime.text = data.turnaroundTime ?? "N/A"
        lblPricing.text = data.type ?? "N/A"
        
        if let includeServices = data.includedServices
        {
           
            for included_Service in includeServices
            {
                if included_Service.isEmpty{}
                 else{
                includedDict = ["name" :included_Service,"isIncluded":true]
                self.servicesArray.append(includedDict)
            }
            }
        }
        if let excludeServices = data.excludedServices
        {
            
            for exCluded_Service in excludeServices
            {
               if exCluded_Service.isEmpty{}
                else{
                includedDict = ["name" :exCluded_Service,"isIncluded":false]
                self.servicesArray.append(includedDict)
            }}
        }
        
        //SetTableViewHeight
        if servicesArray.count > 0
        {
            ktableViewHeight.constant = (ktableViewHeight.constant * CGFloat(servicesArray.count)) - 120
            tableViewDetail.reloadData()
        }
        else
        {
            ktableViewHeight.constant = 88
        }
        
    }
    
    //MARK:- Hit Apis
    
   
    
    func getCategoriesListApi()
    {
        viewModel?.getServiceDetailApi(ServiceId : selectedId ?? "",completion:
            { (responce) in
                print(responce)
                if let categoriesDetail = responce.body
                {
                    self.setData(data:categoriesDetail)
                    // self.subCategoriesList = categoriesList
                    self.lblNoRecord.isHidden = true
                }
                else{
                    self.lblNoRecord.isHidden = false
                }
        })
    }
    //MARK:- ACTIONS
    @IBAction func ContinueAction(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: kStoryBoard.appointment, bundle: nil).instantiateViewController(withIdentifier: AppointmentDetailIdentifiers.AppointmentDetailVC) as! AppointmentDetailVC
        vc.selectedServiceId = selectedServiceId
        vc.serviceDetail = self.serviceDetail
        vc.isFromSubCategoriesList = isFromSubCategoriesList
        self.navigationController?.pushViewController(vc,animated:false)
    }
    @IBAction func btnBackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
}

//MARK:- SubCategoriesDelegate
extension CategoriesDetailVC : SubCategoriesDelegate
{
    func Show(msg: String) {
        
    }
    func didError(error: String) {
        
    }
}
//MARK:- TableView DelegateAnd DataSource
extension CategoriesDetailVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return servicesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.IncludedServicesCell, for: indexPath) as? IncludedServicesCell
        {
            cell.lblServiceName.text = servicesArray[indexPath.row]["name"] as? String
            if servicesArray[indexPath.row]["isIncluded"] as? Bool == true{
                cell.lblInculde.text = "Included"
                cell.lblInculde.textColor = TextColor.kGreenColor
            }
            else{
                cell.lblInculde.text = "Not Included"
                cell.lblInculde.textColor = TextColor.kRedColor
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
