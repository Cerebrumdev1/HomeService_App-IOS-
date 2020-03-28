//
//  AppointmentDetailVC.swift
//  HomeServices
//
//  Created by Navaldeep Kaur on 26/03/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//

import UIKit
import HorizontalCalendarView

class AppointmentDetailVC: CustomController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var btnMorning: UIButton!
    @IBOutlet weak var collectionViewCalender: UICollectionView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var viewStack: UIStackView!
    @IBOutlet weak var btnEvening: UIButton!
    @IBOutlet weak var btnAfternoon: UIButton!
    @IBOutlet weak var btnNight: UIButton!
    @IBOutlet weak var viewHorizontalCalendar: HorizontalCalendarView!
    @IBOutlet weak var btnContinue: CustomButton!
    @IBOutlet weak var btnAddress: CustomButton!
    
    var calendarArray : NSArray?
    
    //MARK:- life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //MARK:- Actions
    @IBAction func btnBackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func ContinueAction(_ sender: Any)
    {
    }
    @IBAction func AddAddressAction(_ sender: Any)
    {
    }
    @IBAction func selectDayPeriodAction(_ sender: Any)
    {
        switch (sender as AnyObject).tag {
        case 0:
            setBtnBorder(btn: btnMorning)
            removeBorder(btn: btnAfternoon)
            removeBorder(btn: btnNight)
            removeBorder(btn: btnEvening)
            break
        case 1:
            setBtnBorder(btn: btnAfternoon)
            removeBorder(btn: btnMorning)
            removeBorder(btn: btnNight)
            removeBorder(btn: btnEvening)
            break
        case 2:
            setBtnBorder(btn: btnEvening)
            removeBorder(btn: btnAfternoon)
            removeBorder(btn: btnNight)
            removeBorder(btn: btnMorning)
            break
        case 3:
            setBtnBorder(btn: btnNight)
            removeBorder(btn: btnAfternoon)
            removeBorder(btn: btnEvening)
            removeBorder(btn: btnMorning)
            break
        default:
            break
        }
    }
    
    // MARK:- Other functions
    func setView()
    {
        self.calendarArray = arrayOfDates()
        setBtnBorder(btn: btnMorning)
        collectionViewCalender.delegate = self
        collectionViewCalender.dataSource = self
        collectionViewCalender.reloadData()
    }
    
    //MARK:- GetMonthList
    func arrayOfDates() -> NSArray {
        let numberOfDays: Int = 60
        let startDate = Date()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d"
        let calendar = Calendar.current
        var offset = DateComponents()
        var dates: [Any] = [formatter.string(from: startDate)]
        
        for i in 1..<numberOfDays {
            offset.day = i
            let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
            let nextDayString = formatter.string(from: nextDay!)
            dates.append(nextDayString)
        }
        return dates as NSArray
    }
}

//MARK:- Coolection View Delegate and DataSource
extension AppointmentDetailVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentDetailIdentifiers.AppCalenderCollectionCell, for: indexPath) as? AppCalenderCollectionCell
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "EEE MMM d"
            
            //MonthFormateWithDay
            let dateFormatterMonth = DateFormatter()
            dateFormatterMonth.dateFormat = "MMM d"
         
            let dateCalender = self.calendarArray?[indexPath.row] as? String
            
            if let date = dateCalender?.components(separatedBy: " ").first {
                cell.lblDay.text = date
            }
            
            if let date = dateFormatterGet.date(from: dateCalender!)
            {
                cell.lblDate.text = dateFormatterMonth.string(from: date)
                print(dateFormatterMonth.string(from: date))
            } else {
                print("There was an error decoding the string")
            }
            
            //setCurrentDateSelected
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d"
            let result = formatter.string(from: date)
            
            if cell.lblDate.text == result
            {
                cell.lblDate.textColor = AppButtonColor.kBlueColor
                cell.viewBack.layer.borderColor = AppButtonColor.kBlueColor.cgColor
                cell.lblDay.textColor = AppButtonColor.kBlueColor
                AppCalenderCollectionCell.isCurrentDate = true
            }
            else
            {
                cell.lblDate!.textColor = UIColor.darkText
                cell.lblDay.textColor =  UIColor.darkText
                cell.viewBack.layer.borderColor = UIColor.darkGray.cgColor
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print(self.calendarArray?[indexPath.row] as? String)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115.0, height: 60.0)
    }
}
