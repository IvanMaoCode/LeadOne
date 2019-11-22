//
//  appsViewCell.m
//  Canbee
//
//  Created by Kluth on 2019/11/7.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//
#import "appItem.h"
#import "appsViewCell.h"


@interface appsViewCell()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *appIconView;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appInstruct;
@property (weak, nonatomic) IBOutlet UIButton *installBtn;

@property(assign,nonatomic) NSInteger number_id;

@end
@implementation appsViewCell
- (void)setItem:(appItem *)item{
	_item = item;
	//设置内容
	_appIconView.image = [UIImage imageNamed:@"placeholder"];
	_appName.text = item.app_name;
	_appInstruct.text = item.app_Intro;
    _number_id = item.sub_number;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	self.installBtn.layer.borderWidth = 1;
	self.installBtn.layer.borderColor = [[UIColor greenColor] CGColor];
	self.installBtn.layer.cornerRadius = 12.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//安装指定App
- (IBAction)installApp:(id)sender {
    NSLog(@"点击了第一个按钮:%@",self.item.app_name);
    
    NSLog(@"%ld",self.item.sub_number);
    
    
    NSString *Str =@"https://apps.apple.com/cn/app/%E4%B9%9D%E7%A7%80%E7%9B%B4%E6%92%AD-%E8%B6%85%E7%B2%BE%E5%BD%A9%E7%9A%84%E5%85%A8%E6%B0%91%E7%9B%B4%E6%92%AD%E5%B9%B3%E5%8F%B0/id717804271";
    
    NSString *Str2 = @"https://apps.apple.com/cn/app/%E4%B9%90%E5%97%A8%E7%9B%B4%E6%92%AD-%E8%A7%86%E9%A2%91%E7%9B%B4%E6%92%AD%E4%BA%A4%E5%8F%8B%E5%B9%B3%E5%8F%B0/id1380715509";
    
    NSString *Str3 = @"https://apps.apple.com/cn/app/%E4%BC%98%E8%89%BA%E7%9B%B4%E6%92%AD-%E7%BE%8E%E5%A5%B3%E7%9B%B4%E6%92%AD%E5%9C%A8%E7%BA%BF%E8%81%8A%E5%A4%A9%E4%BA%A4%E5%8F%8B%E5%B9%B3%E5%8F%B0/id1361514529";
      NSString *goStr = Str;
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    if(self.item.sub_number == 33){
        goStr = Str;
    }else if(self.item.sub_number == 22){
        goStr = Str2;
    }else{
        goStr = Str3;
    }
    UIApplication *application = [UIApplication sharedApplication];
     [application openURL:[NSURL URLWithString:goStr] options:@{} completionHandler:nil];
}
@end
