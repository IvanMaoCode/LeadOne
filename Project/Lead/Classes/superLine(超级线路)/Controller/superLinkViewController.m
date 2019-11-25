//
//  superLinkViewController.m
//  Canbee
//
//  Created by Kluth on 2019/11/1.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import "superLinkViewController.h"
#import "loginRegisterViewController.h"
#import "insallAppViewController.h"
#import "SVProgressHUD.h"
#import "shareInfoViewController.h"
#import "networktool.h"
#import "MJExtension.h"
#import "SafariServices/SafariServices.h"

#import "billClass.h"
@class billClass;
@interface superLinkViewController ()<CustomIOSAlertViewDelegate>
@property(nonatomic,strong) billClass *item;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
//@property (weak, nonatomic) IBOutlet UIButton *linkBtn;
//@property (weak, nonatomic) IBOutlet UIButton *btn1;
//@property (weak, nonatomic) IBOutlet UIButton *btn2;
//@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmenView;

@property (nonatomic,strong) UIView *addView;
//选择按钮
@property(nonatomic,assign)NSInteger buttonSelect;
//改变字符串
@property(nonatomic,strong)NSString *Str;
//提醒用户登录弹窗
@property(nonatomic,strong) CustomIOSAlertView *alertView;
@property(nonatomic,strong) CustomIOSAlertView *alertView1;
@property(nonatomic,strong) NSString *payId;

@end
    static NSString *length;
    static NSString *priceBill;
    static NSString *sharePriceBill;

    static NSString *length1;
    static NSString *priceBill1;
    static NSString *sharePriceBill1;

    static NSString *length2;
    static NSString *priceBill2;
    static NSString *sharePriceBill2;
