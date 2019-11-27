//
//  mainViewController.m
//  Canbee
//
//  Created by Kluth on 2019/10/30.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//
#import "commonNav.h"
#import "mainViewController.h"
#import "UIColor+Hex.h"
#import "commonNavStoryboardController.h"
#import "commonTableViewController.h"
#import "addTimeViewController.h"
#import "personCenterViewController.h"
#import "HXnavigationController.h"
#import "UserItems.h"
#import "networktool.h"
#import "superLinkViewController.h"
#import "pupView.h"
#import "deepNightController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "labelScroll.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//OC调用Swift的桥
#import "Lead-Swift.h"

@interface mainViewController ()<CustomIOSAlertViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UIView *commoNav;
@property (weak, nonatomic) IBOutlet UIView *personCenter;
@property (weak, nonatomic) IBOutlet UIView *nightWelfare;
@property (weak, nonatomic) IBOutlet UILabel *hourTime;

@property (weak, nonatomic) IBOutlet UILabel *minuteTime;

@property (weak, nonatomic) IBOutlet UILabel *secondTime;
@property (weak, nonatomic) IBOutlet UIImageView *addTimeView;

@property (weak, nonatomic) IBOutlet UIButton *addTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *personCenterBtn;
/*可变的用户数据*/
@property (nonatomic,strong) NSMutableArray *mutableitems;
@property(nonatomic,weak) NSTimer *timer;
//弹窗口
@property(nonatomic,strong) CustomIOSAlertView *alertView;
@property(nonatomic,weak) UITextField *username;
@property(nonatomic,weak) UITextField *password;
@property(nonatomic,assign)NSInteger shoumiNS;

@property (weak, nonatomic) IBOutlet UILabel *topNotice;
@property(strong,nonatomic)pupView *myView;
//定位服务
@property (strong, nonatomic) CLLocationManager* manager;
//记录注册城市
@property (nonatomic,strong) NSString *registerCity;
@end

@implementation mainViewController
//-(instancetype)init{
//    if (self=[super init]) {
//        self.title=@"视图一";
//        [self.view addSubview:self.myView];
////        _myView.delegate=self;//指定代理
//    }
//    return self;
//}
//定位服务
- (CLLocationManager *)manager
{
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        
        _manager.delegate = self;
        // 请求前台授权
        [_manager requestWhenInUseAuthorization];
        // 请求前后台授权
//        [_manager requestAlwaysAuthorization];
    }
    return _manager;
}
- (NSInteger)shoumiNS{
        static int shoumiNS = 900;
        _shoumiNS = shoumiNS;

    return _shoumiNS;
}
- (CustomIOSAlertView *)alertView{
	if(_alertView == nil){
			CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
		_alertView = alertView;
	}
	return _alertView;
}
- (UITextField *)username{
	if(_username == nil){
		UITextField *username = [[UITextField alloc] init];
		_username  = username;
	}
	return _username;
}
- (UITextField *)password{
	if(_password == nil){
		UITextField *password = [[UITextField alloc] init];
		_password = password;
	}
	return _password;
}
- (void)rotateView:(UIImageView *)view
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3;
    rotationAnimation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //公告滚动 152 70 59
    NSString *Str = @"每日不停跟新，每日不停跟新，每日不停跟新，每日不停更新";
    labelScroll *label = [[labelScroll alloc]initWithFrame:CGRectMake(98, 0, 300, 29.5)];
//    UIColor *colorTop = MJSColor(152, 70, 59);
    [label setBackgroundColor:[UIColor clearColor]];
    label.labelText = Str ;
//    label.layer.cornerRadius = 12.5;
    [self.noticeView addSubview:label];
    
    
    [self rotateView:self.addTimeView];
    self.view.backgroundColor = MJSColor(61, 148, 182)
//	self.Viewcontroller.frame = CGRectMake(0,64,375,29.5);
////	self.Viewcontroller.backgroundColor = [UIColor colorWithHexString:@"#001C58"];
//	self.Viewcontroller.backgroundColor = [UIColor colorWithRed:0/255.0 green:28/255.0 blue:88/255.0 alpha:1.0];
	//布局
	[self viewSetting];
    //倒计时方法二
	//创建定时器
