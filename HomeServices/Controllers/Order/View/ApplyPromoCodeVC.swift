//
//  ApplyPromoCodeVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 06/04/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class ApplyPromoCodeVC: UIViewController {

    //MARK:- Outlet and Variables
    
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var btnApplyCode: CustomButton!
    @IBOutlet weak var tableViewPromoCode: UITableView!
    
    //MARK:- lifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

        // Do any additional setup after loading the view.
    }
   
    //MARK:- Actions
    @IBAction func applyManualPromoCode(_ sender: Any) {
    }
    
    //MARK:- Other functions
    func setView()
    {
           //viewModel = OrderViewModel.init(Delegate: self, view: self)
           tableViewPromoCode.delegate = self
           tableViewPromoCode.dataSource = self
           tableViewPromoCode.separatorStyle = .none
    }

}

//MARK:- TableView DelegateAnd DataSource
extension ApplyPromoCodeVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.PromoCodeCell, for: indexPath) as? PromoCodeCell
        {
            //cell.ap.tag = indexPath.row
            //cell.viewDelegate = self
           // cell.setView(data:cartList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