@implementation superLinkViewController
- (void)setItem:(billClass *)item{
    _item = item;
   
    NSString *lengStr = item.length;
    NSString *price = item.price;
    NSString *sharePrice = item.share;
  
}
//- (NSInteger)buttonSelect{
//	if(!_buttonSelect){
//		NSInteger buttonSelect = 0;
//		_buttonSelect = buttonSelect;
//	}
//	return _buttonSelect;
//}
static NSString *const MJSTopicCellId = @"MJSTopicCellId";
//- (CustomIOSAlertView *)alertView{
//	if(_alertView == nil){
//		CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
//		_alertView = alertView;
//	}
//	return _alertView;
//}
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	self.segmenView.layer.borderWidth = 1;
	self.segmenView.backgroundColor = [UIColor clearColor];
    [self.segmenView setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
	//	self.segmenView.tintColor = [UIColor whiteColor];
	self.segmenView.layer.borderColor = [[UIColor whiteColor] CGColor];
	self.segmenView.layer.cornerRadius = 4.5;
	//设置选中颜色
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
	[self.segmenView setTitleTextAttributes:dic forState:UIControlStateSelected];
	//	//设置默认颜色
	NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
	[self.segmenView setTitleTextAttributes:dics forState:UIControlStateNormal];
	
//	self.linkBtn.mjs_width = 100;
//	self.linkBtn.layer.borderWidth = 1;
//	self.linkBtn.layer.borderColor = [[UIColor yellowColor] CGColor];
//	self.linkBtn.layer.cornerRadius = 14.5;
//
//	self.btn1.layer.borderWidth = 1;
//	self.btn1.layer.borderColor = [[UIColor colorWithRed:108/255.0 green:167/255.0 blue:47/255.0 alpha:1] CGColor ];
//	self.btn1.layer.cornerRadius = 12.3;
//	[self.btn1 addTarget:self action:@selector(allert) forControlEvents:UIControlEventTouchUpInside];
//
//	self.btn2.layer.borderWidth = 1;
//	self.btn2.layer.borderColor = [[UIColor colorWithRed:196/255.0 green:170/255.0 blue:106/255.0 alpha:1] CGColor ];
//	self.btn2.layer.cornerRadius = 12.3;
//	self.btn2.backgroundColor = [UIColor colorWithRed:196/255.0 green:170/255.0 blue:106/255.0 alpha:1];
//	[self.btn2 addTarget:self action:@selector(allert) forControlEvents:UIControlEventTouchUpInside];
//	[self.btn2 setTag:1];
//
//
//	self.btn.layer.borderWidth = 1;
//	self.btn.layer.borderColor = [[UIColor colorWithRed:108/255.0 green:167/255.0 blue:47/255.0 alpha:1] CGColor ];
//	self.btn.layer.cornerRadius = 12.3;
//	[self.btn addTarget:self action:@selector(allert) forControlEvents:UIControlEventTouchUpInside];
//
	//设置打开页面默认为黄金线路
	[self addnewView];
    
    
       
           //GET 请求套餐
             NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
             NSString *tokenStr = [userDefault objectForKey:@"tokenStr"];
             NSString *Strurl = @"http://go.jummy.top/like/";
             NSDictionary *parameters = @{
               @"type":@"JSON"
           };
            
                  //栅栏函数
                   //获取全局并发队列
                   //栅栏函数不能使用全局并发队列
           //        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
              dispatch_group_t group = dispatch_group_create();

           //异步函数
       //  dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
           [networktool get:Strurl params:parameters success:^(id  _Nonnull responseObj) {
               NSLog(@"请求成功%@",responseObj[@"data"]);
               NSArray *dict = [NSArray mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
               NSLog(@"%@",dict[0][@"price"]);
               NSLog(@"%@",dict[0][@"share"]);
               NSLog(@"%@length:",dict[0][@"length"]);
               priceBill = dict[0][@"price"];
               sharePriceBill = dict[0][@"share"];
               length = dict[0][@"length"];
               
               priceBill1 = dict[1][@"price"];
               sharePriceBill1 = dict[1][@"share"];
               length1 = dict[1][@"length"];
               
               priceBill2 = dict[2][@"price"];
               sharePriceBill2 = dict[2][@"share"];
               length2 = dict[2][@"length"];
               
           } failure:^(NSError * _Nonnull error) {
               NSLog(@"请求失败");
           }];
}
//点击热门开通按钮
-(void)allert{
	self.buttonSelect = 1;
	NSLog(@"点击了热门开通按钮");
	//如果用户没有登录提醒用户登录
    //判断用户是否登录了
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if(name == nil){
        [self loginAllert];
    }else{
        NSLog(@"已经登录直接购买");
    }
}
//点击复制链接按钮
//- (IBAction)copyLinkBtn:(id)sender {
//    //判断用户是否已经登录
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *name = [userDefault objectForKey:@"name"];
//    if(name == nil){
//        [self.linkBtn setTag:2];
//        self.buttonSelect = 2;
//        [self loginAllert];
//    }else{
//        NSLog(@"复制了链接");
//        
//        UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
//        pastboard.string = @"2222";
//        [SVProgressHUD showSuccessWithStatus:@"复制成功"];
//              [SVProgressHUD dismissWithDelay:0.8];
//    }
//}
#pragma - mark CustomIOSAlertViewDelegate
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
	NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
	[alertView close];
}
-(void)loginAllert{
	// Here we need to pass a full frame
	// Add some custom content to the alert view
	[self.alertView setContainerView:[self loginBtnView]];
	
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
-(UIView *)loginBtnView{
	UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 243, 153)];
	//	demoView.backgroundColor = [UIColor grayColor];
	demoView.layer.borderWidth = 0;
	demoView.layer.cornerRadius = 1.4;
	if(self.buttonSelect == 1){
	self.Str = @"需要登陆后才能购买";
	}else{
		self.Str = @"需要登录后才能复制";
	}
	UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(243/2-76, 40, 200, 13.5)];
	noticeLabel.text = self.Str;
	
	UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(243/2-91/2, 100, 91, 36)];
	[loginBtn setImage:[UIImage imageNamed:@"loginNow2x"] forState:UIControlStateNormal];
	[loginBtn addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchUpInside];
	
	
	[demoView addSubview:loginBtn];
	[demoView addSubview:noticeLabel];
	return demoView;
}
//点击登录按钮跳转到登录页面
-(void)loginView{
    NSLog(@"立即登录按钮");
    //关闭弹窗
    [self.alertView1 close];
//    [testAlert clos]
	loginRegisterViewController *loginVc = [[loginRegisterViewController alloc] init];
	
	[self presentViewController:loginVc animated:YES completion:^{
		NSLog(@"跳转到登录页面");
	}];
}
- (IBAction)superLinjkViewback:(id)sender {
	
//	[self.navigationController popoverPresentationController];
	[self dismissViewControllerAnimated:YES completion:^{
		NSLog(@"关闭当前窗口完成");
	}];

}
- (IBAction)changesegment:(id)sender {
	switch ([(UISegmentedControl *)sender selectedSegmentIndex]) {
		case 1:
			NSLog(@"点击了超级线路");
			[self.addView removeFromSuperview];
            //自定义超级线路视图
            [self userdefinView];
            [self shareInfoView];
			break;
		case 0:
			
            NSLog(@"点击了黄金线路");
//			[self alertbuy];
			[self addnewView];
			break;
			
		default:
			break;
	}
}
//套餐视图
#define PriceViewW 320
#define PriceViewH 250
#define ButtonH 32
#define ButtonW 70
//套餐视图
-(void)userdefinView{
  
    
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:Strurl]];
//        [request setValue:tokenStr forHTTPHeaderField:@"token"];
//
//        request.HTTPMethod = @"GET";
//        NSString *parameterStr = [NSString stringWithFormat:@"type=JSON"];
//        request.HTTPBody = [parameterStr dataUsingEncoding:NSUTF8StringEncoding];
//        //栅栏函数
//    //     dispatch_queue_t queue =  dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
//
//        //3.创建会话
//        NSURLSession *session = [NSURLSession sharedSession];
//        //4.创建task
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            //解析数据
//            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
////            NSDictionary *dictPay = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    //      NSDictionary *dataDict = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    //      NSString *payStr = dataDict[@"data"];
////            NSLog(@"请求token成功:%@",dictPay[@"data"][@"url"]);
//        }];
//        //5.执行Task
//        [dataTask resume];

    //栅栏函数
            