//	_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondTimeChange) userInfo:nil repeats:YES];
//	[self timeout];
	//请求网络数据
	[self loadData];
    
    //注册ID
   
}
-(void)viewSetting{
	self.noticeView.backgroundColor = [UIColor colorWithRed:15/255.0 green:125/255.0 blue:165/255.0 alpha:1.0];
	
	self.hourTime.layer.cornerRadius = 5;
	self.hourTime.layer.borderWidth = 1.5;
	self.hourTime.layer.borderColor = [[UIColor whiteColor] CGColor];
	//剩余时间
	self.minuteTime.layer.cornerRadius = 5;
	self.minuteTime.layer.borderWidth = 1.5;
	self.minuteTime.layer.borderColor = [[UIColor whiteColor] CGColor];
	
	self.secondTime.layer.cornerRadius = 5;
	self.secondTime.layer.borderWidth = 1.5;
	self.secondTime.layer.borderColor = [[UIColor whiteColor] CGColor];
	
	self.commoNav.layer.borderWidth = 1.5;
	self.commoNav.layer.borderColor = [[UIColor whiteColor] CGColor];
	self.commoNav.layer.cornerRadius = 19.3;
	
	self.personCenter.backgroundColor = [UIColor colorWithRed:53/255.0 green:87/255.0 blue:223/255.0 alpha:1.0];
	self.nightWelfare.backgroundColor = [UIColor colorWithRed:29/255.0 green:54/255.0 blue:136/255.0 alpha:1.0];
	
	UILabel *label = [[UILabel alloc] init];
	label.frame = CGRectMake(288,508,32,34);
	label.numberOfLines = 0;
	[self.view addSubview:label];
	
	[self.addTimeButton setTitle:@"增加时长" forState:UIControlStateNormal];
    _addTimeButton.titleLabel.font= [UIFont systemFontOfSize:22];
    UIColor *color = MJSColor(168, 42, 23);
//    [self.addTimeButton setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    [self.addTimeButton setTitleColor:color forState:UIControlStateNormal];
	self.addTimeButton.lineBreakMode = 0;
    //240 109 87
}
//判断用户是否登录，登录后将用户名写入plist修改登录状态。

