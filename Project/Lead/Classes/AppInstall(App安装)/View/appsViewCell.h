//
//  appsViewCell.h
//  Canbee
//
//  Created by Kluth on 2019/11/7.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class appItem,appsViewCell;
@protocol appsViewCellDelegate<NSObject>
@optional//有选择性
-(void)installAppBtn:(appsViewCell *)cell;
@end

@interface appsViewCell : UITableViewCell
//模型
@property(nonatomic,strong) appItem *item;
//自定义代理
@property(nonatomic,weak) id<appsViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