//       dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
    
    UIColor *borderColor = MJSColor(166, 166, 166);
    UIView *PriceView = [[UIView alloc] initWithFrame:CGRectMake((MJSSreenW - PriceViewW)/2, 110, PriceViewW, PriceViewH)];
    PriceView.layer.borderWidth = 0.7;
    PriceView.layer.borderColor = [[UIColor grayColor] CGColor];

    //添加时长，原价，分享价格label
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, PriceViewW / 4, PriceViewH/5)];
    timeLabel.text = @"   时长";
    [PriceView addSubview:timeLabel];
    
    UILabel *oringinPrice = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4, 0, PriceViewW / 4, PriceViewH/5)];
    oringinPrice.text = @"原价";
     [PriceView addSubview:oringinPrice];
    
    UILabel *sharePrice = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4*2, 0, PriceViewW / 4, PriceViewH/5)];
//    sharePrice.text = @"分享价\n(八折)";
    [PriceView addSubview:sharePrice];
    
    UILabel *sharePrice2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, PriceViewW / 4, PriceViewH/5/2)];
    sharePrice2.text = @"分享价";
    [sharePrice addSubview:sharePrice2];
    UILabel *sharePrice3 = [[UILabel alloc] initWithFrame:CGRectMake(0, PriceViewH/5/2, PriceViewW / 4, PriceViewH/5/2)];
    sharePrice3.text = @"(八折)";
    [sharePrice3 setTextColor:[UIColor redColor]];
    [sharePrice addSubview:sharePrice3];
    
    //时长为1个月套餐的视图
    UILabel *oneMonthVc = [[UILabel alloc]initWithFrame:CGRectMake(0, PriceViewH / 5,  PriceViewW / 4, PriceViewH/5)];
    int intLength = [length intValue];
    NSString *stringInt = [NSString stringWithFormat:@" %d个月", intLength / 60 / 60 / 24 /30];
    oneMonthVc.text = stringInt;
    [PriceView addSubview:oneMonthVc];
    
    UILabel *oneMonthPriceVc = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4, PriceViewH / 5,  PriceViewW / 4, PriceViewH/5)];
    
      oneMonthPriceVc.text =[NSString stringWithFormat:@"%@元", priceBill];
      [PriceView addSubview:oneMonthPriceVc];
    
    UILabel *oneMonthPriceVc2 = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4*2, PriceViewH / 5,  PriceViewW / 4, PriceViewH/5)];
         oneMonthPriceVc2.text =[NSString stringWithFormat:@"%@元", sharePriceBill];;
         [PriceView addSubview:oneMonthPriceVc2];
    
    //时长为3个月套餐的视图
      UILabel *threeMonthVc = [[UILabel alloc]initWithFrame:CGRectMake(0, PriceViewH / 5*2,  PriceViewW / 4, PriceViewH/5)];
    int intLength1 = [length1 intValue];
    NSString *stringInt1 = [NSString stringWithFormat:@" %d个月", intLength1 / 60 / 60 / 24 /30];
    threeMonthVc.text = stringInt1;
    threeMonthVc.backgroundColor =  MJSColor(247, 241, 210);
      [PriceView addSubview:threeMonthVc];
      
      UILabel *threeMonthPriceVc = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4, PriceViewH / 5*2,  PriceViewW / 4, PriceViewH/5)];
        threeMonthPriceVc.text = [NSString stringWithFormat:@"%@元", priceBill1];;
        threeMonthPriceVc.backgroundColor =  MJSColor(247, 241, 210);
        [PriceView addSubview:threeMonthPriceVc];
      
      UILabel *threeMonthPriceVc2 = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4*2, PriceViewH / 5*2,  PriceViewW / 4, PriceViewH/5)];
           threeMonthPriceVc2.text = [NSString stringWithFormat:@"%@元", sharePriceBill1];
            threeMonthPriceVc2.backgroundColor =  MJSColor(247, 241, 210);
           [PriceView addSubview:threeMonthPriceVc2];
      UIView *threeMonthPriceVc2right = [[UIView alloc] initWithFrame:CGRectMake(PriceViewW/4*3, PriceViewH / 5*2,  PriceViewW / 4, PriceViewH/5)];
    threeMonthPriceVc2right.backgroundColor =  MJSColor(247, 241, 210);
    [PriceView addSubview:threeMonthPriceVc2right];
    //开通按钮1
         UIColor *textColor = MJSColor(82, 173, 51);
        UIButton *oneButton =[[UIButton alloc] initWithFrame:CGRectMake(PriceViewW/4*3, PriceViewH / 5 + (PriceViewH / 5 - ButtonH)/2, ButtonW, ButtonH)];
        oneButton.layer.borderWidth = 2;
        oneButton.layer.borderColor = [[UIColor colorWithRed:82/255.0 green:173/255.0 blue:51/255.0 alpha:1.0f] CGColor];
        oneButton.layer.cornerRadius = 15.3;
        [oneButton setTitle:@"开通" forState:UIControlStateNormal];
        [oneButton setTitleColor:textColor forState:UIControlStateNormal];
        [oneButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        oneButton.tag  = 1;
        [oneButton addTarget:self action:@selector(openServe1) forControlEvents:UIControlEventTouchUpInside];
        [PriceView addSubview:oneButton];
    
        //开通按钮2
        UIButton *twoButton =[[UIButton alloc] initWithFrame:CGRectMake(PriceViewW/4*3, PriceViewH / 5 + (PriceViewH / 5 - ButtonH)/2 + PriceViewH/5, ButtonW, ButtonH)];
    //       twoButton.layer.borderWidth = 1;
    //       twoButton.layer.borderColor = [[UIColor greenColor] CGColor];
        twoButton.backgroundColor =[UIColor colorWithRed:249/255.0 green:215/255.0 blue:135/255.0 alpha:1.0f];
           twoButton.layer.cornerRadius = 15.3;
           [twoButton setTitle:@"开通" forState:UIControlStateNormal];
           [twoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           [twoButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
     [twoButton addTarget:self action:@selector(openServe2) forControlEvents:UIControlEventTouchUpInside];
           [PriceView addSubview:twoButton];
        //开通按钮3
           UIButton *threeButton =[[UIButton alloc] initWithFrame:CGRectMake(PriceViewW/4*3, PriceViewH / 5 + (PriceViewH / 5 - ButtonH)/2 + PriceViewH/5*2, ButtonW, ButtonH)];
              threeButton.layer.borderWidth = 2;
              threeButton.layer.borderColor = [[UIColor colorWithRed:82/255.0 green:173/255.0 blue:51/255.0 alpha:1.0f] CGColor];
              threeButton.layer.cornerRadius = 15.3;
              [threeButton setTitle:@"开通" forState:UIControlStateNormal];
           
              [threeButton setTitleColor:textColor forState:UIControlStateNormal];
              [threeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
     [threeButton addTarget:self action:@selector(openServe3) forControlEvents:UIControlEventTouchUpInside];
              [PriceView addSubview:threeButton];
    //时长为6个月套餐的视图
        UILabel *sixMonthVc = [[UILabel alloc]initWithFrame:CGRectMake(0, PriceViewH / 5*3,  PriceViewW / 4, PriceViewH/5)];
    int intLength2 = [length2 intValue];
    NSString *stringInt2 = [NSString stringWithFormat:@" %d个月", intLength2 / 60 / 60 / 24 /30];
        sixMonthVc.text = stringInt2;
        [PriceView addSubview:sixMonthVc];
        
        UILabel *sixMonthPriceVc = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4, PriceViewH / 5*3,  PriceViewW / 4, PriceViewH/5)];
          sixMonthPriceVc.text = [NSString stringWithFormat:@"%@元",priceBill2];
          [PriceView addSubview:sixMonthPriceVc];
        
        UILabel *sixMonthPriceVc2 = [[UILabel alloc]initWithFrame:CGRectMake(PriceViewW/4*2, PriceViewH / 5*3,  PriceViewW / 4, PriceViewH/5)];
             sixMonthPriceVc2.text = [NSString stringWithFormat:@"%@元",sharePriceBill2];
             [PriceView addSubview:sixMonthPriceVc2];
    
    //解说视图
    // 改变字体大小
    NSString *Str = @"            分享链接超过5次点击按分享价购买\n              超过10次点击买几个月送几个月！";
      NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:Str];
         //段落样式
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
      [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,Str.length)];
      // 改变颜色
      [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, Str.length)];
     //换行