-(void)loadData{
	//1.创建会话层
	AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
	//2.拼接请求参数
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	
	//		self.mutableitems =	[UserItems mj_objectArrayWithKeyValuesArray:responseObject[@"item"]];
	//		//刷新数据
	//		UserItems *useritem = [[UserItems alloc] init];
	//		NSLog(@"%ld个用户名字",self.mutableitems.count);
	//		for(NSString *key in self.mutableitems){
	//			NSLog(@"%@",key);
	//			NSLog(@"%@",self.mutableitems);
	//		}
	//	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
	//		NSLog(@"请求失败");
	//	}];
	
	//4.发送请求POST
	[mgr POST:@"file:///Users/kluth/Desktop/Canbee/vadmin.json" parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
		nil;
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//		NSLog(@"请求成功 - %@",responseObject);
//		[responseObject writeToFile:@"/Users/kluth/Desktop/Canbee/Canbee/Canbee/Canbee/Classes/main(主页)/Model/hxposts.plist" atomically:YES ];
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"请求失败");
	}];
}
//倒计时方法二
-(void)secondTimeChange{
	static int totalTime = 60;
	NSInteger minutes1;
	NSInteger second1;
	minutes1 = totalTime / 60;
	second1 = totalTime / 60 % 60;
//		static int i = 60;
//		if(i == 0){
//			[self jumpBtn:nil];
//		}
//		i--;

	totalTime--;
//	[_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
//	self.secondTime.text = i;
//	[_minuteTime setText:[NSString stringWithFormat:@"%ld",minutes1]];
//	[_secondTime setText:[NSString stringWithFormat:@"%ld",second1]];

}
-(void)loginRegisterAlert{
	// Here we need to pass a full frame
	// Add some custom content to the alert view
	[self.alertView setContainerView:[self createDemoView]];
	
	// Modify the parameters
	[self.alertView setButtonTitles:[NSMutableArray arrayWithObjects: @"取消", nil]];
	[self.alertView setDelegate:self];
	
	// You may use a Block, rather than a delegate.
	[self.alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
		NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
		[alertView close];
	}];
	[self.alertView setUseMotionEffects:true];
	// And launch the dialog
	[self.alertView show];
}
-(void)buyAlert{
	// Here we need to pass a full frame
	// Add some custom content to the alert view
	[self.alertView setContainerView:[self createbuyView]];
	
	// Modify the parameters
	[self.alertView setButtonTitles:[NSMutableArray arrayWithObjects: @"取消", nil]];
	[self.alertView setDelegate:self];
	
	// You may use a Block, rather than a delegate.
	[self.alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
		NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
		[alertView close];
	}];
	[self.alertView setUseMotionEffects:true];
	// And launch the dialog
	[self.alertView show];
}
-(UIView *)createbuyView{
	UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 243, 200)];
	//	demoView.backgroundColor = [UIColor grayColor];
	demoView.layer.borderWidth = 0;
	demoView.layer.cornerRadius = 1.4;
	
	UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 10, 195, 152)];
	textLabel.text = @"黄金线路有15分钟的无条件免费使用时长。如需增加时长，请移步增加时长界面";
	textLabel.numberOfLines = 4;
	UIButton *registerBtn = [[UIButton alloc] init];
	[registerBtn setImage:[UIImage imageNamed:@"继续连接"] forState:UIControlStateNormal];
	[registerBtn setFrame:CGRectMake(24, 150, 90.5, 36)];
	//	[registerBtn setBackgroundColor:[UIColor blueColor]];
	//	[registerBtn setTitle:@"注册" forState:UIControlStateNormal];
	//	[registerBtn setTitle:@"点击注册" forState:UIControlStateHighlighted];
	[registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[registerBtn addTarget:self action:@selector(continueConnect) forControlEvents:UIControlEventTouchUpInside];
	UIButton *passwordBtn = [[UIButton alloc] init];
	[passwordBtn setFrame:CGRectMake(128.5, 150, 90.5, 36)];
	[passwordBtn setImage:[UIImage imageNamed:@"addTime1"] forState:UIControlStateNormal];
	//	[passwordBtn setBackgroundColor:[UIColor blueColor]];
	//	[passwordBtn setTitle:@"登录" forState:UIControlStateNormal];
	//	[passwordBtn setTitle:@"点击登录" forState:UIControlStateHighlighted];
	[passwordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[passwordBtn addTarget:self action:@selector(addTimeBtn) forControlEvents:UIControlEventTouchUpInside];
	
	[demoView addSubview:textLabel];
	[demoView addSubview:registerBtn];
	[demoView addSubview:passwordBtn];
	
	return demoView;
}
-(void)continueConnect{
    NSLog(@"点击继续链接按钮");
    [self.alertView close];
}
//倒计时方法二
-(void)timeout{
	 self.shoumiNS = 900;
	__block int timeout = self.shoumiNS; //倒计时时间
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
	
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
	
	dispatch_source_set_event_handler(_timer, ^{
		
		if(timeout<=0){ //倒计时结束，关闭
			
			dispatch_source_cancel(_timer);
			dispatch_async(dispatch_get_main_queue(), ^{
				
				//设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
				
//				self.ShouMIdate.text =@"0天0时0分0秒";
				
			});
			
		}else{
			
			dispatch_async(dispatch_get_main_queue(), ^{
				
				//设置界面的按钮显示 根据自己需求设置
				
				//                NSLog(@"____%@",strTime);
				
				int second =timeout%60;//秒
				
				int minutes = timeout/60%60;//分钟的。
				
				int hour = timeout/60/60%24;//小时
				
				int day = timeout/60/60/24;//天
				
				NSString *strTime = [NSString stringWithFormat:@"%d天%d小时%d分钟%d秒",day,hour,minutes,second ];
				
//				_ShouMIdate.text =strTime;
//				NSLog(@"%d天%d小时%d分钟%d秒",day,hour,minutes,second);
				
				[self.secondTime setText:[NSString stringWithFormat:@"%d",second]];
				[self.minuteTime setText:[NSString stringWithFormat:@"%d",minutes]];
			});
			
			timeout--;
			
		}
		
	});
	
	dispatch_resume(_timer);
	
}

- (IBAction)commoeNavBtn:(id)sender {
	//进入到常用导航栏
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([commonNav class]) bundle:nil];
	commonTableViewController *commonNav = [storyboard instantiateInitialViewController];
	
	[self presentViewController:commonNav animated:YES completion:^{
		NSLog(@"进入了常用导航栏");
	}];
}
//
- (IBAction)personCenter1:(UIButton *)sender {
	//判断是否已经登录
//	if(self.exist){
//		[self loginRegisterAlert];
//		return;
//	}
//	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"userloginInfo" ofType:@"plist"];
//	NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//	NSLog(@"*****************%@",data);
//	NSLog(@"%@",[data valueForKey:@"userloginStatus"]);
	
	
	//给个人中新添加导航栏
//	HXnavigationController *nav1 = [[HXnavigationController alloc] initWithRootViewController:personCenterVc];
//	[self addChildViewController:nav1];
}
//原始的弹窗
- (IBAction)personCenter:(UIButton *)sender {
    //判断用户是否登录了
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if(name == nil){
        NSLog(@"用户未登录");
        [self loginRegisterAlert];
    }else{
        personCenterViewController *personCenterVc = [[personCenterViewController alloc] init];
        [self presentViewController:personCenterVc animated:YES completion:^{
            NSLog(@"进入了个人中心");
        }];
    }
//	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"userloginInfo" ofType:@"plist"];
//	NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//	NSLog(@"-------------%@",data);
//	NSLog(@"%@",[data valueForKey:@"userloginStatus"]);
//	Boolean *password = false;
//	if(!password){
//		// Here we need to pass a full frame
//		CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
//
//		// Add some custom content to the alert view
//		[alertView setContainerView:[self createDemoView]];
//
//		// Modify the parameters
//		[alertView setButtonTitles:[NSMutableArray arrayWithObjects: @"取消", nil]];
//		[alertView setDelegate:self];
//
//		// You may use a Block, rather than a delegate.
//		[alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
//			NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
//			[alertView close];
//		}];
//
//		[alertView setUseMotionEffects:true];
//
//		// And launch the dialog
//		[alertView show];
//	}
	//给个人中新添加导航栏
	//	HXnavigationController *nav1 = [[HXnavigationController alloc] initWithRootViewController:personCenterVc];
	//	[self addChildViewController:nav1];
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
	NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
	[alertView close];
}
- (UIView *)createDemoView
{
    
   
	UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 243, 200)];
	
    //用户名与密码框的背景图
      UIView *countBg = [[UIView alloc] initWithFrame:CGRectMake(24, 50, 195, 30)];
    countBg.backgroundColor = [UIColor whiteColor];
    countBg.layer.cornerRadius = 5;
    [demoView addSubview:countBg];
