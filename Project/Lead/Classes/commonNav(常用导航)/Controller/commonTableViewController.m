//
//  commonTableViewController.m
//  Canbee
//
//  Created by Kluth on 2019/11/1.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import "commonTableViewController.h"
#import "MJSSquareItem.h"
#import "MJSSquarecell.h"

#import "MJSSquareItem.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SafariServices/SafariServices.h"
#import "Masonry.h"
#import "networktool.h"

#import "MJSCell.h"
static NSString *const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH  (MJSSreenW - (cols - 1) * margin) / cols
@interface commonTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) NSArray *squareItems;
@property(nonatomic,weak)UICollectionView *collectionsView;
@end

@implementation commonTableViewController
//- (NSMutableArray *)squareItems{
//    if(_squareItems == nil){
//        MJSSquareItem *squareItems = [[MJSSquareItem alloc] init];
//        _squareItems = squareItems;
//    }
//        return _squareItems;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupFootView];
	
	
	//请求cell数据
	//[self loadData];
	//处理cell间距
	self.tableView.sectionHeaderHeight = 0;
	
	self.tableView.sectionFooterHeight = 10;
//	self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
	//展示Cell内容
//	[self loadData];
}
//GET请求数据
-(void)loadData{
    //POST请求登录：
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSString *Strurl = @"http://go.jummy.top/software/show/";
  
      NSDictionary *paramDict = @{@"result":@"成功",
                                  @"code":@200,
                                  @"type":@"JSON"
                                  };
      [networktool get:Strurl params:paramDict success:^(id  _Nonnull responseObj) {
         
          NSLog(@"请求成功");
//          [responseObj writeToFile:@"/Users/kluth/Desktop/LeadGit/test.plist" atomically:YES];
          //字典数组转模型
          NSArray *dictArr = responseObj[@"data"];
          
//       self.squareItems = [MJSSquareItem mj_objectWithKeyValues:array];
          self.squareItems = [MJSSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
//          self.squareItems = [MJSSquareItem mj_keyValuesArrayWithObjectArray:dictArr];
//          self.squareItems = [MJSSquareItem mj_setupObjectClassInArray:dictArr];
     
          for (MJSSquareItem *item in self.squareItems){
              NSLog(@"%@",item.name);
          }
//          for (NSArray * array in dictArr) {
//              for (NSDictionary *dict in array) {
//                  NSLog(@"%@",dict);
//              }
//          }
          
          NSLog(@"%@------------------------------",self.squareItems);
//          [MJSSquareItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//              return @{@"allData":@"data"};
//          }];
//
//          [self resolveData];
          self.tableView.tableFooterView = self.collectionsView;
          //刷新表格展示数据
          [self.tableView reloadData];

      } failure:^(NSError * _Nonnull error) {
          NSLog(@"请求失败");
      }];
//        });
}
-(void)setupFootView{
	//创建布局
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	
	//设置cell的尺寸
	layout.itemSize = CGSizeMake(itemWH, itemWH);
	layout.minimumInteritemSpacing = margin;
	layout.minimumLineSpacing = margin;
    
	//创建UIcollectionView
	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 110, 0, 900) collectionViewLayout:layout];
	_collectionsView = collectionView;
	collectionView.backgroundColor = MJSColor(42, 62, 80);
//    collectionView.backgroundColor = [UIColor clearColor];
//    collectionView.backgroundColor = [UIColor yellowColor];
	
	self.tableView.backgroundColor = MJSColor(166, 166, 166);

	self.tableView.tableFooterView = collectionView;
	//上面灰色视图
	UILabel *label = [[UILabel alloc] init];
//	label.backgroundColor =  MJSColor(166, 166, 166);
    label.backgroundColor = [UIColor orangeColor];
	label.frame = CGRectMake(10, 0, 0, 49);
	label.textColor = [UIColor whiteColor];
	label.textAlignment = NSTextAlignmentCenter;


	self.tableView.tableHeaderView = label;
   
	//添加按钮
	UIButton *btn = [[UIButton alloc] init];
	[btn setImage:[UIImage imageNamed:@"back0"] forState:UIControlStateNormal];
	btn.frame = CGRectMake(-10, -20, 110, 100);
	[btn setTitle:@"返回" forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
	[self.tableView addSubview:btn];
	
	collectionView.dataSource = self;
	collectionView.delegate = self;
	collectionView.scrollEnabled = NO;
	//注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"MJSCell" bundle:nil] forCellWithReuseIdentifier:ID];

}
-(void)back{
	[self dismissViewControllerAnimated:YES completion:^{
		NSLog(@"关闭当前窗口完成");
	}];
}
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	MJSSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    
    cell.item = self.squareItems[indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    NSLog(@"%@dssssssssssssssssssss",cell.item.result);
	return cell;
}
#pragma mark - 处理请求完成的数据 填充补全表格
//-(void)resolveData{
//	NSInteger count = self.squareItems.count;
//	NSInteger exter = count % cols;
//	if(exter){
//		exter = cols - exter;
//		exter = exter + 4;
//		for(int i = 0;i < exter;i++){
//			MJSSquareItem *item = [[MJSSquareItem alloc] init];
//			[self.squareItems addObject:item];
//		}
//	}
//}

#pragma mark - Table view data source
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	MJSSquareItem *item = self.squareItems[indexPath.row];
	if(![item.line containsString:@"http"]) return;
	NSURL *url = [NSURL URLWithString:item.line];
	SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
	//处理done的返回
	/*方法一
	 safariVc.delegate = self;
	 self.navigationController.navigationBarHidden = YES;
	 [self.navigationController pushViewController:safariVc animated:YES];
	 */

	[self presentViewController:safariVc animated:YES completion:nil];

}
@end
