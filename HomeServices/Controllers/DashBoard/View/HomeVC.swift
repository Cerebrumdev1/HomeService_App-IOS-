//
//  HomeVC.swift
//  Fleet Management
//
//  Created by Navaldeep Kaur on 21/03/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

//MARK:- DelegateMethods
protocol ServicesDetailDelegate:class
{
    func trendingServicesDetail(index:Int?)
    func otherServicesDetail(index:Int?)
}

class HomeVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var lblNoBanner: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewNewTab: UIView!
    @IBOutlet weak var viewSettingTab: UIView!
    @IBOutlet weak var viewMyCasesTab: UIView!
    @IBOutlet weak var btnDrawer: UIBarButtonItem!
    @IBOutlet weak var lblNoTrendingServices: UILabel!
    
    var viewModel:HomeViewModel?
    var bannersList = [Banner]()
    var trendingServicesList = [TrendingService]()
    var servicesList = [Service]()
    var isFirstTimeCallDelegate = false
    public  static var isSideMenueSelected:Bool?
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        if HomeVC.isSideMenueSelected == true{
            // self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)
            
        }
        else{
            
        }
    }
    
    //MARK:- Other functions
    func setView()
    {
        //NAvigationBAR
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.viewModel = HomeViewModel.init(Delegate: self, view: self)
        getServices()
        
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        tableView.separatorStyle = .none
        //viewSearch.dropShadow(radius: 8.0)
        
    }
    
    //MARK:- Actions
    @IBAction func SideMenuAction(_ sender: Any)
    {
        
    }
    
    //MARK:- Hit API
    func getServices()
    {
        self.viewModel?.getHomeServicesApi(completion: { (responce) in
            print(responce)
            if let bannerList = responce.body?.banners{
                self.bannersList = bannerList
            }
            if let servicesList = responce.body?.services {
                self.servicesList = servicesList
                //  init(data:[servicesList])
            }
            
            
            if let trendingList = responce.body?.trendingServices{
                self.trendingServicesList = trendingList
            }
            self.tableView.reloadData()
        })
    }
    
    
    //MARK:-Tap gesture for swrevealcontroller
    func setTapGestureOnSWRevealontroller(view: UIView,controller: UIViewController)
    {
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: self.view.frame.origin.y, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
        let revealController: SWRevealViewController? = revealViewController()
        let tap: UITapGestureRecognizer? = revealController?.tapGestureRecognizer()
        tap?.delegate = controller as? UIGestureRecognizerDelegate
        self.revealViewController().panGestureRecognizer().isEnabled = false
        self.revealViewController().tapGestureRecognizer().isEnabled = true
        view.addGestureRecognizer(tap!)
    }
    
    //MARK:- Actions
    
    @IBAction func cartListingAction(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: kStoryBoard.order, bundle: nil).instantiateViewController(withIdentifier: HomeIdentifiers.OrderListVC) as! OrderListVC
        vc.isFromSubCategoriesList = false
                 self.navigationController?.pushViewController(vc,animated:false)
    }
    @IBAction func TabActions(_ sender: Any)
    {
        switch (sender as AnyObject).tag {
        case 0:
            viewNewTab.isHidden = false
            viewMyCasesTab.isHidden = true
            viewSettingTab.isHidden = true
            let controller = Navigation.GetInstance(of: .HomeVC) as! HomeVC
            let frontVC = revealViewController().frontViewController as? UINavigationController
            frontVC?.pushViewController(controller, animated: false)
            revealViewController().pushFrontViewController(frontVC, animated: true)
            break
        case 1:
            viewNewTab.isHidden = true
            viewMyCasesTab.isHidden = false
            viewSettingTab.isHidden = true
            break
        case 2:
            viewNewTab.isHidden = true
            viewMyCasesTab.isHidden = true
            viewSettingTab.isHidden = false
            let controller = Navigation.GetInstance(of: .SettingVC) as! SettingVC
            let frontVC = revealViewController().frontViewController as? UINavigationController
            frontVC?.pushViewController(controller, animated: false)
            revealViewController().pushFrontViewController(frontVC, animated: true)
            break
        default:
            viewNewTab.isHidden = false
            viewMyCasesTab.isHidden = true
            viewSettingTab.isHidden = true
        }
    }
    
}

//MARK:- TableView Delegate and DataSource
extension HomeVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row
        {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ShowAdvertismentCell, for: indexPath) as? ShowAdvertismentCell
            {
                
                if self.bannersList.count > 0
                {
                    lblNoBanner.isHidden = true
                    cell.bannerList = self.bannersList
                    cell.collectionView.isHidden = false
                    cell.collectionView.reloadData()
                }else
                {
                    cell.collectionView.isHidden = true
                    lblNoBanner.isHidden = false
                }
                
                return cell
            }
            break
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.TrendingServiceListCell, for: indexPath) as? TrendingServiceListCell
            {
                
                if self.trendingServicesList.count > 0
                {
                    lblNoTrendingServices.isHidden = true
                    cell.collectionViewTrendingServiceList.isHidden = false
                    cell.delegateTrendingService = self
                    cell.trendingServicesList = self.trendingServicesList
                    cell.collectionViewTrendingServiceList.reloadData()
                }else
                {
                    cell.collectionViewTrendingServiceList.isHidden = true
                    lblNoTrendingServices.isHidden = false
                }
                
                return cell
            }
            break
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.HelpServicesListCell, for: indexPath) as? HelpServicesListCell
            {
                cell.servicesList = self.servicesList
                if self.servicesList.count > 0{
                    if isFirstTimeCallDelegate == false{
                        isFirstTimeCallDelegate = true
                        cell.setView()
                    }
                }
                cell.delegateService = self
                cell.collectionViewHelpServiceList.reloadData()
                return cell
            }
            break
            //        case 3:
            //            if let cell = tableView.dequeueReusableCell(withIdentifier: "RecentReviewsListCell", for: indexPath) as? RecentReviewsListCell
            //            {
            //                return cell
            //            }
        //            break
        default:
            break
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

//MARK:- TrendingServicesDelegate
extension HomeVC : ServicesDetailDelegate
{
    //MARK:- DetailOFTrendingServices
    func trendingServicesDetail(index: Int?) {
        let vc = UIStoryboard.init(name: kStoryBoard.Home, bundle: nil).instantiateViewController(withIdentifier: HomeIdentifiers.CategoriesDetailVC) as! CategoriesDetailVC
        vc.selectedId = self.trendingServicesList[index ?? 0].id!
        vc.isFromSubCategoriesList = false
        self.navigationController?.pushViewController(vc,animated:false)
    }
    
    //MARK:- DetailOFOtherServices
    func otherServicesDetail(index: Int?)
    {
        let vc = UIStoryboard.init(name: kStoryBoard.Home, bundle: nil).instantiateViewController(withIdentifier: HomeIdentifiers.SubCategoriesListVC) as! SubCategoriesListVC
        vc.selectedId = self.servicesList[index ?? 0].id!
        self.navigationController?.pushViewController(vc,animated:false)
    }
    
}
