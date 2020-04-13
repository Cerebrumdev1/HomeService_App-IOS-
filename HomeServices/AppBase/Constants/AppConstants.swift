//
//  AppConstants.swift
//  Cabbies
//
//  Created by Techwin Labs on 03/04/19.
//  Copyright © 2019 Techwin Labs. All rights reserved.
//
//
import Foundation
import UIKit

let KDone                                           =         "Done"
let KChooseImage                                    =         "Choose Image"
let KChooseVideo                                    =         "Choose Video"
let KCamera                                         =         "Camera"
let KGallery                                        =         "Gallery"
let KYoudonthavecamera                              =         "You don't have camera"
let KSettings                                       =         "Settings"

@available(iOS 13.0, *)
let KappDelegate                                    =        UIApplication.shared.delegate as! AppDelegate
let KOpenSettingForPhotos                           =         "App does not have access to your photos. To enable access, tap Settings and turn on Photos."
let KOpenSettingForCamera                           =         "App does not have access to your camera. To enable access, tap Settings and turn on Camera."
let KOK                                             =         "OK"
let KCancel                                         =       "Cancel"
let KYes                                              =       "Yes"
let KNo                                         =       "No"

let KOngoing                                         =       "Ongoing"
let KCompleted                                         =       "Completed"

let GoogleAPIKey = "AIzaSyC9XlPw-l_lY4ga__R5daHFQ8Aj4c8gqOU"

//MARK:- iDevice detection code
struct Device_type
{
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH >= 812
}

//MARK : STATIC TEXT
let kAppName = "Home Services"
let kLoading = "Loading..."
let kVerifying = "Verifying..."
let kLoading_Getting_OTP = "Requesting OTP..."
let kDone = "Done"
let kSaved = "Saved"
let kError = "Error"
let kDataNotFound = "Data not found!"
let kStoryBoard_Main = "Main"
let kResponseNotCorrect = "Data isn't in correct form!"
let kUserNotRegistered = "User is not registered yet!"
let kSomthingWrong = "Something went wrong, please try again!"
let kDataSavedInDatabase = "Data saved successfully in database"
let kDatabaseSuccess = "Database Success"
let kDatabaseFailure = "Database Failure"



//MARK: DEFAULT IMAGES
let kplaceholderProfile = "dummy_user"


let kPush_Approach_from_ForgotPassword = "coming_from_forgotPassword"
let kPush_Approach_from_SignUp = "coming_from_signup"

//MARK : KEYS FOR STORE DATA

struct defaultKeys
{
    static let userID = "userID"
    static let userName = "userName"
    static let userFirstName = "userFirstName"
    static let userImage = "userImage"
    static let userEmail = "userEmail"
    static let userDeviceToken = "userDeviceToken"
    static let userJWT_Token = "userJWT_Token"
    static let userPhoneNumber = "userPhoneNumber"
    static let userHomeAddress = "userHomeAddress"
    static let firebaseVID = "firebaseVID"
    static let userTYPE = "userTYPE"
    static let userCountryCode = "userCountryCode"
    static let firebaseToken = "firebaseToken"
    static let userLastName = "userLastName"
}

struct database
{
    
    struct entityJobDetails
    {
        
    }
    
    struct entityJobSavedLocations
    {
        
    }
    
}



struct APIAddress
{
    
    static let BASE_URL = "http://51.79.40.224:9061/api/mobile/"//"http://camonher.infinitywebtechnologies.com:9065/api/mobile/"
   // static let BASE_URL = "http://10.8.23.202:9062/"
    
