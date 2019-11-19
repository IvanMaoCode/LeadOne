//
//  insallAppViewController.m
//  Canbee
//
//  Created by Kluth on 2019/11/7.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import "insallAppViewController.h"
#import "appsViewCell.h"
#import "appItem.h"
#import "MJExtension.h"

@interface insallAppViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *subTags;
@end
static NSString const *ID = @"cell";
@implementation insallAppViewController
- (NSArray *)subTags{
	if(!_subTags){
		_subTags = [appItem mj_objectArrayWithFilename:@"appItem.plist"];
	}
	return _subTags;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, MJSSreenW, 44);
  //注册xib
	[self.tableView registerNib:[UINib nibWithNibName:@"appsViewCell" bundle:nil] forCellReuseIdentifier:ID];
	
	//返回按钮
	UIButton *backBtn = [[UIButton alloc] initWithFrame:(CGRectMake(10.5, 13.5, 10, 17.5))];
	[backBtn setImage:[UIImage imageNamed:@"back0"] forState:UIControlStateNormal];
	[backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, MJSSreenW, 88))];

    //提醒用户安装并且注册以下3个APP即可获得永久免费使用
    // 改变字体大小
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"安装并且注册以下3个APP即可获得永久免费使用"];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,17)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(21,2)];
    // 改变颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(17, 4)];
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake((MJSSreenW - 342)/2, 12, 342, 20)];
  
    
   
    noticeLabel.attributedText = str;

    
	UIView *headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 44, MJSSreenW, 44))];
	headerView.backgroundColor = MJSColor(220, 220, 220);
	[self.tableView.tableHeaderView addSubview:headerView];
	[self.tableView.tableHeaderView addSubview:backBtn];
    [headerView addSubview:noticeLabel];
    
	self.tableView.tableHeaderView.backgroundColor = MJSColor(84, 201, 247);
	UIView *aboveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MJSSreenW, 44)];
	aboveView.backgroundColor = [UIColor grayColor];
	[self.tableView insertSubview:self.tableView.tableHeaderView aboveSubview:aboveView];
	
	UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, MJSSreenW, MJSSreenH)];
	
    
	[scrollView addSubview:self.tableView];
	scrollView.contentSize = CGSizeMake(200, 400);
//	self.tableView.contentInset = UIEdgeInsetsMake(0, 20, MJSSreenW, 64);
	
}
-(void)back{
	[self dismissViewControllerAnimated:YES completion:^{
		NSLog(@"返回");
	}];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
	return self.subTags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	//自定义cell
	appsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	//注意:t如果cell从xib加载，一定要记得绑定标识符
	
	//第二种方式：注册cell
	//	if(cell == nil){
	//		//cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
	//
	//		cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MJSSubTagCell class]) owner:nil options:nil][0];
	//	}
	
	//cell.item = self.subTags[indexPath.row];
	//获取模型
	appItem *item = self.subTags[indexPath.row];
	cell.item = item;
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 100;
}


@end
