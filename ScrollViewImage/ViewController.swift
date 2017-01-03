//
//  ViewController.swift
//  ScrollViewImage
//
//  Created by macOSX on 1/3/17.
//  Copyright © 2017 macOSX. All rights reserved.
//

import UIKit
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}
struct StringColor {
    static let NAV          = "4286F5"
    static let LBL          = "202024"
    static let TITLE        = "3E4449"
    static let ERROR        = "FF3F34"
}
extension UIColor {
    //Convert to RGB without Alpha
    public convenience init?(r:CGFloat,g:CGFloat,b:CGFloat){
        self.init(red:r/255.0,green: g/255.0,blue: b/255.0,alpha: 1.0)
        return
    }
    
    //Convert to RGB with alpha
    public convenience init?(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) {
        self.init(red:r/255.0,green: g/255.0,blue: b/255.0,alpha: alpha)
        return
    }
    
    //Convert to Hex
    public convenience init?(hexString:String){
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    public class func StatusBarColor() -> UIColor{
        return UIColor(r: 63 , g: 127, b: 233, alpha:1)!
    }
    
    public class func receiptNomalBgColor()-> UIColor {
        return UIColor.white
    }
    
    public class func receiptNewBgColor()-> UIColor{
        return UIColor.init(hexString: "eef4ff")!
    }
    
    public class func receiptTextColor_black()-> UIColor{
        return UIColor.init(r: 24/255.0, g: 24/255.0, b: 27/255.0, alpha: 1.0)!
    }
    public class func receiptTextColor_grey()->UIColor{
        return UIColor.init(r: 147, g: 147, b: 147)!
    }
    
}
class ViewController: UIViewController {

   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    var page : UIPageControl!
    var btnPage : UIButton!
    var yRect: CGFloat!
    
    //Auto Scroll
    var autoScroll:Bool = false
    var autoScrollTimer:Timer!
    
    func BtnAction(_ sender: UIButton) {
        switch sender.tag
        {
        case 3:
            var frame : CGRect = self.scrollView.frame
            frame.origin.x     = frame.size.width * -1 + frame.size.width
            self.scrollView.scrollRectToVisible(frame, animated: true)
            page.currentPage   = 0
        case 2:
            var frame : CGRect = self.scrollView.frame
            frame.origin.x     = frame.size.width * 0 + frame.size.width
            self.scrollView.scrollRectToVisible(frame, animated: true)
            page.currentPage   = 1
        case 1:
            var frame : CGRect = self.scrollView.frame
            frame.origin.x     = frame.size.width * 1 + frame.size.width
            self.scrollView.scrollRectToVisible(frame, animated: true)
            page.currentPage   = 2
        default:
            var frame : CGRect = self.scrollView.frame
            frame.origin.x     = frame.size.width * 2 + frame.size.width
            self.scrollView.scrollRectToVisible(frame, animated: true)
            page.currentPage   = 3
        }
    }

  
    func createTurial(){
        var arrTitle = ["Title 1","Title 2","Title 3","Warning Message"]
        var arrsubTitle = ["Subtitle 1\n this is subtitle 1","Subtitle 2\n this is subtitle 2","Subtitle 3\n this is subtitle 3","Subtitle warning\n this is message"]
        var arrImage = ["Clear", "Clouds","Rain",""]
        
        scrollView.contentSize = CGSize(width: ScreenSize.SCREEN_WIDTH * CGFloat(arrTitle.count), height: ScreenSize.SCREEN_HEIGHT - 66)
        
        (DeviceType.IS_IPHONE_4_OR_LESS) ? (yRect = 60) : (yRect = 0)
        
        for index in 0...arrTitle.count - 1 {
            
            //Title
            let lblTitle            = UILabel()
            lblTitle.text           = arrTitle[index]
            lblTitle.textColor      = UIColor.init(hexString: StringColor.NAV)
            lblTitle.textAlignment  = NSTextAlignment.center
            lblTitle.font           = UIFont.boldSystemFont(ofSize: 20)
            lblTitle.frame          = CGRect(x: ScreenSize.SCREEN_WIDTH * CGFloat(index), y: 84 - yRect, width: ScreenSize.SCREEN_WIDTH, height: 20)
            scrollView.addSubview(lblTitle)
            
            //Subtitle
            let lblSubTitle             = UILabel()
            lblSubTitle.text            = arrsubTitle[index]
            lblSubTitle.textColor       = UIColor.init(hexString: StringColor.NAV)
            lblSubTitle.textAlignment   = NSTextAlignment.center
            lblSubTitle.font            = UIFont.systemFont(ofSize: 14)
            lblSubTitle.numberOfLines   = 0
            lblSubTitle.frame           = CGRect(x: ScreenSize.SCREEN_WIDTH * CGFloat(index), y: 125 - yRect, width: ScreenSize.SCREEN_WIDTH, height: 34)
            scrollView.addSubview(lblSubTitle)
            
            //Image
            let imageView               = UIImageView()
            imageView.contentMode       = UIViewContentMode.scaleToFill
            imageView.image             = UIImage(named: arrImage[index])
            
            //Image Frame
            let xValue = ScreenSize.SCREEN_WIDTH * CGFloat(index) + ScreenSize.SCREEN_WIDTH / 2
            
            switch index {
                
                
            case 0 :
                imageView.frame = CGRect(x: xValue - (176/2) , y: 186 - yRect, width: 176, height: 287)
            case 1 :
                imageView.frame = CGRect(x: xValue - (234/2), y: 186 - yRect, width: 234, height: 233)
            case 2 :
                imageView.frame = CGRect(x: xValue - (232/2), y: 186 - yRect, width: 232, height: 284)
            default:
                lblTitle.frame  = CGRect(x: ScreenSize.SCREEN_WIDTH * CGFloat(index), y: 214 - yRect, width: ScreenSize.SCREEN_WIDTH, height: 20)
                lblSubTitle.frame = CGRect(x: ScreenSize.SCREEN_WIDTH * CGFloat(index), y: 255 - yRect, width: ScreenSize.SCREEN_WIDTH, height: 34)
            }
            scrollView.addSubview(imageView)
            
        }
        
        page                        = UIPageControl()
        page.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
        page.currentPageIndicatorTintColor = UIColor.init(hexString: StringColor.NAV)
        page.frame                  = CGRect(x: ScreenSize.SCREEN_WIDTH / 2, y: 19, width: 5, height: 5)
        self.bottomView.addSubview(page)
        
        page.currentPage            = 0
        page.numberOfPages          = arrTitle.count
        
        let view = UIView()
        view.backgroundColor    = UIColor.black.withAlphaComponent(0.1)
        view.frame              = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 1)
        self.bottomView.addSubview(view)
        
        for index in 0...arrTitle.count - 1 {
            btnPage                 = UIButton()
            btnPage.backgroundColor = UIColor.clear
            btnPage.frame           = CGRect(x: ScreenSize.SCREEN_WIDTH / 2 - 15 * CGFloat(index) + 16, y: 17, width: 12, height: 12)
            btnPage.tag             = index
            btnPage.addTarget(self, action: #selector(ViewController.BtnAction(_:)), for: UIControlEvents.touchUpInside)
            self.bottomView.addSubview(btnPage)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       createTurial()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