    static let CHECK_PHONE_NUMBER = BASE_URL + "driver/auth/checkPhoneNumber"
    static let REGISTER = BASE_URL + "driver/auth/register"
    static let LOGIN = BASE_URL + "auth/login"
    static let RESET_PASSWORD = BASE_URL + "driver/auth/resetpassword"
    static let CHANGE_PASSWORD = BASE_URL + "driver/auth/changepassword"
    static let GetProfile = BASE_URL + "profile/getprofile"
    static let MultipartAudioFileUpload = BASE_URL + "profile/updateprofile"
    static let LOGOUT = BASE_URL + "auth/logout"
    static let GET_ADDRESS = BASE_URL + "address/list"
    static let UPDATE_ADDRESS = BASE_URL + "address/update" //DELETE_ADDRESS
    static let DELETE_ADDRESS = BASE_URL + "address/delete"
    static let ADD_ADDRESS = BASE_URL + "address/add"
    static let Get_Schedule = BASE_URL + "schedule/getSchedule?serviceId="
    static let getScheduleParm = "&serviceDate="
    static let getCartList = BASE_URL + "cart/list"
    static let getServiceCategories = "services/getCategories"
    static let getSubCategoriesList = "services/getServices/"
    static let getServiceDeatil = "services/detail?serviceId="
//       static let REGISTER = BASE_URL + "register"
//       static let LOGIN = BASE_URL + "login"
    static let addToCart =  "cart/add"
    static let deleteToCart = BASE_URL + "cart/remove?cartId="
    static let cartDetail = BASE_URL  + "cart/detail/"
    static let updateCart =  BASE_URL  + "cart/update"
    static let getPromoCodeList = BASE_URL  + "coupan/getPromoList"
    static let applyCoupon = BASE_URL  + "coupan/applyCoupan"
    static let removeCoupon = BASE_URL  + "coupan/removeCoupan"
    static let createOrder = BASE_URL + "orders/create"
    static let orderList = BASE_URL + "orders/list?progressStatus="
    static let page = "&page="
    static let limit = "&limit="
}

//MARK- APIParam
struct ApiParam
{
    static let serviceId = "serviceId"
    static let addressId = "addressId"
    static let serviceDateTime = "serviceDateTime"
    static let orderPrice = "orderPrice"
    static let quantity = "quantity"
    static let orderTotalPrice = "orderTotalPrice"
    static let cartId = "cartId"
    static let id = "promoCode"
    
}
let kHeader_app_json = ["Accept" : "application/json"]


enum Parameter_Keys_All : String
{
    
    case deviceToken = "deviceToken"
    case deviceType = "deviceType"
    case voipDeviceToken = "voipDeviceToken"
    case appVersion = "appVersion"
    
    //User LoginProcess Keys signUp keys
    case language = "language"
    case countryCode = "countryCode"
    case phoneNumber = "phoneNumber"
    case otp = "otp"
    case email = "email"
    case signupBy = "signupBy"
    case firstName = "firstName"
    case lastName = "lastName"
    case socialId = "socialId"
    case loginBy = "loginBy"
    
    case password = "password"
    case address = "address"
    case city = "city"
    case country = "country"
    case latitude = "latitude"
    case longitude = "longitude"
    case socialPic = "socialPic"
    case profilePic = "profilePic"
    case emailPhone = "emailPhone"
    case DOB = "DOB"
    case gender = "gender"
    
}

enum Validate : String
{
    
    case none
    case success = "200"
    case failure = "400"
    case invalidAccessToken = "401"
    case fbLogin = "3"
    case fbLoginError = "405"
    
    func map(response message : String?) -> String?
    {
        
        switch self
        {
        case .success : return message
        case .failure :return message
        case .invalidAccessToken :return message
        case .fbLoginError : return Validate.fbLoginError.rawValue
        default :return nil
        }
    }
}



@available(iOS 13.0, *)
enum configs
{
    static let mainscreen = UIScreen.main.bounds
    static let kAppdelegate = UIApplication.shared.delegate as! AppDelegate
   
    
}


struct AlertTitles
{
    static let Ok:String = "OK"
    static let Cancel:String = "CANCEL"
    static let Yes:String = "Yes"
    static let No:String = "No"
    static let Alert:String = "Alert"
    
