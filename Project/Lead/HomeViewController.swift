//
//  ViewController.swift
//  Lead
//
//  Created by Ye on 2018/5/31.
//  Copyright © 2018 Ye. All rights reserved.
//

import UIKit
import NetworkExtension
import SnapKit
import SideMenu
import TextFieldEffects
//import SCLAlertView


//warning setting
let emptyConfigWarning = NSLocalizedString("Please set the Configuration at first", comment: "")
let emptyAddressWarning = NSLocalizedString("Please enter the Address", comment: "")
let emptyPortWarning = NSLocalizedString("Please enter the Port", comment: "")
let emptyMethodWarning = NSLocalizedString("Please select a Method", comment: "")
let emptyPasswordWarning = NSLocalizedString("Please enter the Password", comment: "")
//let alerViewAppearance = SCLAlertView.SCLAppearance(
//    kDefaultShadowOpacity: 0.78,
//    kTitleTop:45,
//    kTextHeight: 0,
//    kTextViewdHeight:0,
//    kTitleFont: UIFont(name: "Avenir-Black", size: 20)!,
//    kTextFont: UIFont(name: "Avenir-Light", size: 0)!,
//    kButtonFont: UIFont(name: "Avenir-Black", size: 18)!,
//    showCloseButton: true,
//    fieldCornerRadius: 20,
//    buttonCornerRadius: 20
//)