//    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,Str.length)];
    
    UILabel *guideVc = [[UILabel alloc]initWithFrame:CGRectMake(0, PriceViewH / 5*4, PriceViewW,PriceViewH / 5)];
    guideVc.attributedText = attributeStr;
    guideVc.numberOfLines = 2;
    guideVc.backgroundColor = MJSColor(255, 235, 235);
    [PriceView addSubview:guideVc];
    
    
    [self.view addSubview:PriceView];
  
}

#define shareViewW 320
#define shareViewH 230
//复制链接视图
-(void)shareInfoView{
    
    UIView *shareInfoView = [[UIView alloc] initWithFrame:CGRectMake((MJSSreenW - shareViewW)/2, 380, shareViewW, shareViewH)];
    shareInfoView.backgroundColor = [UIColor colorWithRed:80/255.0 green:202/255.0 blue:249/255.0 alpha:1.0];
    [self.view addSubview:shareInfoView];
    
    UILabel *shareInfoTitle = [[UILabel alloc]initWithFrame:CGRectMake((shareViewW - 80)/2, 15, 80, 14)];
    [shareInfoTitle setText:@"分享信息"];
    [shareInfoTitle setTextColor:[UIColor whiteColor]];
    [shareInfoView addSubview:shareInfoTitle];
    
    UILabel *sharelink = [[UILabel alloc]initWithFrame:CGRectMake(60, 55, 80, 14)];
       [sharelink setText:@"分享链接"];
       [sharelink setTextColor:[UIColor whiteColor]];
       
       [shareInfoView addSubview:sharelink];
    //复制按钮
    UIButton *copyLinkButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 45, 80, 33)];
    [copyLinkButton setTitle:@"复制链接" forState:UIControlStateNormal];
    [copyLinkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [copyLinkButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [copyLinkButton setTintColor:[UIColor blackColor]];
    copyLinkButton.layer.borderWidth = 1;
    copyLinkButton.layer.cornerRadius = 13.4;
    [copyLinkButton addTarget:self action:@selector(countClicks) forControlEvents:UIControlEventTouchUpInside];
    [shareInfoView addSubview:copyLinkButton];
    //点击链接次数
    UILabel *clickShareCount = [[UILabel alloc]initWithFrame:CGRectMake(60, 90, 130, 14)];
          [clickShareCount setText:@"链接点击次数:0"];
          [clickShareCount setTextColor:[UIColor whiteColor]];
          [shareInfoView addSubview:clickShareCount];
    //图标
    UIImage *image1 = [UIImage imageNamed:@"triangle"];
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(12, 130, 10, 10);
    imageView1.image = image1;
    [shareInfoView addSubview:imageView1];
    
    UIImage *image2 = [UIImage imageNamed:@"triangle"];
       UIImageView *imageView2 = [[UIImageView alloc] init];
       imageView2.frame = CGRectMake(12, 160, 10, 10);
       imageView2.image = image2;
       [shareInfoView addSubview:imageView2];
    
    //解释label
    NSString *guild1Str = @"复制链接后，通过QQ和微信分享给好友或群";
     NSString *guild1Str2 = @"点击次数超过5次按分享价购买，超过10次";
    NSString *guildStr3 = @"买几个月就送几个月!";
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:guild1Str];
            //段落样式
//       NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//       paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
         [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,guild1Str.length)];
         // 改变颜色
         [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, guild1Str.length)];
    UILabel *guild1Strlabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 130, 300, 10)];
    guild1Strlabel.attributedText = attributeStr;
    [shareInfoView addSubview:guild1Strlabel];
    
    
    NSMutableAttributedString *attributeStr2 = [[NSMutableAttributedString alloc] initWithString:guild1Str2];
    [attributeStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,guild1Str2.length)];
    [attributeStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, guild1Str2.length)];
    UILabel *guild1Strlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(22, 160, 300, 10)];
       guild1Strlabel2.attributedText = attributeStr2;
       [shareInfoView addSubview:guild1Strlabel2];
    
    NSMutableAttributedString *attributeStr3 = [[NSMutableAttributedString alloc] initWithString:guildStr3];
       [attributeStr3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,guildStr3.length)];
       [attributeStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, guildStr3.length)];
       UILabel *guildStr33 = [[UILabel alloc] initWithFrame:CGRectMake(22, 180, 300, 10)];
          guildStr33.attributedText = attributeStr3;
          [shareInfoView addSubview:guildStr33];
    
}
//解说说明视图
-(void)addnewView{
	self.addView = [[UIView alloc]initWithFrame:CGRectMake(0,93.5, MJSSreenW, MJSSreenH - 93.5)];
	self.addView.backgroundColor = MJSColor(248, 248, 248);
	//解锁免费使用
	UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake(MJSSreenW/2 - 85.5, 80, 171, 65)];
	openBtn.layer.cornerRadius = 10.5;
	openBtn.backgroundColor = [UIColor clearColor];
	[openBtn setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
	[self.addView addSubview:openBtn];
	[openBtn addTarget:self action:@selector(openBtn) forControlEvents:UIControlEventTouchUpInside];
	
	//解锁说明布局
	UIView *instuctView = [[UIView alloc] initWithFrame:CGRectMake(MJSSreenW/2 - 135.5, 180, 271, 346)];
	instuctView.layer.borderWidth = 0.4;
	instuctView.layer.cornerRadius = 7.5;
	
	UILabel *instructLabel = [[UILabel alloc] initWithFrame:CGRectMake(MJSSreenW/2 - 148.5/2 , 230, 148.5, 12)];
	instructLabel.text = @"这里是解锁说明";
	[self.addView addSubview:instructLabel];
	[self.addView addSubview:instuctView];
	[self.view addSubview:self.addView];
}