    static let Internet_not_available = "Please check your internet connection"
    static let Success = "Success"
    static let Error = "Error"
    static let InternalError = "Internal Error"
    static let Enter_UserName = "Please enter username"
    static let Enter_Password = "Please enter password"
    static let Phone_digits_exceeded = "Phone number digists are exceeded, make sure you are entering correct phone number"
    static let Enter_phone_number = "Please enter phone number"
    static let EnterValid_phone_number = "Please enter a valid phone number"
    static let PasswordEmpty = "Password is empty"
    static let EnterNewPassword = "Please enter new password"
    static let PasswordEmpty_OLD = "Old Password is empty"
    static let PasswordLength8 = "Password length should be of 8-20 characters"
    static let Password_ShudHave_SpclCharacter = "Your password should contain one numeric,one special character,one upper and lower case character"
    static let PasswordCnfrmEmpty = "Confirm password is empty"
    static let Passwordmismatch = "New password and confirm password does not match"
    
    
    
    
}


enum DateFormat
{
    
    case dd_MMMM_yyyy
    case dd_MM_yyyy
    case dd_MM_yyyy2
    case yyyy_MM_dd
    case hh_mm_a
    case yyyy_MM_dd_hh_mm_a
    case yyyy_MM_dd_hh_mm_a2
    case dateWithTimeZone
    case dd_MMM_yyyy
    
    func get() -> String
    {
        
        switch self
        {
            
        case .dd_MMMM_yyyy : return "dd MMMM, yyyy"
        case .dd_MM_yyyy : return "dd-MM-yyyy"
        case .dd_MM_yyyy2 : return "dd/MM/yyyy"
        case .yyyy_MM_dd : return "yyyy-MM-dd"
        case .hh_mm_a : return "hh:mm a"
        case .yyyy_MM_dd_hh_mm_a : return  "yyyy-MM-dd hh:mm a"
        case .yyyy_MM_dd_hh_mm_a2 : return  "dd MMM yyyy, hh:mm a"
        case .dateWithTimeZone : return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case .dd_MMM_yyyy : return "dd MMM yyyy"
            
        }
    }
}

extension String
{
    func capitalizingFirstLetter() -> String
    {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter()
    {
        self = self.capitalizingFirstLetter()
    }
}

//MARK:- NAVAL

//MARK:- HomeService Constant

//MARK:- IMAGES
struct KImages {
    static let KDefaultIcon = "backGroundIcon"
}

//MARK:- COLORS
struct KColors{
    static let kBlueColor = "0x3374DA"
    static let kOrangeColor = "0xFFA400"
    static let kGrayColor = "0xD9D4D4"
}


//MARK:- STORYBOARDS
struct kStoryBoard
{
    static let Home = "Home"
    static let appointment = "Appointment"
    static let order = "Order"
}
//MARK:- VIEW IDENTIFIERS

struct HomeIdentifiers {
    static let HomeVC = "HomeVC"
    static let ShowAdvertismentCell = "ShowAdvertismentCell"
    static let TrendingServiceListCell = "TrendingServiceListCell"
    static let HelpServicesListCell = "HelpServicesListCell"
    static let SubCategoriesListVC = "SubCategoriesListVC"
    static let AdvertismentCollectionCell = "AdvertismentCollectionCell"
    static let TrendingServiceCollectionCell = "TrendingServiceCollectionCell"
    static let ServiceHelpCollectionCell = "ServiceHelpCollectionCell"
    static let SubCategoriesListCell = "SubCategoriesListCell"
    static let CategoriesDetailVC = "CategoriesDetailVC"
    static let IncludedServicesCell = "IncludedServicesCell"
    static let OrderListVC = "OrderListVC"
    static let OrderListCell = "OrderListCell"
    static let PromoCodeCell = "PromoCodeCell"
}

struct AppointmentDetailIdentifiers
{
    static let AppointmentDetailVC = "AppointmentDetailVC"
    static let AppCalenderCollectionCell = "AppCalenderCollectionCell"
    static let AddressTableCell = "AddressTableCell"
    static let TimeSlotCollectionCell = "TimeSlotCollectionCell"
}

//MARK:- Alerts

struct alertMessages {
    static let selectAddress = "Add Address First"
    static let selectDay = "Select date for service"
    static let selectTime = "Select time for service"
    static let enterPromoCode = "Enter Promo Code First"
    static let selectQuantity = "Add quantity for this service"
}

