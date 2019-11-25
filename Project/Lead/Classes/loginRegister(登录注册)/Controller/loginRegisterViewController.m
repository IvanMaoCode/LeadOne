//
//  loginRegisterViewController.m
//  Canbee
//
//  Created by Kluth on 2019/10/31.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import "loginRegisterViewController.h"
#import "SVProgressHUD.h"
#import "networktool.h"
@interface loginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *loginLogo;
@property (weak, nonatomic) IBOutlet UIView *idAcount;
@property (weak, nonatomic) IBOutlet UIView *password;
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UITextField *IdAccountInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

@end

@implementation loginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingUI];
}
-(void)settingUI{
    self.loginLogo.layer.cornerRadius =  32.25;
    self.loginLogo.clipsToBounds = YES;
    self.noticeView.backgroundColor = [UIColor colorWithRed:15/255.0 green:127/255.0 blue:165/255.0 alpha:1.0];
    
    self.idAcount.layer.borderWidth =  1;
    self.idAcount.layer.cornerRadius = 24.5;
    self.idAcount.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.password.layer.borderWidth = 1;
    self.password.layer.cornerRadius = 24.5;
    self.password.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.IdAccountInput.borderStyle = UITextBorderStyleNone;
    self.passwordInput.borderStyle = UITextBorderStyleNone;
}
- (IBAction)registerBtn:(id)sender {
    NSLog(@"点击了注册按钮");
    if(_IdAccountInput.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.IdAccountInput.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }
    if(_passwordInput.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.passwordInput.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }
    //SessionPOST请求
    [self sessionPost];
}
//注册POST请求
-(void)sessionPost{
    NSString *Strurl = @"http://go.jummy.top/api/user/";
    NSString *nameStr = [NSString stringWithFormat:@"%@",self.IdAccountInput.text];
    NSString *passwordStr = [NSString stringWithFormat:@"%@",self.passwordInput.text];
    NSDictionary *paramDict = @{@"username":nameStr,
                                @"password":passwordStr,
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
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [SVProgressHUD dismissWithDelay:0.8];
        }
        //返回页面
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
- (IBAction)loginBtn:(id)sender {
    NSLog(@"点击了登录按钮");
    //[self.alertView close];
    //如果用户名与密码输入为空，返回输入
    if(_IdAccountInput.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.IdAccountInput.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }
    if(_passwordInput.text.length == 0){
        [SVProgressHUD showErrorWithStatus:self.passwordInput.placeholder];
        [SVProgressHUD dismissWithDelay:0.7];
        return;
    }
    //POST请求登录：
    NSString *Strurl = @"http://go.jummy.top/api/user/login";
    NSString *nameStr = [NSString stringWithFormat:@"%@",self.IdAccountInput.text];
    NSString *passwordStr = [NSString stringWithFormat:@"%@",self.passwordInput.text];
    NSDictionary *paramDict = @{@"username":nameStr,
                                @"password":passwordStr,
                                @"type":@"JSON"
                                };
    [networktool post:Strurl params:paramDict success:^(id  _Nonnull responseObj) {
        NSLog(@"登录成功");
      
        NSLog(@"*****%@",responseObj);
        //解析数据
        [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        [SVProgressHUD dismissWithDelay:0.8];
        //token
        //存储Token
               NSString *dictArr22 = responseObj[@"data"][@"token"];
               NSLog(@"token的值是:%@",dictArr22);
        //记录用户登录状态
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.IdAccountInput.text forKey:@"name"];
        [userDefaults setObject:self.passwordInput.text forKey:@"password"];
         [userDefaults setObject:dictArr22 forKey:@"tokenStr"];
        [userDefaults synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

- (IBAction)back:(id)sender {
	[self dismissViewControllerAnimated:YES completion:^{
		NSLog(@"返回了");
	}];
}
/*
 UITextBorderStyleNone,
 UITextBorderStyleLine,
 UITextBorderStyleBezel,
 UITextBorderStyleRoundedRect
 */

@end