//   UIImageView *imageVc1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
//       imageVc1.image = [UIImage imageNamed:@"countImage"];
//    [countBg addSubview:imageVc1];
    
    UIView *countBg1 = [[UIView alloc] initWithFrame:CGRectMake(24, 95, 195, 30)];
       countBg1.backgroundColor = [UIColor whiteColor];
    countBg1.layer.cornerRadius = 5;
       [demoView addSubview:countBg1];
 
    
	//	_username = [[UITextField alloc] init];
	[self.username setFrame:CGRectMake(40, 50, 170, 30)];
	[self.username setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.username.textColor = [UIColor blackColor];
    //placeholder属性
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:
       @{NSForegroundColorAttributeName:[UIColor grayColor],
                    NSFontAttributeName:self.username.font
            }];
    self.username.attributedPlaceholder = attrString;
    self.username.backgroundColor = [UIColor whiteColor];
	//[self.username addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
	
	self.password.secureTextEntry = YES;
	[self.password setFrame:CGRectMake(40,95, 170, 30)];
    //placeholder属性
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
          @{NSForegroundColorAttributeName:[UIColor grayColor],
                       NSFontAttributeName:self.username.font
               }];
    self.password.attributedPlaceholder = attrString2;
	[self.password setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.password.textColor = [UIColor blackColor];
    self.password.backgroundColor = [UIColor whiteColor];
	//[self.password addTarget:self action:@selector(passwordFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
	
	UIButton *registerBtn = [[UIButton alloc] init];
	[registerBtn setImage:[UIImage imageNamed:@"register1"] forState:UIControlStateNormal];
	[registerBtn setFrame:CGRectMake(24, 150, 90.5, 36)];
	//	[registerBtn setBackgroundColor:[UIColor blueColor]];
	//	[registerBtn setTitle:@"注册" forState:UIControlStateNormal];
	//	[registerBtn setTitle:@"点击注册" forState:UIControlStateHighlighted];
	[registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[registerBtn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
	UIButton *passwordBtn = [[UIButton alloc] init];
	[passwordBtn setFrame:CGRectMake(128.5, 150, 90.5, 36)];
	[passwordBtn setImage:[UIImage imageNamed:@"login1"] forState:UIControlStateNormal];
	//	[passwordBtn setBackgroundColor:[UIColor blueColor]];
	//	[passwordBtn setTitle:@"登录" forState:UIControlStateNormal];
	//	[passwordBtn setTitle:@"点击登录" forState:UIControlStateHighlighted];
	[passwordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[passwordBtn addTarget:self action:@selector(loginBtn:password:) forControlEvents:UIControlEventTouchUpInside];
	//提示用户需要登录注册
	UILabel *noticeLabel = [[UILabel alloc] init];
	NSString *str = @"账号登陆: 直接填写账号密码即可登录";
	noticeLabel.text = str;
	noticeLabel.textColor = [UIColor redColor];
	
	[noticeLabel setFont:[UIFont systemFontOfSize:12]];
	//	noticeLabel.text attr
	[noticeLabel setFrame:CGRectMake(20, 16, 243, 12)];
	
	[demoView addSubview:self.username];
	[demoView addSubview:self.password];
	[demoView addSubview:registerBtn];
	[demoView addSubview:passwordBtn];
	[demoView addSubview:noticeLabel];
	return demoView;
}
-(void)addTimeBtn{
	[self.alertView close];
	superLinkViewController *superLink = [[superLinkViewController alloc]init];
	[self presentViewController:superLink animated:YES completion:^{
		NSLog(@"点击增加时长");
   
		
	}];
}
//注册按钮
-(void)registerBtn{
	NSLog(@"点击了注册按钮");
    if(_username.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.username.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }
    if(_password.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.password.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }
	//SessionPOST请求
	[self sessionPost];
	
}
//注册POST请求
-(void)sessionPost{
	NSString *Strurl = @"http://go.jummy.top/api/user/";
	NSString *nameStr = [NSString stringWithFormat:@"%@",self.username.text];


	NSString *passwordStr = [NSString stringWithFormat:@"%@",self.password.text];
	NSDictionary *paramDict = @{@"username":nameStr,
								@"password":passwordStr,
                                @"system":@"1",
                                @"region":self.registerCity,
								@"type":@"JSON"
								};
	[networktool post:Strurl params:paramDict success:^(id  _Nonnull responseObj) {
		NSLog(@"请求成功");
		
		NSLog(@"*****%@",responseObj);
		//解析数据
		NSLog(@"打印结果--%@",responseObj[@"result"]);
		if([responseObj[@"result"] isEqualToString:@"已经有这个用户了"]){
			[SVProgressHUD showErrorWithStatus:@"用户已经存在"];
			[SVProgressHUD dismissWithDelay:0.8];
		}else{
			[self.alertView close];
			[SVProgressHUD showSuccessWithStatus:@"注册成功"];
			[SVProgressHUD dismissWithDelay:0.8];
		}
	} failure:^(NSError * _Nonnull error) {
		NSLog(@"请求失败");
	}];
}
//登录按钮
-(void)loginBtn:(NSString *)account password:(NSString *)password{
	NSLog(@"点击了登录按钮");
    
	[[AFNetworkReachabilityManager sharedManager] startMonitoring];
	//[self.alertView close];
    //如果用户名与密码输入为空，返回输入
	if(_username.text.length == 0){
		[SVProgressHUD showErrorWithStatus:self.username.placeholder];
		[SVProgressHUD dismissWithDelay:0.7];
		return;
	}
    if(_password.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.password.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }

	//POST请求登录：
	NSString *Strurl = @"http://go.jummy.top/api/user/login";
	NSString *nameStr = [NSString stringWithFormat:@"%@",self.username.text];
	NSString *passwordStr = [NSString stringWithFormat:@"%@",self.password.text];
	NSDictionary *paramDict = @{@"username":nameStr,
								@"password":passwordStr,
								@"type":@"JSON"
								};
           //栅栏函数
            //获取全局并发队列
            //栅栏函数不能使用全局并发队列
    //        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t queue = dispatch_queue_create("downloadeee", DISPATCH_QUEUE_CONCURRENT);

            //异步函数
            dispatch_async(queue, ^{
                NSLog(@"Homeview--------%@",[NSThread currentThread]);
    //            [homeVCController updateCommentLabel];
                //Swift方法连接VPN
               
            });
            dispatch_async(queue, ^{
                NSLog(@"download2--------%@",[NSThread currentThread]);
               
            });
            //栅栏函数
            dispatch_barrier_async(queue, ^{
           
                NSLog(@"OC保存配置");
            });
    
	[networktool post:Strurl params:paramDict success:^(id  _Nonnull responseObj) {
		NSLog(@"登录成功");
		NSLog(@"*****%@",responseObj);
		//解析数据
		[SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
		[SVProgressHUD dismissWithDelay:0.8];
		[self.alertView close];
        
        //存储Token
        NSString *dictArr22 = responseObj[@"data"][@"token"];
        NSLog(@"token的值是:%@",dictArr22);
        
    
//        NSDictionary *dict = [NSDictionary mj_objectArrayWithKeyValuesArray:dictArr];
        
        

        dispatch_async(dispatch_get_main_queue(), ^{
            [self timeout];
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HomeViewController2 alloc] connectButtonTapped2];
        });
        
        //记录用户登录状态
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.username.text forKey:@"name"];
        [userDefaults setObject:self.password.text forKey:@"password"];
        [userDefaults setObject:dictArr22 forKey:@"tokenStr"];
        [userDefaults synchronize];
//            dispatch_async(queue, ^{
//        NSLog(@"download3--------%@",[NSThread currentThread]);
//        });
//        //栅栏函数
//            dispatch_barrier_async(queue, ^{
//        NSLog(@"---------------------%@",[NSThread currentThread]);
//        [homeVCController connectButtonTapped];
//                NSLog(@"点击连接");
//        });
                
	} failure:^(NSError * _Nonnull error) {
		NSLog(@"请求失败");
//        [SVProgressHUD showErrorWithStatus:@"密码或用户名不正确"];
//        [SVProgressHUD dismissWithDelay:0.8];
	}];
}
//增加时长按钮跳转页面
- (IBAction)addTimeBtnView:(id)sender {
	
	superLinkViewController *superLinkVc = [[superLinkViewController alloc]init];
    [self presentViewController:superLinkVc animated:YES completion:nil];
}
- (IBAction)onBtn:(id)sender {
	NSLog(@"点击了开关按钮");
    //开启定位服务功能
    [self.manager startUpdatingLocation];
    //判断用户是否登录了
      NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
      NSString *name = [userDefault objectForKey:@"name"];
      if(name == nil){
          NSLog(@"用户未登录");
          [self loginRegisterAlert];
      }else{
          [self buyAlert];
         
	}
}

//注销账号按钮
- (IBAction)logoutBtn:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];
    [self loginRegisterAlert];
    
    self.shoumiNS = 0;
    NSLog(@"注销了账号");
    
                      
}
//点击连接按钮
- (IBAction)clickLink:(id)sender {
   //
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//         HomeViewController2 *homeVCController = [[HomeViewController2 alloc] init];
//              [self presentViewController:homeVCController animated:YES completion:^{
//                  NSLog(@"点击弹出VPN连接");
//              }];
//    });
  
}
//深夜福利
- (IBAction)nightWelfareBtn:(id)sender {
    NSLog(@"点击了深夜福利按钮");
    deepNightController *deepNightVc = [[deepNightController alloc] init];
    
    [self presentViewController:deepNightVc animated:YES completion:^{
        NSLog(@"进入了深夜福利");
    }];

    //方法二
//    pupView *pup = [[pupView alloc]init];
//    [pup showInView];
//     [self.view addSubview:self.myView];
    

}
-(pupView *)myView{
    pupView *myView=[[pupView alloc]initWithFrame:CGRectMake( 50 ,-MJSSreenH/4,MJSSreenW/2, MJSSreenH/2)];
    myView.backgroundColor=[UIColor orangeColor];
    myView.layer.cornerRadius=27;
    
    //调用块
    myView.clickTapBlock=^{
        NSString *urlStr = @"https://www.baidu.com";
        NSURL *url = [NSURL URLWithString:urlStr];
         SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:safariVc animated:YES completion:nil];
    };
    _myView = myView;
    return _myView;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    [manager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         for (CLPlacemark *place in placemarks) {
//           NSLog(@"name,%@",place.name);                       // 位置名
//           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
//           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
             NSLog(@"%@",place.locality);//市
//           NSLog(@"subLocality,%@",place.subLocality);         // 区
//           NSLog(@"country,%@",place.country);                 // 国家

//             if ([JudgeIDAndBankCard isEmptyOrNull:place.locality]) {
//                 _gpsCityName=@"定位失败";
//             }
//             WRITE_DATA(place.locality, @"CITY_JC_NAME");
             
            self.registerCity = place.locality;
             NSLog(@"%@",self.registerCity);
    }
    }];
}
@end
