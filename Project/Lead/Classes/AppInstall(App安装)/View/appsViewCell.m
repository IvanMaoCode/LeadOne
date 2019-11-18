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
    NSString *str =@"https://apps.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
