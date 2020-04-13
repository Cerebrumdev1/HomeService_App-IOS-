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
    @IBOutlet weak var lblNoTimeSlot: UILabel!
    @IBOutlet weak var viewAddressBack: UIView!
    @IBOutlet weak var collectionViewCalender: UICollectionView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var viewStack: UIStackView!
    @IBOutlet weak var btnEvening: UIButton!
    @IBOutlet weak var viewAddedAddress: CustomUIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnAfternoon: UIButton!
    @IBOutlet weak var btnNight: UIButton!
    @IBOutlet weak var btnContinue: CustomButton!
    @IBOutlet weak var btnAddress: CustomButton!
    @IBOutlet weak var tableViewAddress: UITableView!
    @IBOutlet weak var viewTableBack: CustomUIView!
    @IBOutlet weak var collectionViewTimeSlot: UICollectionView!
    //SelectCount
    @IBOutlet weak var lblSelectServiceCount: UILabel!
    @IBOutlet weak var lblServicePrice: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var viewStepper: GMStepper!
    @IBOutlet weak var viewServiceCount: CustomUIView!
    //hideFirstTime
    @IBOutlet weak var lblGetService: UILabel!
    @IBOutlet weak var lblNeedService: UILabel!
    @IBOutlet weak var viewTimeSlot: CustomUIView!
    @IBOutlet weak var lblCalendar: UIView!
    
    
    @IBOutlet weak var imageArrow: UIImageView!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var kRemoveButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var btnApplyCoupon: UIButton!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblitemQuantity: UILabel!
    @IBOutlet weak var lblApplyCoupon: UILabel!
    @IBOutlet weak var kLblApplyCouponWdith: NSLayoutConstraint!
    @IBOutlet weak var kOldlPriceWidth: NSLayoutConstraint!
    
    var viewModel:Appontment_ViewModel?
    var calendarArray : NSArray?
    var apiDATA : [AddressList_Result]?
    var selectedServiceId:String?
    var timeSlotArray = [TimeSlotModel]()
    var leaveDaysArray = [String]()
    var isFirstTimeCall = false
    var calendarListData = [CalendarModel]()
    var convertedDate :String?
    var isTimeSlotCallFirst = false
    var serviceDetail : BodyDetail?
    var currentDate:String?
    var addressId : String?
    var stepperCount = "0"
    var serviceDateTime : String?
    var totalprice : String?
    var serviceDate : String?
    var serviceTime : String?
    var isFromSubCategoriesList : Bool?
    var isEdited: Bool?
    var updateCartId : String?
    var orderPrice :String?
    var dayAndDate :String?
    var timeOfCart :String?
    var couponId:String?
    var totalPrice : String?
    var cartList:CartListingModel.Body?
    var promocode : String?
    
    //MARK:- life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        getCartList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.getAddressList()
    }
    //MARK:- Actions
    @IBAction func removePromoCodeAction(_ sender: Any) {
           self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Do you want to delete this coupon?", Target: self)
           { (actn) in
               if (actn == KYes)
               {
                   self.removeCouponApi(id:self.couponId)
               }
           }
       }
        @IBAction func applyCouponAction(_ sender: Any)
       {
           let controller = Navigation.GetInstance(of: .ApplyPromoCodeVC) as! ApplyPromoCodeVC
           controller.viewDelegate = self
           self.present_To_Controller(from_controller: self, to_Controller: controller)
       }
    @IBAction func btnBackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func changeAddress(_ sender: Any) {
        viewAddressBack.isHidden = false
        viewTableBack.isHidden = false
    }
    @IBAction func ContinueAction(_ sender: Any)
    {
//        if isEdited == true{
//            updateCartApi()
//        }
//        else{
//            addToCartApi()
//        }
        let controller = Navigation.GetInstance(of: .PaymentVC) as! PaymentVC
        controller.cartList = self.cartList
        controller.addressId = self.addressId
        controller.promoCode = promocode
        self.push_To_Controller(from_controller: self, to_Controller: controller)
    }
    @IBAction func AddAddressAction(_ sender: Any)
    {
        let controller = Navigation.GetInstance(of: .AddNewAddressVC) as! AddNewAddressVC
        self.push_To_Controller(from_controller: self, to_Controller: controller)
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
        self.viewModel = Appontment_ViewModel.init(Delegate: self, view: self)
        self.calendarArray = arrayOfDates()
        var selected:Bool?
        for listData in self.calendarArray!
        {
            if isFirstTimeCall == false{
                selected = true
                isFirstTimeCall = true
                serviceDate = listData as? String
            }
            else{
                selected = false
            }
            let newModel = CalendarModel(date: listData as? String, isSelected: selected, isLeaveDay: false)
            self.calendarListData.append(newModel)
        }
        
        currentDate = convertDateFormate(date: self.calendarListData[0].date ?? "")
        setBtnBorder(btn: btnMorning)
        
        collectionViewCalender.delegate = self
        collectionViewCalender.dataSource = self
        
        
        tableViewAddress.delegate = self
        tableViewAddress.dataSource = self
        tableViewAddress.tableFooterView = UIView()
        tableViewAddress.layer.cornerRadius = 8
        tableViewAddress.clipsToBounds = true
        
        collectionViewTimeSlot.delegate = self
        collectionViewTimeSlot.dataSource = self
        collectionViewTimeSlot.reloadData()
        
        
        // viewStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
        //setColor
        btnContinue.backgroundColor = Appcolor.kTheme_Color
        btnAddress.layer.borderColor = AppButtonColor.kBlueColor.cgColor
        viewAddedAddress.layer.borderColor = AppButtonColor.kBlueColor.cgColor
        btnContinue.setTitleColor(Appcolor.kTextColorBlack, for: .normal)
        btnAddress.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        
        if(isEdited == true)
        {
            self.title = "Update Appointment Detail"
            getCartDetailApi()
        }
        else{
            //MARK:- SetData For Service Count
            self.title = "Appointment Detail"
            lblServiceName.text = serviceDetail?.name
            lblServicePrice.text = "$ " + (serviceDetail?.price ?? "0")
        }
        getScheduleApi(date:currentDate)
        
    }
    
    @objc func stepperValueChanged(stepper: GMStepper)
    {
        print(stepper.value, terminator: "")
        stepperCount = "\(Int(stepper.value))"
        if (stepper.value == 0)
        {
            if isEdited == true {
                lblServicePrice.text = "$ " + (totalprice ?? "0")
            }
            else
            {
                lblServicePrice.text = "$ " + (serviceDetail?.price ?? "0")
            }
            setViewOnStepperClick(isHidden: true)
        }
        else{
            if isEdited == true
            {
                if let rate = orderPrice
                {
                    let totalRate = (Double(rate)!  * stepper.value)
                    lblServicePrice.text =   "$ \(Int(totalRate))"
                    totalprice = "\(Int(totalRate))"
                }
            }
            else
            {
                if let rate = serviceDetail?.price
                {
                    let totalRate = (Double(rate)!  * stepper.value)
                    lblServicePrice.text =   "$ \(Int(totalRate))"
                    totalprice = "\(Int(totalRate))"
                }
            }
            self.isTimeSlotCallFirst = false
            getScheduleApi(date:currentDate)
            setViewOnStepperClick(isHidden: false)
            
        }
        
    }
    
    //MARK:- Hide/Show View
    func setViewOnStepperClick(isHidden:Bool)
    {
        if self.apiDATA?.count ?? 0 > 0
        {
            btnAddress.isHidden = true
            viewAddedAddress.isHidden = isHidden
        }
        else
        {
            btnAddress.isHidden = isHidden
            viewAddedAddress.isHidden = true
        }
        lblGetService.isHidden = isHidden
        lblNeedService.isHidden = isHidden
        viewTimeSlot.isHidden = isHidden
        lblCalendar.isHidden = isHidden
        btnContinue.isHidden = isHidden
        
    }
    
    func showAlert_Message(titleStr:String, messageStr:String)
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: KOK, style: UIAlertAction.Style.default) {
            UIAlertAction in
            let vc = UIStoryboard.init(name: kStoryBoard.order, bundle: nil).instantiateViewController(withIdentifier: HomeIdentifiers.OrderListVC) as! OrderListVC
            self.navigationController?.pushViewController(vc,animated:false)
        }
        // Add the actions
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- AddCoupon_Animation
    
    func addCoupon_Animation()
    {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            //  self.lblApplyCoupon.frame = CGRect(x:  80, y: 123, width: 160, height: 12)
            self.kLblApplyCouponWdith.constant = 200
            self.kOldlPriceWidth.constant = 50
            self.kRemoveButtonWidth.constant = 65
            self.imageArrow.isHidden = true
            self.btnApplyCoupon.isUserInteractionEnabled = false
            self.lblApplyCoupon.text =  "Coupon Applied: (New)"
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK:- RemoveCoupon_Animation
    
    func removeCoupon_Animation()
    {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseIn, animations: {
            self.lblTotalPrice.text = self.totalPrice
            self.kLblApplyCouponWdith.constant = 0
            self.kOldlPriceWidth.constant = 0
            self.kRemoveButtonWidth.constant = 0
            self.imageArrow.isHidden = false
            self.btnApplyCoupon.isUserInteractionEnabled = true
            OrderListVC.isCodeApplied = false
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.kLblApplyCouponWdith.constant = 100
            self.lblApplyCoupon.text =  "Apply Coupon"
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    //MARK:- DateFormate
    
    func convertDateFormate(date:String) -> String
    {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EEE MMM d yyyy"
        //MonthFormateWithDay
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.dateFormat = "MM-dd-yyyy"
        if let date = dateFormatterGet.date(from: date)
        {
            print(dateFormatterMonth.string(from: date))
            convertedDate = dateFormatterMonth.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return convertedDate ?? ""
    }
    
    //MARK:- Hit Api
    
    func getCartList()
    {
        viewModel?.getCartListApi(completion: { (responce) in
            print(responce)
            if let cartListData = responce.body{
                self.cartList = cartListData
                if cartListData.data.count > 0{
                self.couponId = cartListData.data[0].promoCode
                    
                }
                    self.totalPrice = "\(responce.body?.totalQunatity ?? 0)"//"$ \(responce.body?.sum ?? 0)"
                    //setData
                    // self.lblItemCount.text = "Items ( \(responce.body?.totalQunatity ?? 0) )"
                    self.lblitemQuantity.text = "\(cartListData.totalQunatity ?? 0)"
                    
                if (cartListData.payableAmount != nil && cartListData.payableAmount != 0){
                    self.lblTotalPrice.text = "$ \(cartListData.payableAmount ?? 0)"
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$ \(cartListData.sum ?? 0)")
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                        
                        self.lblOldPrice.attributedText = attributeString
                        
                        self.addCoupon_Animation()
                    }
                    else{
                        self.lblTotalPrice.text = "$ \(responce.body?.sum ?? 0)"
                        
                    }
            }
            
        })
    }
    //RemoveCoupon Api
     func removeCouponApi(id: String?){
         viewModel?.removeCouponApi(Id: id, completion: { (responce) in
             self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: responce.message ?? "", Target: self) {
                 self.getCartList()
                 // self.removeCoupon_Animation()
             }
         })
     }
    func updateCartApi()
    {
        let dateTime = (serviceDate ?? "") + " " + "2:00 PM"
        let dateFormatterGet = DateFormatter()
        //Fri Apr 3 2020 2:00 PM
        dateFormatterGet.dateFormat = "E, MMM d yyyy h:mm a"
        //MonthFormateWithDay
        let dateFormatterMonth = DateFormatter()
        //2020-03-30 14:00:00
        dateFormatterMonth.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatterGet.date(from: dateTime)
        {
            serviceDateTime = dateFormatterMonth.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        
        let param = AddtoCartInputModel.init(serviceId: selectedServiceId, addressId: addressId, serviceDateTime: serviceDateTime, orderPrice:orderPrice, quantity: stepperCount, orderTotalPrice: totalprice)
        viewModel?.updateToCartValidation(param: param, serviceDay: serviceDate, serviceTime: serviceTime, cartId: updateCartId)
    }
    
    func getCartDetailApi()
    {
        viewModel?.getCartDetailApi(cartId: updateCartId, completion: { (responce) in
            print(responce)
            if let data = responce.body
            {
                self.lblServiceName.text = data.service?.name ?? ""
                self.lblServicePrice.text = "$ \(data.orderTotalPrice ?? "")"
                self.totalprice = data.orderTotalPrice ?? ""
                self.stepperCount = data.quantity ?? ""
                self.lblAddress.text = data.address?.addressName
                self.addressId = data.addressId
                self.btnContinue.setTitle("Update Cart", for: .normal)
                self.selectedServiceId = data.serviceId
                self.orderPrice =  data.orderPrice
                self.viewStepper.value = Double(data.quantity ?? "") ?? 0.0
                
                let str = data.serviceDateTime ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
                dateFormatter.formatterBehavior = .default
                let date = dateFormatter.date(from: str)
                let dateTime = "\(date!)"
                if let date = dateTime.components(separatedBy: "+").first
                {
                    self.serviceDateTime = date
                }
                
                self.setDateAndTime()
            }
        })
    }
    
    //setDateTime
    func setDateAndTime()
    {
        let dateFormatterGet = DateFormatter()
        //Fri Apr 3 2020 2:00 PM
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //MonthFormateWithDay
        let dateFormatterMonth = DateFormatter()
        //2020-03-30 14:00:00
        dateFormatterMonth.dateFormat = "E MMM d yyyy"
        if let date = dateFormatterGet.date(from: self.serviceDateTime ?? "")
        {
            dayAndDate = dateFormatterMonth.string(from: date)
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
            timeOfCart = dateFormatterTime.string(from: time)
        }
        else
        {
            print("There was an error decoding the string")
        }
        
        //SetDefalutDateSelected
        var index = 0
        for selectedDate in  self.calendarListData
        {
            if selectedDate.date == dayAndDate
            {
                self.calendarListData[index].isSelected = true
                serviceDate =  self.calendarListData[index].date
            }
            else{
                self.calendarListData[index].isSelected = false
            }
            index = index + 1
        }
        collectionViewCalender.reloadData()
        
        //SetDefalutTimeSelected
        var timeIndex = 0
        for selectedDate in  self.timeSlotArray
        {
            if selectedDate.time == timeOfCart
            {
                self.timeSlotArray[timeIndex].isSelected = true
                serviceDate =  self.timeSlotArray[timeIndex].time
            }
            else{
                self.timeSlotArray[index].isSelected = false
            }
            timeIndex = timeIndex + 1
        }
        collectionViewTimeSlot.reloadData()
        
    }
    //addToCart
    func addToCartApi()
    {
        let dateTime = (serviceDate ?? "") + " " + "2:00 PM"
        let dateFormatterGet = DateFormatter()
        //Fri Apr 3 2020 2:00 PM
        dateFormatterGet.dateFormat = "E, MMM d yyyy h:mm a"
        //MonthFormateWithDay
        let dateFormatterMonth = DateFormatter()
        //2020-03-30 14:00:00
        dateFormatterMonth.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatterGet.date(from: dateTime)
        {
            serviceDateTime = dateFormatterMonth.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        
        let param = AddtoCartInputModel.init(serviceId: selectedServiceId, addressId: addressId, serviceDateTime: serviceDateTime, orderPrice: serviceDetail?.price, quantity: stepperCount, orderTotalPrice: totalprice)
        
        viewModel?.addToCartValidation(param: param, serviceDay: serviceDate, serviceTime: serviceTime)
        
    }
    
    //getSchedule
    func getScheduleApi(date : String?)
    {
        self.viewModel?.getSchedule(selectedDay: date, selectedId: selectedServiceId ?? "", completion: { (responce) in
            print(responce)
            
            self.lblNoTimeSlot.isHidden = true
            self.collectionViewTimeSlot.isHidden = false
            self.btnContinue.isHidden = false
            
            if let timeArray = responce.body?.time{
                var selected:Bool?
                self.timeSlotArray.removeAll()
                for timeList in timeArray{
                    if self.isTimeSlotCallFirst == false{
                        selected = true
                        self.isTimeSlotCallFirst = true
                        self.serviceTime = timeList
                    }
                    else{
                        selected = false
                    }
                    let newModel = TimeSlotModel(time: timeList, isSelected: selected)
                    self.timeSlotArray.append(newModel)
                }
                self.collectionViewTimeSlot.reloadData()
            }
            
            if let leaveDays = responce.body?.leave{
                self.leaveDaysArray = leaveDays
                var daysInList:String?
                var index = 0
                for usersList in self.calendarListData
                {
                    var model = self.calendarListData[index]
                    model.isLeaveDay = false
                    self.calendarListData[index] = model
                    
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "EEE MMM d yyyy"
                    //MonthFormateWithDay
                    let dateFormatterMonth = DateFormatter()
                    dateFormatterMonth.dateFormat = "EEE"
                    
                    let dateCalender = usersList.date
                    if let date = dateFormatterGet.date(from: dateCalender!)
                    {
                        daysInList = dateFormatterMonth.string(from: date)
                    } else {
                        print("There was an error decoding the string")
                    }
                    for leaveDays in self.leaveDaysArray
                    {
                        if  daysInList?.lowercased() == leaveDays
                        {
                            var model = self.calendarListData[index]
                            model.isLeaveDay = true
                            self.calendarListData[index] = model
                            break
                        }
                        
                    }
                    index = index + 1
                }
                self.collectionViewCalender.reloadData()
            }
        })
    }
    
    //MARK:- GetMonthList
    func arrayOfDates() -> NSArray {
        let numberOfDays: Int = 5
        let startDate = Date()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d yyyy"
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

//MARK:- Collection View Delegate and DataSource
extension AppointmentDetailVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int?
        if collectionView == self.collectionViewCalender {
            count = calendarListData.count
        }
        else
        {
            count = timeSlotArray.count
        }
        return count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.collectionViewCalender {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentDetailIdentifiers.AppCalenderCollectionCell, for: indexPath) as? AppCalenderCollectionCell
            {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "EEE MMM d yyyy"
                
                //MonthFormateWithDay
                let dateFormatterMonth = DateFormatter()
                dateFormatterMonth.dateFormat = "MMM d"
                
                let dateCalender = self.calendarListData[indexPath.row].date
                
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
                
                if self.calendarListData[indexPath.row].isSelected == true
                {
                    cell.lblDate.textColor = AppButtonColor.kBlueColor
                    cell.viewBack.layer.borderColor = AppButtonColor.kBlueColor.cgColor
                    cell.lblDay.textColor = AppButtonColor.kBlueColor
                }
                else
                {
                    cell.lblDate!.textColor = UIColor.darkText
                    cell.lblDay.textColor =  UIColor.darkText
                    cell.viewBack.layer.borderColor = UIColor.darkGray.cgColor
                }
                
                if calendarListData[indexPath.row].isLeaveDay == true
                {
                    cell.isUserInteractionEnabled = false
                    cell.viewBack.backgroundColor = AppButtonColor.kLightGaryColor
                }
                else
                {
                    cell.isUserInteractionEnabled = true
                    cell.viewBack.backgroundColor = UIColor.white
                }
                return cell
            }
        }
        else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentDetailIdentifiers.TimeSlotCollectionCell, for: indexPath) as? TimeSlotCollectionCell
            {
                cell.lblTimeSlot.text = timeSlotArray[indexPath.row].time
                if self.timeSlotArray[indexPath.row].isSelected == true
                {
                    cell.lblTimeSlot.textColor = AppButtonColor.kBlueColor
                    cell.viewBack.backgroundColor = AppButtonColor.kLightBlueColor
                    cell.viewBack.layer.borderWidth = 1
                    cell.viewBack.layer.borderColor = AppButtonColor.kBlueColor.cgColor
                    
                }
                else
                {
                    cell.lblTimeSlot.textColor = UIColor.darkGray
                    cell.viewBack.backgroundColor = .white
                    cell.viewBack.layer.borderWidth = 1
                    cell.viewBack.layer.borderColor = UIColor.darkGray.cgColor
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.collectionViewCalender
        {
            var index = 0
            for selectedDate in  self.calendarListData
            {
                if selectedDate.isSelected == true
                {
                    self.calendarListData[index].isSelected = false
                }
                index = index + 1
            }
            self.calendarListData[indexPath.row].isSelected = true
            serviceDate =  self.calendarListData[indexPath.row].date
            collectionViewCalender.reloadData()
            
            let selectedDate = convertDateFormate(date: self.calendarListData[indexPath.row].date ?? "")
            isTimeSlotCallFirst = false
            getScheduleApi(date:selectedDate)
        }
        else
        {
            print(self.timeSlotArray[indexPath.row])
            var index = 0
            for selectedDate in  self.timeSlotArray
            {
                if selectedDate.isSelected == true
                {
                    self.timeSlotArray[index].isSelected = false
                }
                index = index + 1
            }
            self.timeSlotArray[indexPath.row].isSelected = true
            serviceTime = self.timeSlotArray[indexPath.row].time
            collectionViewTimeSlot.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        if collectionView == self.collectionViewCalender
        {
            self.calendarListData[indexPath.row].isSelected = false
            collectionViewCalender.reloadData()
        }
        else
        {
            guard let cell = collectionView.cellForItem(at: indexPath) as? TimeSlotCollectionCell else {
                return
            }
            cell.lblTimeSlot.textColor = UIColor.darkGray
            cell.viewBack.backgroundColor = .white
            cell.viewBack.layer.borderWidth = 1
            cell.viewBack.layer.borderColor = UIColor.darkGray.cgColor
        }
        
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: Int?
        var height:Int?
        if collectionView == self.collectionViewCalender
        {
            height = 60
            width = 115
        }
        else
        {
            height = 48
            width = 151
        }
        return CGSize(width:width ?? 0, height:height ?? 0)
    }
}

//MARK:- ViewDelegate
extension AppointmentDetailVC  : AppointmentVCDelegate
{
    func addCarSuccess(msg: String) {
        self.showAlert_Message(titleStr: kAppName, messageStr: msg)
    }
    
    func Show_results(msg: String)
    {
        self.showAlertMessage(titleStr: kAppName, messageStr: msg)
    }
    
    func didError(error: String) {
        //showAlertMessage(titleStr: kAppName, messageStr: error)
        lblNoTimeSlot.isHidden = false
        collectionViewTimeSlot.isHidden = true
       // btnContinue.isHidden = true
    }
    
    func getData(model: [AddressList_Result]) {
        if (model.count > 0)
        {
//            if stepperCount != "0"
//            {
                btnAddress.isHidden = true
                viewAddedAddress.isHidden = false
//            }
//            else
//            {
//                btnAddress.isHidden = true
//                viewAddedAddress.isHidden = true
//            }
            self.apiDATA = model
            self.tableViewAddress.reloadData()
            lblAddress.text =  apiDATA?[0].addressName
            addressId = apiDATA?[0].id
        }
        else
        {
//            if stepperCount != "0"
//            {
                btnAddress.isHidden = false
                viewAddedAddress.isHidden = true
//            }
//            else
//            {
//                btnAddress.isHidden = true
//                viewAddedAddress.isHidden = true
//            }
        }
    }
    
    
}

//MARK:- TableView DelegateAnd DataSource
extension AppointmentDetailVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return apiDATA?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentDetailIdentifiers.AddressTableCell, for: indexPath) as? AddressTableCell
        {
            cell.lblAddress.text = apiDATA?[indexPath.row].addressName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        lblAddress.text =  apiDATA?[indexPath.row].addressName
        addressId = apiDATA?[indexPath.row].id
        viewAddressBack.isHidden = true
        viewTableBack.isHidden = true
    }
}

//MARK:- CouponDelegate
extension AppointmentDetailVC:CartListDelegate
{
    func updateCart(index: Int?, stepperValue: String?,totalPrice:String?) {
    }
    
    func callBack(data:ApplyCouponModel.Body)
    {
        //couponId = data.coupanCode
        getCartList()
    }
    
    func removeFromCart(index: Int?) {
    }
}

