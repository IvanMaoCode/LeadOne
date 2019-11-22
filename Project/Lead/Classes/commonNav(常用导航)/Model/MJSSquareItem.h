//
//  MJSSquareItem.h
//  Canbee
//
//  Created by Kluth on 2019/10/31.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//@class MJSSquareItem,allData;
//
//@interface  allData: NSObject
//@property(nonatomic,strong)NSArray<MJSSquareItem *> *data;
//@end

@interface MJSSquareItem : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *line;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray *allData;
@end

NS_ASSUME_NONNULL_END
