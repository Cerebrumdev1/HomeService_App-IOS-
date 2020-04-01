//
//  OrderListVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 31/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit

class OrderListVC: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var tableViewOrder: UITableView!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCheckOut: CustomButton!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- Other functions
    
    func setView(){
        tableViewOrder.delegate = self
        tableViewOrder.dataSource = self
        tableViewOrder.separatorStyle = .none
        tableViewOrder.reloadData()
    }
    //MARK:- Actions
    
    @IBAction func CheckOutAction(_ sender: Any) {
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}

//MARK:- TableView DelegateAnd DataSource
extension OrderListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.OrderListCell, for: indexPath) as? OrderListCell
        {
            cell.setView()
            return cell
        }
        return UITableViewCell()
    }
    
}