-(void)openBtn{
	insallAppViewController *installAppVc = [[insallAppViewController alloc]init];
	
	[self presentViewController:installAppVc animated:YES completion:^{
		NSLog(@"点击了解锁");
	}];
	NSLog(@"点击了按钮");
}
//计算链接点击次数
-(void)countClicks{
     self.buttonSelect = 2;
    //判断用户是否登录了
       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
       NSString *name = [userDefault objectForKey:@"name"];
       if(name == nil){
           [self testAlert];
       }else{
    NSLog(@"点击了复制链接按钮");
           
    
    NSString *CopyStr = @"http://go.jummy.top/api/user/share/add.do";
    NSString *tokenStr = [userDefault objectForKey:@"tokenStr"];
//    NSString *nameStr = [NSString stringWithFormat:@"%@",self.username.text];
//    NSString *passwordStr = [NSString stringWithFormat:@"%@",self.password.text];
    NSDictionary *paramDict = @{@"share_id":@"11",
                                @"type":@"JSON"
    };
               //POST请求复制数据
//    [networktool post:Strurl params:paramDict success:^(id  _Nonnull responseObj) {
//        NSLog(@"请求成功");
//
//
//
//        UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
//               pastboard.string = @"2222";
//               [SVProgressHUD showSuccessWithStatus:@"复制成功"];
//                     [SVProgressHUD dismissWithDelay:0.8];
//        NSLog(@"*****%@",responseObj);
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"请求失败");
//    }];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:CopyStr]];
        [request setValue:tokenStr forHTTPHeaderField:@"token"];
        request.HTTPMethod = @"POST";
        NSString *parameterStr = [NSString stringWithFormat:@"share_id=34&type=JSON"];
        request.HTTPBody = [parameterStr dataUsingEncoding:NSUTF8StringEncoding];
       
        NSURLSession *session = [NSURLSession sharedSession];
           
           NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
               //解析数据
               NSLog(@"全部数据%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
               NSDictionary *dictCopy = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
               
               NSLog(@"请求成功domain%@",dictCopy[@"data"][@"id"]);
             
               
               
            [SVProgressHUD showSuccessWithStatus:@"复制成功"];
            [SVProgressHUD dismissWithDelay:0.8];
           }];
           //5.执行Task
        [dataTask resume];
    }
}
static BOOL uerDefaultData(){
      //判断用户是否登录了
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
     NSString *name = [userDefault objectForKey:@"name"];
    if(name == nil){
        return NO;
    }else{
        return YES;
    }
    
}
//开通按钮1
-(void)openServe1{
    
    //用户发起订单GET请求拿到ID
    NSString *Strurl1 = @"http://go.jummy.top/pay/";
//    NSString *nameStr = [NSString stringWithFormat:@"%@",self.username.text];
//    NSString *passwordStr = [NSString stringWithFormat:@"%@",self.password.text];
    NSDictionary *paramDict11 = @{
                                @"type":@"JSON"
                                };
    [networktool get:Strurl1 params:paramDict11 success:^(id  _Nonnull responseObj) {
        NSLog(@"查询码支付配置请求成功");
        
        NSLog(@"*****%@",responseObj);
        NSArray *array = responseObj[@"data"];
//        NSDictionary *dictPay = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        NSArray *dictPay = [NSArray mj_objectArrayWithKeyValuesArray:array];
        //拿到配置id
//        NSLog(@"配置ID%@",dictPay[@"pay_id"]);
      
        //解析数据
        NSLog(@"查询码支付配置请求成功打印结果--%@",dictPay[0][@"id"]);
        
        self.payId = dictPay[0][@"id"];
        
        NSLog(@"%@",self.payId);
          NSLog(@"self.PayID %@",self.payId);
        //用户发起订单
        [self sendBill:self.payId];
    } failure:^(NSError * _Nonnull error) {
         NSLog(@"请求失败");
    }];
 
   //用户发起支付订单
//    [self sendBill];
    
}
-(void)sendBill:(NSString *)payId{
    //用户发起支付
        //判断用户是否登录了
        NSLog(@"点击开通按钮1");
        self.buttonSelect = 1;
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *name = [userDefault objectForKey:@"name"];
        if(name == nil){
            [self loginAllert];
        }
        NSString *tokenStr = [userDefault objectForKey:@"tokenStr"];
        NSLog(@"订单的Token:%@",tokenStr);
        NSString *ContentType = @"application/x-www-form-urlencoded";
        //POST请求开通一个月
        NSString *Strurl = @"http://go.jummy.top/api/order/add.do";
//        NSDictionary *paramDict = @{
//            @"pay_id":@1,
//            @"price":@1.00,
//            @"line_id":@1,
//            @"type":@"JSON"
//        };
//        NSDictionary *paramDictHeader = @{
//            @"token":tokenStr,
//            @"Content-Type":ContentType
//        };
    //    [networktool postTokenpost:Strurl params:paramDict header:paramDictHeader success:^(id  _Nonnull responseObj) {
    //        NSLog(@"请求成功");
    //       NSLog(@"*****%@",responseObj);
    //    } failure:^(NSError * _Nonnull error) {
    //        NSLog(@"请求失败");
    //    }];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:Strurl]];
        [request setValue:tokenStr forHTTPHeaderField:@"token"];
        [request setValue:ContentType forHTTPHeaderField:@"Content-Type"];
        request.HTTPMethod = @"POST";
        NSString *parameterStr = [NSString stringWithFormat:@"pay_id=%@&price=1.00&line_id=1&type=JSON",payId];
        request.HTTPBody = [parameterStr dataUsingEncoding:NSUTF8StringEncoding];
        //栅栏函数
    //     dispatch_queue_t queue =  dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
        
        //3.创建会话
        NSURLSession *session = [NSURLSession sharedSession];
        //4.创建task
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //解析数据
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSDictionary *dictPay = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //      NSDictionary *dataDict = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //      NSString *payStr = dataDict[@"data"];
            NSLog(@"请求token成功:%@",dictPay[@"data"][@"url"]);
            //跳转网页
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //跳转支付页面
                    NSString *PriceStr = dictPay[@"data"][@"url"];
                    NSURL *url = [NSURL URLWithString:PriceStr];
                    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
                    [self presentViewController:safariVc animated:YES completion:nil];
                 });
        }];
        //5.执行Task
        [dataTask resume];
    //   CFRunLoopStop(CFRunLoopGetMain());
}
-(void)openServe2{
    //判断用户是否登录了
    NSLog(@"点击开通按钮2");
    self.buttonSelect = 1;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if(name == nil){
        [self loginAllert];
    }
}
-(void)openServe3{
    
    //判断用户是否登录了
    NSLog(@"点击开通按钮3");
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if(name == nil){
        [self testAlert];
//        [self addAlertView];
//        [self loginAllert];
    }
    
}
-(void)testAlert{
      self.alertView1 = [[CustomIOSAlertView alloc] initWithParentView:self.view];
      [self.alertView1 setContainerView:[self loginBtnView]];
//      [alertView1 setButtonTitles:[NSMutableArray arrayWithObjects:@"立即更新", @"以后再说", nil]];
      [self.alertView1 setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", nil]];
      [self.alertView1 setDelegate:self];
      [self.alertView1 setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
//      [alertView1 close];
      }];
      [self.alertView1 setUseMotionEffects:true];
      [self.alertView1 show];
}
-(void)testAlert2{
      CustomIOSAlertView *alertView2 = [[CustomIOSAlertView alloc] initWithParentView:self.view];
      [alertView2 setContainerView:[self loginBtnView]];
//      [alertView1 setButtonTitles:[NSMutableArray arrayWithObjects:@"立即更新", @"以后再说", nil]];
      [alertView2 setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", nil]];
      [alertView2 setDelegate:self];
      [alertView2 setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
//      [alertView1 close];
      }];
      [alertView2 setUseMotionEffects:true];
      [alertView2 show];
}
//假的弹窗
#define alertW 243
#define alertH 200
-(void)addAlertView{
    UIView *AlertView = [[UIView alloc] initWithFrame:CGRectMake((MJSSreenW - alertW)/2, (MJSSreenH - alertH)/2, alertW, alertW)];
    AlertView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:AlertView];
}
@end
