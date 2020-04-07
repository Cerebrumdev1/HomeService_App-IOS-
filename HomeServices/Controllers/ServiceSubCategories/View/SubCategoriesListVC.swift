//
//  SubCategoriesListVC.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 25/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit
import Cosmos

class SubCategoriesListVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var imageViewBanner: UIImageView!
    @IBOutlet weak var lblServiceCount: UILabel!
    @IBOutlet weak var tableViewSubCategoriesList: UITableView!
    @IBOutlet weak var kViewSearchHeight: NSLayoutConstraint!
    @IBOutlet weak var imageLocationIcon: UIImageView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    var viewModel : SubCategoriesViewModel?
    var selectedId : String?
    var subCategoriesList = [BodyList]()
    
    //MARK:- Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
   //MARK:- Actions
    @IBAction func btnBackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    //MARK:- Other Functions
    func setView()
    {
        viewModel = SubCategoriesViewModel.init(Delegate: self, view: self)
        //SubCategoriesTable
        tableViewSubCategoriesList.delegate = self
        tableViewSubCategoriesList.dataSource = self
        tableViewSubCategoriesList.separatorStyle = .none
        
        //setImageRadius
        imageViewBanner.layer.cornerRadius = 8
        imageViewBanner.layer.masksToBounds = true
        
        //Api
        getCategoriesListApi()
    }
    
    //MARK:- Hit Apis
    func getCategoriesListApi()
    {
        viewModel?.getSubCategoriesListApi(selectedId : selectedId!,completion:
            { (responce) in
                print(responce)
                if let categoriesList = responce.body
                {
                    if (categoriesList.count > 0){
                        self.viewRating.rating = Double(categoriesList[0].rating ?? 0 )
                        if let url = categoriesList[0].thumbnail
                        {
                            self.imageViewBanner.setImage(with: url, placeholder: KImages.KDefaultIcon)
                        }
                        self.lblServiceCount.text = "\(categoriesList.count) Services"
                        self.subCategoriesList = categoriesList
                        self.tableViewSubCategoriesList.isHidden = false
                        self.lblNoRecord.isHidden = true
                        self.tableViewSubCategoriesList.reloadData()
                    }
                    else{
                        self.lblNoRecord.isHidden = false
                        self.tableViewSubCategoriesList.isHidden = true
                    }
                }
        })
    }
}
//MARK:- TableView DelegateAnd DataSource
extension SubCategoriesListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return subCategoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SubCategoriesListCell, for: indexPath) as? SubCategoriesListCell
        {
            cell.btnRepair.tag = indexPath.row
            cell.setData(categoriesList:subCategoriesList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = UIStoryboard.init(name: kStoryBoard.Home, bundle: nil).instantiateViewController(withIdentifier: HomeIdentifiers.CategoriesDetailVC) as! CategoriesDetailVC
        vc.selectedId = subCategoriesList[indexPath.row].id
        vc.isFromSubCategoriesList = true
        self.navigationController?.pushViewController(vc,animated:false)
    }
}
