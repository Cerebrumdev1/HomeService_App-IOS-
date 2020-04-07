//
//  PageControllerVC.swift
//  HomeServices
//
//  Created by Atinder Kaur on 3/24/20.
//  Copyright © 2020 Atinder Kaur. All rights reserved.
//


    
    import UIKit

    class PageControllerVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var pageController: UIPageViewController!
        var controllers = [UIViewController]()
        var arrText = ["Welcome to Home Services App!", "Makes your hustle life easier.", "All type of domiciliary maintenance and repair issues will be resolved here.", "Pay your pro and rate him.", "Enjoy the experience!"]

        override func viewDidLoad() {
            super.viewDidLoad()

            if AppDefaults.shared.userID == ""
            {
               // self.setRootView("PageControllerVC", storyBoard: "Main")
            }
            else
            {
               self.setRootView("SWRevealViewController", storyBoard: "Home")
            }
            pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
            pageController.dataSource = self
            pageController.delegate = self

            addChild(pageController)
            view.addSubview(pageController.view)

            let views = ["pageController": pageController.view] as [String: AnyObject]
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))

            for i in 1 ... 5 {
                let vc = UIViewController()
                var myLabel = UILabel()
                myLabel = UILabel(frame: CGRect(x: vc.view.frame.size.width / 2 - 150, y: vc.view.frame.size.height / 2, width: 300, height: 90))
                myLabel.text = arrText[i - 1]
                myLabel.textAlignment = .center
                myLabel.numberOfLines = 3
                myLabel.font = UIFont(name: "Helvetica-Bold", size: 21)
                
                
                
                if i == 5 {
                    let button:UIButton = UIButton(frame: CGRect(x: vc.view.frame.size.width - 130, y: 50, width: 100, height: 40))
                    button.backgroundColor = Appcolor.kThemeYellowColor
                    button.setTitle("Next", for: .normal)
                    button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
                    button.layer.cornerRadius = 4
                    button.clipsToBounds = true
                    vc.view.addSubview(button)
                }

                vc.view.addSubview(myLabel)
                vc.view.backgroundColor = randomColor()
                controllers.append(vc)
            }

            pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
        }

        
        @objc func buttonClicked() {
            print("Button Clicked")
            self.setRootView("LoginWithPhoneVC", storyBoard: "Main")
        }
        
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            if let index = controllers.firstIndex(of: viewController) {
                if index > 0 {
                    return controllers[index - 1]
                } else {
                    return nil
                }
            }

            return nil
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            if let index = controllers.firstIndex(of: viewController) {
                if index < controllers.count - 1 {
                    return controllers[index + 1]
                } else {
                    return nil
                }
            }

            return nil
        }

        func randomCGFloat() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }

        func randomColor() -> UIColor {
            return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
        }
    }
