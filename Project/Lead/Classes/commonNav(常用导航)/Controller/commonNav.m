//
//  commonNav.m
//  Lead
//
//  Created by Kluth on 2019/11/22.
//  Copyright © 2019 lorenzotech. All rights reserved.
//
#import "commonTableViewController.h"
#import "MJSSquareItem.h"
#import "MJSSquarecell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SafariServices/SafariServices.h"
#import "Masonry.h"
#import "networktool.h"

#import "MJSCell.h"
#import "commonNav.h"
static NSString *const ID = @"cell";
@interface commonNav ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) NSArray *squareItems;
@property(nonatomic,weak)UICollectionView *collectionView;
@end

@implementation commonNav

- (void)viewDidLoad {
    [super viewDidLoad];
   //头部视图
    [self setupTopView];
   
    //设置底部视图
    [self setupFootView];
    
    //展示方块内容请求数据
    [self loadData];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"关闭当前窗口完成");
    }];
}
-(void)setupTopView{
       //头部View
       UILabel *label = [[UILabel alloc] init];
       label.backgroundColor = MJSColor(68, 160, 184);
       label.frame = CGRectMake(0, 0, 0, 49);
       label.textColor = [UIColor whiteColor];
       label.textAlignment = NSTextAlignmentCenter;
       self.tableView.tableHeaderView = label;
       
       //添加按钮
       UIButton *btn = [[UIButton alloc] init];
       [btn setImage:[UIImage imageNamed:@"back0"] forState:UIControlStateNormal];
       btn.frame = CGRectMake(-12, -25, 110, 100);
       [btn setTitle:@"返回" forState:UIControlStateNormal];
       [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
       [self.tableView addSubview:btn];
       self.tableView.backgroundColor = MJSColor(42, 62, 80);
}
-(void)loadData{
    //POST请求登录：
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSString *Strurl = @"http://go.jummy.top/navigation/";
      NSDictionary *paramDict = @{@"result":@"成功",
                                  @"code":@200,
                                  @"type":@"JSON"
                                  };
      [networktool get:Strurl params:paramDict success:^(id  _Nonnull responseObj) {
         
          NSLog(@"请求成功");
//          [responseObj writeToFile:@"/Users/kluth/Desktop/LeadGit/test5.plist" atomically:YES];
          //字典数组转模型
          NSArray *dictArr = responseObj[@"data"];
          
//       self.squareItems = [MJSSquareItem mj_objectWithKeyValues:array];
          _squareItems = [MJSSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
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
//          self.tableView.tableFooterView = self.collectionsView;
          //刷新表格展示数据
//          [self.tableView reloadData];
          
          [self.collectionView reloadData];

      } failure:^(NSError * _Nonnull error) {
          NSLog(@"请求失败");
      }];
//        });
}
-(void)setupFootView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell尺寸
    NSInteger cols = 4;
    CGFloat margin = 1;
    CGFloat itmeWH = (MJSSreenW -(cols -1) *margin) / cols;
    layout.itemSize = CGSizeMake(itmeWH, itmeWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    //创建UIColle
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 900) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = MJSColor(42, 62, 80);
    self.tableView.tableFooterView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //注册Cell
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    //xib
    [collectionView registerNib:[UINib nibWithNibName:@"MJSCell" bundle:nil] forCellWithReuseIdentifier:ID];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //从缓存池取
    MJSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
  
    cell.item = self.squareItems[indexPath.row];
    return cell;
}
#pragma mark - Table view data source
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"点击了进入网页");
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
//    NSLog(@"点击了进入网页");
}
@end
