//
//  MJSCell.h
//  Lead
//
//  Created by Kluth on 2019/11/22.
//  Copyright © 2019 lorenzotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MJSSquareItem;
@interface MJSCell : UICollectionViewCell
@property(nonatomic,strong) MJSSquareItem *item;
@end

NS_ASSUME_NONNULL_END