// @objc class HomeViewController: UIViewController {
//
//    let commentLabel = UILabel()  //"点击添加“标签
//    let connectButton = UIButton() //“链接”按钮
//    let connectButtonView = ConnectButtonView()
//    let ssLogoView = SSlogoView()
//    let configLabel = UILabel()
//    let rippleView = RippleView()
//
//    //监听状态
//    var status: VPNStatus {
//        didSet(o) {
//            updateConnectButton()
//        }
//    }
//    required init?(coder aDecoder: NSCoder) {
//
//        print("8*************************8")
//        self.status = .off
//        super.init(coder: aDecoder)
//        NotificationCenter.default.addObserver(self, selector: #selector(onVPNStatusChanged), name: NSNotification.Name(rawValue: kProxyServiceVPNStatusNotification), object: nil)
//    }
////    //反初始化，释放实例
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        //设置gradient背景色
//        view.setGradientBackground(topColor:Colors.lightBlue,bottomColor: Colors.deepBlue)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        Thread.sleep(forTimeInterval: 2.0) //启动延长2秒，看LaunchScreen
//
//        //网络状态监测
//        let reachability = Reachability()!
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }
//
//        setUI()
//    }
//
//    func setUI(){
//
//        //rippleView
//        rippleView.frame = self.view.frame
//        self.view.addSubview(rippleView)
//
//        let wavesView = WavesView()  //在下面snp中设置constrains
//        self.view.addSubview(wavesView)
//        wavesView.snp.makeConstraints { (make) in
//            make.center.equalTo(view)
//            make.height.equalTo(38)
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//        }
//
//        //小飞机
//        self.view.addSubview(ssLogoView)
//        ssLogoView.snp.makeConstraints { (make) in
//            make.size.equalTo(60)
//            make.top.equalTo(view).offset(145)
//            make.rightMargin.equalTo(-80)
//        }
//
//
////        configLabel.text = NSLocalizedString("Configuration", comment: "")
//        configLabel.text = "点击进入"
//        configLabel.textColor = UIColor.white
//        configLabel.backgroundColor = UIColor.clear
//        configLabel.textAlignment = .center
//        configLabel.font = UIFont.boldSystemFont(ofSize: 48)
//        configLabel.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
//        self.view.addSubview(configLabel)
//        configLabel.snp.makeConstraints { (make) in
//            make.height.equalTo(48)
//            make.width.equalTo(125)
//            make.bottomMargin.equalTo(wavesView).offset(-43)
//            make.centerX.equalTo(view)
//        }
//
//        commentLabel.text = NSLocalizedString("Click", comment: "")
//        commentLabel.textColor = UIColor.white
//        commentLabel.backgroundColor = UIColor.clear
//        commentLabel.textAlignment = .center
//        commentLabel.font = UIFont.systemFont(ofSize: 17.5, weight: .light)
//        commentLabel.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
//        self.view.addSubview(commentLabel)
//        commentLabel.snp.makeConstraints { (make) in
//            make.height.equalTo(25)
//            make.width.equalTo(100)
//            make.topMargin.equalTo(wavesView).offset(36)
//            make.centerX.equalTo(view)
//        }
//        updateCommentLabel()
//
//
//        let menuButton = UIButton()
//        menuButton.setImage(UIImage(named: "menu"), for: .normal)
//        menuButton.addTarget(self, action: #selector(sideMenuButtonTapped), for: .touchUpInside)
//        self.view.addSubview(menuButton)
//        menuButton.snp.makeConstraints { (make) in
//            make.height.equalTo(30)
//            make.width.equalTo(32)
//            make.topMargin.equalTo(45)
//            make.leftMargin.equalTo(33)
//        }
//        prepareSideMenuView()
//
//        //connectButtonView
//        connectButtonView.backgroundColor = UIColor.clear
//        self.view.addSubview(connectButtonView)
//        connectButtonView.snp.makeConstraints { (make) in
//            make.size.equalTo(112)
//            make.bottomMargin.equalTo(-66)
//            make.centerX.equalTo(view)
//        }
//
//        //链接按钮
////        connectButton.setTitle(NSLocalizedString("Connect", comment: ""), for: .normal)
//        connectButton.setTitle("手动连接", for: .normal)
//        connectButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
//        connectButton.setTitleColor(UIColor.white, for: .normal)
//        connectButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        connectButton.backgroundColor = UIColor.red
//        connectButton.setBackgroundImage(UIImage(named: "triple"), for: .normal)
//
//        let methodconnect2 = HomeViewController2()
//        connectButton.addTarget(self, action: #selector(methodconnect2.connectButtonTapped2), for: .touchUpInside)
//        self.view.addSubview(connectButton)
//        connectButton.snp.makeConstraints { (make) in
//            make.size.equalTo(80)
//            make.center.equalTo(connectButtonView)
//        }
//
//        //配置按钮的视图
//        let settingConfiguration = UIButton()
//        settingConfiguration.backgroundColor = UIColor.clear
//        settingConfiguration.addTarget(self, action: #selector(goToSecondView2), for: .touchUpInside)
//        self.view.addSubview(settingConfiguration)
//        settingConfiguration.snp.makeConstraints { (make) in
//            make.center.equalTo(view)
//            make.size.equalTo(120)
//        }
//
//    }
//
//    //定义SideMenu视图,SideMenu库
//    func prepareSideMenuView(){
//        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
//        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
//        // (Optional) Prevent status bar area from turning black when menu appears:
//        SideMenuManager.default.menuFadeStatusBar = false
//        //自定义
//        SideMenuManager.default.menuPresentMode = .viewSlideInOut
//        SideMenuManager.default.menuWidth = max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.75), 240)  //屏幕的0.75比例
//    }
//    //为什么一定要执行goToSecondView()才能变成已连接
//    //第二视图
//    @objc func goToSecondView(sender: UIButton!) {
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let svc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//        self.present(svc, animated: true, completion: nil)
//
//    }
//    @objc func goToSecondView2(){
//        let mainVC = mainViewController()
//        self.present(mainVC, animated: true, completion: nil)
//    }
//    //SideMenu按键
//    @objc func sideMenuButtonTapped(sender: AnyObject){
//        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
//    }
//    //OC中的mainViewController.xib
//    @objc func mainxibView() -> UIView{
//        return Bundle.main.loadNibNamed("mainViewController", owner: nil, options: nil)?.first as! UIView
//    }
//    //点击连接按钮跳转到的方法
//    //调用该方法就可以连接成功
//    @objc public func connectButtonTapped() {
//        print("点击了连接")
//        //把OC项目中的Main主页加载进来
////        DispatchQueue.global().async {
////            let mainView : UIView =  Bundle.main.loadNibNamed("mainViewController", owner: nil, options: nil)?.first as! UIView
////            self.view.addSubview(mainView)
////        }
////    let mainVc = mainViewController()
////    self.present(mainVc, animated: true, completion: nil)
//
//        //转圈效果
////        buttonViewRotaion()
//        print("connectButtonTapped")
//        //原始的adress
////        let address = UserDefaults.standard.string(forKey: "address")
//        //我改的
//        let address = "18.136.201.122"
//        if address == nil {
//            //warning
////            let alert = SCLAlertView(appearance: alerViewAppearance)
////            alert.showWarning(emptyConfigWarning, subTitle: "", closeButtonTitle: NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
//        } else {
//            //开关
//            if(VpnManager.shared.vpnStatus == .off){
//                //要加载Main才能写入地址，端口号吗？而且一定要present出Main
//                DispatchQueue.main.async {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let svc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//                    self.present(svc, animated: true, completion: nil)
//
//                }
//
//                VpnManager.shared.connect()
//                plantTakesOff()
//                print("connect已连接")
//            }else{
//                VpnManager.shared.disconnect()
//               print("connect未连接")
//            }
//        }
//    }
//
//    func buttonViewRotaion(){
//        //Trick: start rotating with 180 degrees first and then rotate with 360 degrees. Use 2 animations with delay. In order to make it smooth, the delay for the second "animateWithDuration" needs to be half the size of the animation duration.
//        UIView.animate(withDuration: 0.5) {
//            self.connectButtonView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        }
//        UIView.animate(withDuration: 0.5, delay: 0.25, options:.curveEaseInOut, animations: {
//            self.connectButtonView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
//        }, completion: nil)
//    }
//
//    //更新配置标签
//    @objc public func updateCommentLabel(){
//        let address = UserDefaults.standard.string(forKey: "address")
//        let comment = UserDefaults.standard.string(forKey: "comment")
//        if address == nil {     //必须是nil，初始化时显示。之后是必填
//            self.commentLabel.text = NSLocalizedString("Click", comment: "")
//            return
//        } else {
//            if comment == "" {
////                self.commentLabel.text = NSLocalizedString("Configured", comment: "")
//                self.commentLabel.text = "go"
//            }else{
//                self.commentLabel.text = comment
//            }
//        }
//    }
//
//    //按钮状态
//    @objc func onVPNStatusChanged(){
//        self.status = VpnManager.shared.vpnStatus
//    }
//
//   @objc func updateConnectButton(){
//        switch status {
//        case .connecting:
//            connectButton.setTitle(NSLocalizedString("Connecting", comment: ""), for: UIControl.State())
//        case .disconnecting:
//            connectButton.setTitle(NSLocalizedString("Disconnecting", comment: ""), for: UIControl.State())
//        case .on:
//            connectButton.setTitle(NSLocalizedString("Connected", comment: ""), for: UIControl.State())
//        case .off:
//            connectButton.setTitle(NSLocalizedString("Disconnect", comment: ""), for: UIControl.State())
//        }
//        connectButton.isEnabled = [VPNStatus.on,VPNStatus.off].contains(VpnManager.shared.vpnStatus)
//    }
//
//    //飞机起飞
//    @objc func plantTakesOff(){
//        let originalCenter = ssLogoView.center
//        UIView.animateKeyframes(withDuration: 1.5, delay: 1, options: [], animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
//                self.ssLogoView.center.x += 80.0
//                self.ssLogoView.center.y -= 10.0
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
//                self.ssLogoView.center.x += 100.0
//                self.ssLogoView.center.y -= 50
//                self.ssLogoView.alpha = 0.0
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
//                self.ssLogoView.transform = CGAffineTransform(rotationAngle: -.pi/8)
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: {
//                self.ssLogoView.transform = CGAffineTransform.identity
//                self.ssLogoView.center = CGPoint(x: 0, y: originalCenter.y)
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
//                self.ssLogoView.alpha = 1.0
//                self.ssLogoView.center = originalCenter
//            })
//        }, completion: nil)
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        updateCommentLabel()
//        self.status = VpnManager.shared.vpnStatus   //改变状态
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//}
//如何声明这个类
@objc class HomeViewController2: UIViewController,UITextFieldDelegate {
    let bangView = BangView()
     let stepIndicatorView = StepIndicatorView()  //步骤指示
     //初始化在viewDidLoad前，对应键盘收回和snp的updateConstraints动画
     let peizhiLabel = UILabel()  //配置
     let typeLabel = UILabel()  //代理类型
     let typeButton = UIButton()  //ss
     let methodLabel = UILabel()  //加密方法
     let methodButton = UIButton()  //RC4MD5
     
     let addressTextField = HoshiTextField()
     let portTextField = HoshiTextField()
     let passwordTextField = HoshiTextField()
     let commentTextField = HoshiTextField()

     let nextStepButton = UIButton() //下一步按钮
     let previousStepButton = UIButton() //上一步按钮
    
    override func viewDidLoad() {
         super.viewDidLoad()
         Thread.sleep(forTimeInterval: 2.0) //启动延长2秒，看LaunchScreen
         
         //网络状态监测
         let reachability = Reachability()!
         do {
             try reachability.startNotifier()
         } catch {
             print("Unable to start notifier")
         }
         
         settingUI()
         settingSecondUI()
     }
          //链接按钮
            let connectButton2 = UIButton()
            let connectButtonView2 = ConnectButtonView()
    //        connectButton.setTitle(NSLocalizedString("Connect", comment: ""), for: .normal)
    @objc public func settingUI(){
        connectButtonView2.backgroundColor = UIColor.clear
         self.view.addSubview(connectButtonView2)
         connectButtonView2.snp.makeConstraints { (make) in
            make.size.equalTo(112)
            make.bottomMargin.equalTo(-238)
            make.centerX.equalTo(view)
        }
          connectButton2.setTitle("手动连接", for: .normal)
          connectButton2.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
          connectButton2.setTitleColor(UIColor.white, for: .normal)
          connectButton2.titleLabel?.adjustsFontSizeToFitWidth = true
          connectButton2.backgroundColor = UIColor.clear
          connectButton2.setBackgroundImage(UIImage(named: "triple"), for: .normal)
          
          let methodconnect2 = HomeViewController2()
          connectButton2.addTarget(self, action: #selector(methodconnect2.connectButtonTapped2), for: .touchUpInside)
          self.view.addSubview(connectButton2)
          connectButton2.snp.makeConstraints { (make) in
              make.size.equalTo(80)
              make.center.equalTo(connectButtonView2)
          }
    }
    @objc public func settingSecondUI(){
         //dismiss keyboard
                let tapper = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboard (_:)))
                self.view.addGestureRecognizer(tapper)
                //圆弧背景
                
//                self.view.addSubview(bangView)
//                bangView.snp.makeConstraints { (make) in
//                    make.right.equalTo(view)
//                    make.top.equalTo(view)
//                    make.bottom.equalTo(view)
//                    make.left.equalTo(view.snp.centerX)
//                }
                
                //取消键
                let cancelButton = UIButton()
                cancelButton.backgroundColor = UIColor.clear
                cancelButton.setImage(UIImage(named: "cancel"), for:.normal)
//                self.view.addSubview(cancelButton)
//                cancelButton.snp.makeConstraints { (make) in
//                    make.size.equalTo(32)
//                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
//                    make.left.equalTo(15)
//                }
                cancelButton.addTarget(self, action:#selector(cancel), for: .touchUpInside)
                
                //Labels配置标签
                peizhiLabel.text = NSLocalizedString("Configuration", comment: "")
                peizhiLabel.textColor = UIColor.gray
                peizhiLabel.backgroundColor = UIColor.clear
                peizhiLabel.textAlignment = .left
                peizhiLabel.font = UIFont.boldSystemFont(ofSize: 23)
                peizhiLabel.adjustsFontSizeToFitWidth = true
//                self.view.addSubview(peizhiLabel)
//                peizhiLabel.snp.makeConstraints { (make) in
//                    make.height.equalTo(40)
//                    make.width.equalTo(85)
//                    make.left.equalTo(50)
//                    make.top.equalTo(cancelButton.snp.bottom).offset(30)
//                }
                
                typeLabel.text = NSLocalizedString("Proxy type", comment: "")
                typeLabel.textColor = UIColor.darkGray
                typeLabel.backgroundColor = UIColor.clear
                typeLabel.textAlignment = .left
                typeLabel.font = UIFont.boldSystemFont(ofSize: 15)
//                self.view.addSubview(typeLabel)
//                typeLabel.snp.makeConstraints { (make) in
//                    make.height.equalTo(30)
//                    make.width.equalTo(85)
//                    make.left.equalTo(50)
//                    make.top.equalTo(peizhiLabel.snp.bottom).offset(20)
//                }
//
                typeButton.setTitle("Shadowsocks", for: .normal)
                typeButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight:.medium)
                typeButton.setTitleColor(UIColor.lightGray, for: .normal)
                typeButton.layer.borderColor = UIColor.lightGray.cgColor
                typeButton.layer.borderWidth = 1.2
                typeButton.layer.cornerRadius = 7
//                self.view.addSubview(typeButton)
//                typeButton.snp.makeConstraints { (make) in
//                    make.left.equalTo(50)
//                    make.height.equalTo(31)
//                    make.width.equalTo(210)
//                    make.top.equalTo(typeLabel.snp.bottom).offset(5)
//                }
                
                //地址栏配置
                addressTextField.placeholder = NSLocalizedString("Address", comment: "")
                addressTextField.placeholderColor = UIColor.red
                addressTextField.placeholderFontScale = 0.85
                addressTextField.borderActiveColor = Colors.deepBlue
                addressTextField.borderInactiveColor = .gray
                addressTextField.keyboardAppearance = .light
                addressTextField.keyboardType = .decimalPad
                addressTextField.delegate = self
                addressTextField.clearButtonMode = .whileEditing
                addressTextField.autocorrectionType = UITextAutocorrectionType.no
                addressTextField.text = UserDefaults.standard.string(forKey: "address") ?? ""
                //手动添加地址
                addressTextField.text = "18.136.201.122"
                
//                self.view.addSubview(addressTextField)
//                addressTextField.snp.makeConstraints { (make) in
//                    make.left.equalTo(50)
//                    make.top.equalTo(typeButton.snp.bottom).offset(38)
//                    make.height.equalTo(60)
//                    make.width.equalTo(210)
//                }
//
                //端口栏配置
                portTextField.placeholder = NSLocalizedString("Prot", comment: "")
                portTextField.placeholderColor = UIColor.red
                portTextField.placeholderFontScale = 0.85
                portTextField.borderActiveColor = Colors.deepBlue
                portTextField.borderInactiveColor = .gray
                portTextField.delegate = self
                portTextField.clearButtonMode = .whileEditing
                portTextField.keyboardType = .decimalPad
                portTextField.autocorrectionType = UITextAutocorrectionType.no
                portTextField.text = UserDefaults.standard.string(forKey: "port") ?? ""
                //手动添加端口号
                portTextField.text = "12471"
//                self.view.addSubview(portTextField)
//                portTextField.snp.makeConstraints { (make) in
//                    make.left.equalTo(50)
//                    make.height.equalTo(60)
//                    make.width.equalTo(210)
//                    make.top.equalTo(addressTextField.snp.bottom).offset(42)
//                }
                
                //加密方法
                methodLabel.text = NSLocalizedString("Method", comment: "")
                methodLabel.textColor = UIColor.blue
                methodLabel.backgroundColor = UIColor.clear
                methodLabel.textAlignment = .left
                methodLabel.font = UIFont.boldSystemFont(ofSize: 15)
                //手动添加加密方法
        //      methodLabel.text = "RC4MD5"
                let method:String = "RC4MD5"
                UserDefaults.standard.set(method,forKey: "method")
//                self.view.addSubview(methodLabel)
//                methodLabel.snp.makeConstraints { (make) in
//                    make.height.equalTo(30)
//                    make.width.equalTo(85)
//                    make.left.equalTo(-300)  //隐藏
//                    make.top.equalTo(peizhiLabel.snp.bottom).offset(20)
//                }
                
                if UserDefaults.standard.string(forKey: "method") == nil {
                    methodButton.setTitle(NSLocalizedString("Please select a Method", comment: ""), for: .normal)
                    //写死加密方法
                    methodButton.setTitle("RC4MD5", for: .normal)
                    methodButton.setTitleColor(UIColor.lightGray, for: .normal)
                } else {
                    let method = UserDefaults.standard.string(forKey: "method")
                    methodButton.setTitle(method, for: .normal)
                    methodButton.setTitleColor(UIColor.black, for: .normal)
                }
                methodButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight:.medium)
                methodButton.layer.borderColor = UIColor.lightGray.cgColor
                methodButton.layer.borderWidth = 1.2
                methodButton.layer.cornerRadius = 7
                methodButton.addTarget(self, action: #selector(selectMethod),for:.touchUpInside)
//                self.view.addSubview(methodButton)
//                methodButton.snp.makeConstraints { (make) in
//                    make.left.equalTo(-300)  //隐藏
//                    make.height.equalTo(31)
//                    make.width.equalTo(210)
//                    make.top.equalTo(methodLabel.snp.bottom).offset(5)
//                }
         
                //密码栏
                passwordTextField.placeholder = NSLocalizedString("Password", comment: "")
                passwordTextField.placeholderColor = UIColor.green
                passwordTextField.placeholderFontScale = 0.85
                passwordTextField.borderActiveColor = Colors.deepBlue
                passwordTextField.borderInactiveColor = .gray
                passwordTextField.clearButtonMode = .never
                passwordTextField.autocorrectionType = UITextAutocorrectionType.no
                passwordTextField.isSecureTextEntry = true
                
                //密码是否可见
                let rightView = UIButton(frame: CGRect(x:0, y:0, width:23, height:23))
                rightView.addTarget(self, action: #selector(changeSecureTextEntry), for: .touchUpInside)
                rightView.setImage(UIImage(named: "eye"), for: .normal)
                passwordTextField.rightView = rightView
                passwordTextField.rightViewMode = .whileEditing
                passwordTextField.delegate = self
                passwordTextField.text = UserDefaults.standard.string(forKey: "password") ?? ""
                //手动添加密码
                passwordTextField.text = "dilufeikuai"
//                self.view.addSubview(passwordTextField)
//                passwordTextField.snp.makeConstraints { (make) in
//                    make.left.equalTo(-300)  //隐藏
//                    make.top.equalTo(methodButton.snp.bottom).offset(38)
//                    make.height.equalTo(60)
//                    make.width.equalTo(210)
//                }
                
                //备注栏
                commentTextField.placeholder = NSLocalizedString("Comment(optinal)", comment: "")
                commentTextField.placeholderColor = UIColor.darkGray
                commentTextField.placeholderFontScale = 0.85
                commentTextField.borderActiveColor = Colors.deepBlue
                commentTextField.clearButtonMode = .whileEditing
                commentTextField.autocorrectionType = UITextAutocorrectionType.no
                commentTextField.borderInactiveColor = .gray
                commentTextField.delegate = self
                commentTextField.text = UserDefaults.standard.string(forKey: "comment") ?? ""
//                self.view.addSubview(commentTextField)
//                commentTextField.snp.makeConstraints { (make) in
//                    make.left.equalTo(-300)  //隐藏
//                    make.height.equalTo(60)
//                    make.width.equalTo(210)
//                    make.top.equalTo(passwordTextField.snp.bottom).offset(42)
//                }
//
                //步骤指示的设置
                stepIndicatorView.frame = CGRect(x:0, y: 0, width: 0, height: 190)  //width没有影响，height调整视图的高
                // self.stepIndicatorView.backgroundColor = UIColor.clear
                stepIndicatorView.numberOfSteps = 2
                stepIndicatorView.currentStep = 0
                stepIndicatorView.circleColor = Colors.amber  //外圈
                stepIndicatorView.circleTintColor = Colors.amber  //里点颜色
                stepIndicatorView.circleStrokeWidth = 2.0
                stepIndicatorView.circleRadius = 13.0  //圈大小
                stepIndicatorView.lineColor = UIColor.lightGray
                stepIndicatorView.lineTintColor = UIColor.orange
                stepIndicatorView.lineMargin = 8.0
                stepIndicatorView.lineStrokeWidth = 0
                stepIndicatorView.displayNumbers = false //indicates if it displays numbers at the center instead of the core circle
                stepIndicatorView.direction = .topToBottom //four directions
                bangView.addSubview(stepIndicatorView)
                stepIndicatorView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(bangView).offset(-190)
                    make.centerX.equalTo(bangView).multipliedBy(1.38164251)
                }
                
                
                //下一步按钮
                nextStepButton.backgroundColor = UIColor.yellow
                nextStepButton.setBackgroundImage(UIImage(named: "next"), for:.normal)
                nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
//                self.view.addSubview(nextStepButton)
//                nextStepButton.snp.makeConstraints { (make) in
//                    make.size.equalTo(66)
//                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-88)
//                    make.right.equalTo(-38)
//                }
//
                //上一步按钮
                previousStepButton.backgroundColor = UIColor.clear
                previousStepButton.setImage(UIImage(named: "back"), for:.normal)
                previousStepButton.addTarget(self, action: #selector(previousStep), for: .touchUpInside)
//                self.view.addSubview(previousStepButton)
//                previousStepButton.snp.makeConstraints { (make) in
//                    make.size.equalTo(42)
//                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-100)
//                    make.left.equalTo(-300)  //隐藏
//                }
//
                
                //在键盘上添加“完成“按钮
                addDoneButtonOnKeyboard()
    }
     //调用该方法就可以连接成功
    @objc public func connectButtonTapped2() {
        
            print("点击了从写连接VPN的按钮")
            //转圈效果
//            buttonViewRotaion()
            print("connectButtonTapped")
            //原始的adress
    //        let address = UserDefaults.standard.string(forKey: "address")
            //我改的
            let address = "18.136.201.122"
            if address == nil {
                //warning
    //            let alert = SCLAlertView(appearance: alerViewAppearance)
    //            alert.showWarning(emptyConfigWarning, subTitle: "", closeButtonTitle: NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
            } else {
                //开关
                if(VpnManager.shared.vpnStatus == .off){
                    //要加载Main才能写入地址，端口号吗？而且一定要present出Main
//                    DispatchQueue.main.async {
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let svc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//                              self.present(svc, animated: true, completion: nil)
//                    }
               
                    VpnManager.shared.connect()
                    
                    print("connect已连接")
                }else{
                    VpnManager.shared.disconnect()
                   print("connect未连接")
                }
            }
        }
     //method选择：加密方法选择
        @objc func selectMethod(sender: AnyObject){
            
            let methodSelected = UIAlertController(title: nil, message: NSLocalizedString("Please select a Method", comment: ""), preferredStyle: .actionSheet)
            
            methodSelected.addAction(UIAlertAction(title: "RC4MD5", style: .default , handler:{ (UIAlertAction)in
                self.methodButton.setTitle("RC4MD5", for: .normal)
                self.methodButton.setTitleColor(UIColor.red, for: .normal)
                //保存method到UserDefaults
    //          let method:String = self.methodButton.title(for: .normal)!
                let method:String = "RC4MD5"
                UserDefaults.standard.set(method,forKey: "method")
            }))
            methodSelected.addAction(UIAlertAction(title: "SALSA20", style: .default , handler:{ (UIAlertAction)in
                self.methodButton.setTitle("SALSA20", for: .normal)
                self.methodButton.setTitleColor(UIColor.black, for: .normal)
                //保存method到UserDefaults
                let method:String = self.methodButton.title(for: .normal)!
                UserDefaults.standard.set(method,forKey: "method")
            }))
            methodSelected.addAction(UIAlertAction(title: "CHACHA20", style: .default , handler:{ (UIAlertAction)in
                self.methodButton.setTitle("CHACHA20", for: .normal)
                self.methodButton.setTitleColor(UIColor.black, for: .normal)
                //保存method到UserDefaults
                let method:String = self.methodButton.title(for: .normal)!
                UserDefaults.standard.set(method,forKey: "method")
            }))
            methodSelected.addAction(UIAlertAction(title: "AES128CFB", style: .default , handler:{ (UIAlertAction)in
                self.methodButton.setTitle("AES128CFB", for: .normal)
                self.methodButton.setTitleColor(UIColor.black, for: .normal)
                //保存method到UserDefaults
                let method:String = self.methodButton.title(for: .normal)!
                UserDefaults.standard.set(method,forKey: "method")
            }))
            methodSelected.addAction(UIAlertAction(title: "AES192CFB", style: .default , handler:{ (UIAlertAction)in
                self.methodButton.setTitle("AES192CFB", for: .normal)
                self.methodButton.setTitleColor(UIColor.black, for: .normal)
                //保存method到UserDefaults
                let method:String = self.methodButton.title(for: .normal)!
                UserDefaults.standard.set(method,forKey: "method")
            }))
            methodSelected.addAction(UIAlertAction(title: "AES256CFB", style: .default , handler:{ (UIAlertAction)in
                self.methodButton.setTitle("AES256CFB", for: .normal)
                self.methodButton.setTitleColor(UIColor.black, for: .normal)
                //保存method到UserDefaults
                let method:String = self.methodButton.title(for: .normal)!
                UserDefaults.standard.set(method,forKey: "method")
            }))

            methodSelected.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler:nil))
            
            // On iPad, action sheets must be presented from a popover.
            methodSelected.popoverPresentationController?.sourceView = bangView
            
            self.present(methodSelected, animated: true, completion: nil)
        }
        
        
        
        //下一步操作:调用连接成功方法
        @objc public func nextStep(){
            print("点击下一步按钮")
            if stepIndicatorView.currentStep == 0 {
                stepIndicatorView.currentStep += 1
                print(stepIndicatorView.currentStep)
                
                //out
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.typeLabel.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.typeButton.snp.updateConstraints({ (make) in
                        make.left.equalTo(-300)
                    })
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.addressTextField.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                    self.portTextField.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.view.layoutIfNeeded()
                })
                
                //in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.methodLabel.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.methodButton.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.passwordTextField.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                    self.commentTextField.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.previousStepButton.snp.updateConstraints { make in
                        make.left.equalTo(42)
                    }
                    self.view.layoutIfNeeded()
                })
            } else if stepIndicatorView.currentStep == 1{
                
                //检查应填项目是否为空
                //判断地址是否为空
                if (addressTextField.text?.isEmpty)! {
    //                let alert = SCLAlertView(appearance: alerViewAppearance)
    //                alert.showWarning(emptyAddressWarning, subTitle: "", closeButtonTitle: NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
                    print("地址为空")
                }
                //判断端口号是否为空
                else if (portTextField.text?.isEmpty)! {
    //                let alert = SCLAlertView(appearance: alerViewAppearance)
    //                alert.showWarning(emptyPortWarning, subTitle: "", closeButtonTitle:  NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
                    print("端口为空")
                }
                //判断加密方法是否为空
                else if methodButton.currentTitle ==  NSLocalizedString("请选择加密方法", comment: "") {
    //                let alert = SCLAlertView(appearance: alerViewAppearance)
    //                alert.showWarning(emptyMethodWarning, subTitle: "", closeButtonTitle:  NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
                    print("加密为空")
                }
                //判断密码是否为空
                else if (passwordTextField.text?.isEmpty)! {
    //                let alert = SCLAlertView(appearance: alerViewAppearance)
    //                alert.showWarning(emptyPasswordWarning, subTitle: "", closeButtonTitle:  NSLocalizedString("OK", comment: ""), colorStyle: 0xFFC107, colorTextButton: 0xFFFFFF, circleIconImage: UIImage(named: "warning"))
                    print("密码为空")
                }
                else {
                    stepIndicatorView.currentStep += 1
                    //这里打印2
                    print(stepIndicatorView.currentStep)
    //                saveAction()
    //                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
    //                    self.goToSucceededView()
    //                })
                }
                
            } else {
                return print(stepIndicatorView.currentStep)
            }
        }
        //第三视图
        @objc func goToSucceededView() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let succeededView = storyboard.instantiateViewController(withIdentifier: "SucceededViewController") as! SucceededViewController
            self.present(succeededView, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.presentingViewController?.dismiss(animated: false, completion: nil)  //取消第二视图，回到根视图
            }
            
        }
        
        //上一步操作
        @objc func previousStep(){
            if stepIndicatorView.currentStep == 1 || stepIndicatorView.currentStep == 2{
                stepIndicatorView.currentStep = 0
                print(stepIndicatorView.currentStep)
                
                //out
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.methodLabel.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.methodButton.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.passwordTextField.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                    self.commentTextField.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.previousStepButton.snp.updateConstraints { make in
                        make.left.equalTo(-300)
                    }
                    self.view.layoutIfNeeded()
                })
                //in
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.typeLabel.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.typeButton.snp.updateConstraints({ (make) in
                        make.left.equalTo(50)
                    })
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.addressTextField.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: {
                    self.portTextField.snp.updateConstraints { make in
                        make.left.equalTo(50)
                    }
                    self.view.layoutIfNeeded()
                })
                
            } else {
                return print(stepIndicatorView.currentStep)
            }
        }
        
        //保存
        @objc func saveAction() {
            
            let address:String = addressTextField.text!
            UserDefaults.standard.set(address,forKey: "address")
            
            let port:String = portTextField.text!
            UserDefaults.standard.set(port,forKey: "port")
            
            let password:String = passwordTextField.text!
            UserDefaults.standard.set(password,forKey: "password")
            
            let comment = commentTextField.text     //comment 可以为空
            UserDefaults.standard.set(comment, forKey: "comment")
            
            print("Swift保存了配置")
        }
        //保存方法二
        @objc func saveAction2() {
              
              let address:String = "18.136.201.122"
              UserDefaults.standard.set(address,forKey: "address")
              
              let port:String = "12471"
              UserDefaults.standard.set(port,forKey: "port")
              
              let password:String = "dilufeikuai"
              UserDefaults.standard.set(password,forKey: "password")
              
              let comment = commentTextField.text     //comment 可以为空
              UserDefaults.standard.set(comment, forKey: "comment")
              
              print("Swift保存了配置方法二")
    //        [HomeViewController updateCommentLabel]

          }
        //取消视图
        @objc func cancel(){
            self.dismiss(animated: true, completion: nil)
        }
        
        //键盘收起,和super.viewDidLoad()中的dismiss keyboard对应。
        @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
            addressTextField.resignFirstResponder()
            portTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            commentTextField.resignFirstResponder()
            self.view.frame.origin.y = 0
        }
        
        //密码是否可见
        var iconClick = true
        @objc func changeSecureTextEntry(sender: UIButton){
            if(iconClick == true) {
                self.passwordTextField.isSecureTextEntry = false
            } else {
                self.passwordTextField.isSecureTextEntry = true
            }
            iconClick = !iconClick
        }
        
        //在键盘上添加“完成“按钮
        func addDoneButtonOnKeyboard() {
            let doneToolbar = UIToolbar()
            //左侧的空隙
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
            //右侧的完成按钮
            let done: UIBarButtonItem = UIBarButtonItem(title:  NSLocalizedString("Done", comment: ""), style: .done,
                                                        target: self,
                                                        action: #selector(doneButtonAction))
            
            var items:[UIBarButtonItem] = []
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            
            self.addressTextField.inputAccessoryView = doneToolbar
            self.portTextField.inputAccessoryView = doneToolbar
            self.passwordTextField.inputAccessoryView = doneToolbar
            self.commentTextField.inputAccessoryView = doneToolbar
        }
        
        //“完成“按钮点击响应
        @objc func doneButtonAction() {
            //收起键盘
            self.addressTextField.resignFirstResponder()
            self.portTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
            self.commentTextField.resignFirstResponder()
        }
       
        //TextFieldDelegate
        public func textFieldDidBeginEditing(_ textField:UITextField) {
            //view弹起跟随键盘，高可根据自己定义
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y = -100
            })
            
        }
        public func textFieldDidEndEditing(_ textField: UITextField) {
            textField.resignFirstResponder()
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y = 0
            })
            
        }
        public func textFieldShouldClear(_ textField: UITextField) -> Bool {
            return true
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y = 0
            })
           return true
        }
}



//let vc = HomeViewController.init(coder: NSCoder)
