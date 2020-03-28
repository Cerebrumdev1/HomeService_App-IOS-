//
//  EditProfileVC.swift
//  Fleet Management
//
//  Created by Mohit Sharma on 2/26/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import SDWebImage

class EditProfileVC: CustomController,UIScrollViewDelegate
{
    
    @IBOutlet weak var imgViewSelectImage: UIImageView!
    @IBOutlet weak var btnUpdateProfile: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet var ivFemale: UIImageView!
    @IBOutlet var ivMale: UIImageView!
    @IBOutlet var tf_firstName: CustomTextField!
    @IBOutlet var tf_lastName: CustomTextField!
    @IBOutlet var tf_email: CustomTextField!
    @IBOutlet var tf_phoneNumber: CustomTextField!
    @IBOutlet var tf_address: CustomTextField!
    @IBOutlet var ivProfile: UIImageView!
    @IBOutlet weak var btnDrawer: UIBarButtonItem!
    @IBOutlet var btnProceed: CustomButton!
    var maleSelected = true
    var viewModel:EditProfile_ViewModel?
    var  localModel : SignIn_ResponseModel?
    private var selectedPicker: ImagePickers?
    var profileImage : URL?
    
    enum ImagePickers
    {
        case Profile
        case LicenceFront
        case LicenceBack
        
        init()
        {
            self = .Profile
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView()
    {
        
        self.viewModel = EditProfile_ViewModel.init(Delegate: self, view: self)
        self.hideKeyboardWhenTappedAround()
        btnDrawer.target = self.revealViewController()
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        if self.revealViewController()?.panGestureRecognizer() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.setTapGestureOnSWRevealontroller(view: self.view, controller: self) }
        self.setUI()
        getProfile()
    }
    
    func getProfile() {
        
        viewModel?.getProfile()
        
    }
    
    
    override func viewDidLayoutSubviews()
    {
        //self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        
    }
    
    //MARK:- ACTION CHOOSING GENDER
    @IBAction func action_male_selected(_ sender: Any)
    {
        self.ivMale.image = UIImage(named: "btn_check")
        self.ivFemale.image = UIImage(named: "btn_uncheck")
        self.maleSelected = true
        ivMale.setImageColor(color: Appcolor.kTextColorBlack)
        ivFemale.setImageColor(color: Appcolor.kTextColorBlack)
    }
    @IBAction func action_female_selected(_ sender: Any)
    {
        self.ivMale.image = UIImage(named: "btn_uncheck")
        self.ivFemale.image = UIImage(named: "btn_check")
        self.maleSelected = false
        ivMale.setImageColor(color: Appcolor.kTextColorBlack)
        ivFemale.setImageColor(color: Appcolor.kTextColorBlack)
    }
    
    //MARK:- ACTION PROCEED
    @IBAction func action_proceed(_ sender: Any)
    {
        var parm = [String:Any]()
       parm["firstName"] = tf_firstName.text
               parm["lastName"] =  tf_lastName.text
               parm["address"] = tf_address.text
               parm["email"] = tf_email.text
        
        var mediaObjs = [[String:Any]]()
        
        if(profileImage != nil)
        {
            var mediaObj = [String:Any]()
            mediaObj["fileType"] = "Image"
            mediaObj["url"] = profileImage
            mediaObjs.insert(mediaObj, at: 0)
        }
        parm["profileImage"] = mediaObjs
        viewModel?.Validations(obj: parm,profileImage: profileImage)
        
        
    }
    
    
    @IBAction func updateProfile(_ sender: UIBarButtonItem) {
        
        btnUpdateProfile.isUserInteractionEnabled = true
        tf_firstName.isUserInteractionEnabled = true
        tf_lastName.isUserInteractionEnabled = true
        tf_email.isUserInteractionEnabled = true
        tf_address.isUserInteractionEnabled = true
        btnProceed.isUserInteractionEnabled = true
        btnProceed.isHidden = false
        btnProceed.backgroundColor = Appcolor.kThemeBlueColor
        btnProceed.setTitleColor(Appcolor.kTextColorBlack, for: .normal)
        imgViewSelectImage.isHidden = false
        
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        selectedPicker = ImagePickers.Profile
        OpenGalleryCamera(camera: true, imagePickerDelegate: self, isVideoAlso: false)
    }
    
    
    
