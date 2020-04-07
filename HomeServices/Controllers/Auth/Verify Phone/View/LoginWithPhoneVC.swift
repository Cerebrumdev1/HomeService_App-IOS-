//
//  LoginWithPhoneVC.swift
//  Fleet Management
//
//  Created by Mohit Sharma on 2/19/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CountryPickerView


class LoginWithPhoneVC: CustomController
{
    
    //MARK:- OUTLETS -->
    @IBOutlet var btnProceed: CustomButton!
    @IBOutlet weak var txtFldForCountryCode: CustomTextField!
    @IBOutlet var txtFldPhone: CustomTextField!
    @IBOutlet weak var loginImgView: UIImageView!
    @IBOutlet weak var imgViewArrowOnBtnProceed: UIImageView!
    @IBOutlet weak var viewUnderLine: UIView!
    
    //MARK:- VARIABLES -->
    var ACCEPTABLE_CHARACTERS_Phone = "1234567890 "
    let countryPickerView = CountryPickerView()
    var push_approach = ""
    var viewModel:LoginWithPhone_ViewModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView()
    {
        self.set_controller_UI()
        self.hideKeyboardWhenTappedAround()
        self.hideNAV_BAR(controller: self)
        txtFldPhone.addDoneButtonToKeyboard(target:self,myAction:  #selector(self.doneButtonAction), Title: kDone)
        countryPickerView.delegate = self
        let country = countryPickerView.selectedCountry
        txtFldForCountryCode.text = country.phoneCode
        txtfieldPadding(textField: txtFldPhone)
        imgViewArrowOnBtnProceed.CornerRadius(radius: imgViewArrowOnBtnProceed.frame.height/2)
        viewUnderLine.layer.cornerRadius = 6
        viewUnderLine.clipsToBounds = true
        
    }
    
    
    
    @objc func doneButtonAction()
    {
        self.txtFldPhone.resignFirstResponder()
    }
    
    
    //MARK:- BUTTON ACTIONS -->
    @IBAction func SubmitAction(_ sender: UIButton)
    {
        if txtFldPhone.text!.count > 12
        {
            showAlertMessage(titleStr: kAppName, messageStr: AlertTitles.Phone_digits_exceeded)
            sender.shake()
        }
        else if txtFldPhone.text!.count == 0
        {
            showAlertMessage(titleStr: kAppName, messageStr: AlertTitles.Enter_phone_number)
            sender.shake()
        }
        else if txtFldPhone.text!.count < 5
        {
            showAlertMessage(titleStr: kAppName, messageStr: AlertTitles.EnterValid_phone_number)
            sender.shake()
        }
        else
        {
            // checking if number is exist or not in our server side
            self.viewModel?.SignIn(phoneNumber: self.txtFldPhone.text!, countryCode: self.txtFldForCountryCode.text!)
        }
        
    }
    
    @IBAction func CountryCode(_ sender: Any)
    {
        countryPickerView.showCountriesList(from: self)
    }
    
}

extension LoginWithPhoneVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == txtFldPhone
        {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_Phone).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
}

extension LoginWithPhoneVC:CountryPickerViewDelegate
{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country)
    {
        let country = countryPickerView.selectedCountry
        txtFldForCountryCode.text = country.phoneCode
    }
}

extension LoginWithPhoneVC
{
    func set_controller_UI()
    {
        self.viewModel = LoginWithPhone_ViewModel.init(view: self)
        self.txtFldPhone.backgroundColor = Appcolor.kTextColorBlack
        self.txtFldForCountryCode.backgroundColor = Appcolor.kTextColorBlack
        self.btnProceed.backgroundColor = Appcolor.kThemeYellowColor
        self.btnProceed.setTitleColor(Appcolor.kTextColorBlack, for: UIControl.State.normal)
        addShadowToTextField(textField: txtFldPhone)
        addShadowToTextField(textField: txtFldForCountryCode)
        txtfieldPadding(textField: txtFldPhone)
        
       // self.loginImgView = colorHandler.set_image_with_color_change(imgName: "homeImg", imgView: //self.loginImgView, colorApproach: UIColor.blue)
        
    }
}