    func setData() {
        
        if  localModel?.body?.image != nil && localModel?.body?.image != ""
        {
            ivProfile.sd_setImage(with: URL(string: localModel?.body?.image ?? ""), placeholderImage: UIImage(named: "profile"), options: SDWebImageOptions(rawValue: 0))
            { (image, error, cacheType, imageURL) in
                self.ivProfile.image = image
                self.ivProfile.layer.borderWidth = 1
                self.ivProfile.layer.borderColor = Appcolor.kTheme_Color.cgColor
            }
        }
        else {
            ivProfile.image = UIImage(named: "profile")
        }
        if localModel?.body?.firstName != nil && localModel?.body?.firstName != "" {
            tf_firstName.text = localModel?.body?.firstName
        }
        if localModel?.body?.lastName != nil && localModel?.body?.lastName != "" {
            tf_lastName.text = localModel?.body?.lastName
        }
        if  localModel?.body?.email != nil && localModel?.body?.email != "" {
            tf_email.text = localModel?.body?.email
        }
        if  localModel?.body?.phoneNumber != nil  {
            tf_phoneNumber.text = "\(String(describing: localModel?.body?.phoneNumber! ?? ""))"
        }
        if  localModel?.body?.address != nil && localModel?.body?.address != "" {
            tf_address.text = localModel?.body?.address
        }
        //                   if  localModel?.data?.gender != nil && localModel?.data?.gender  != "" {
        //                   }
        //
    }
    
    //MARK:- HANDLING UI
    func setUI()
    {
        CornerRadius(radius: 60, view: ivProfile)
        self.tf_firstName.backgroundColor = Appcolor.kTextFieldBackgroundColor
        self.tf_lastName.backgroundColor = Appcolor.kTextFieldBackgroundColor
        self.tf_email.backgroundColor = Appcolor.kTextFieldBackgroundColor
        self.tf_phoneNumber.backgroundColor = Appcolor.kTextFieldBackgroundColor
        self.tf_address.backgroundColor = Appcolor.kTextFieldBackgroundColor
        
        self.tf_firstName.makeRound_Boarders_with_leftPadding()
        self.tf_lastName.makeRound_Boarders_with_leftPadding()
        self.tf_email.makeRound_Boarders_with_leftPadding()
        self.tf_phoneNumber.makeRound_Boarders_with_leftPadding()
        self.tf_address.makeRound_Boarders_with_leftPadding()
        
        
        //         addShadowToTextField(textField: self.tf_firstName)
        //         addShadowToTextField(textField: self.tf_lastName)
        //        addShadowToTextField(textField: self.tf_email)
        //        addShadowToTextField(textField: self.tf_phoneNumber)
        //        addShadowToTextField(textField: self.tf_address)
        //        ivMale.setImageColor(color: Appcolor.kText_Color_Black)
        //        ivFemale.setImageColor(color: Appcolor.kText_Color_Black)
        //        txtfieldPadding(textField: self.tf_firstName)
        //         txtfieldPadding(textField: self.tf_lastName)
        //         txtfieldPadding(textField: self.tf_email)
        //         txtfieldPadding(textField: self.tf_phoneNumber)
        //         txtfieldPadding(textField: self.tf_address)
    }
}

//MARK:- EditProDelegate
extension EditProfileVC:EditProfileVCDelegate
{
    func getData(model: SignIn_ResponseModel) {
        localModel = model
        setData()
    }
    
    func Show_results(msg: String)
    {
        showAlertMessage(titleStr:kAppName , messageStr: msg)
    }
    
    
}
//MARK:- UIImagePickerDelegate
extension EditProfileVC: UIImagePickerDelegate
{
    func SelectedMedia(image: UIImage?, imageURL: URL?, videoURL: URL?)
    {
        switch selectedPicker
        {
        case .Profile:
            ivProfile.image = image
            
        default: break
            
        }
    }
    
    func selectedImageUrl(url: URL)
    {
        switch selectedPicker
        {
        case .Profile:
            profileImage = url
            
        default: break
        }
    }
    
    func cancelSelectionOfImg()
    {
        
    }
}
