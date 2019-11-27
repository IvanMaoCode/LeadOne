//
//  superLinkViewController.h
//  Canbee
//
//  Created by Kluth on 2019/11/1.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface superLinkViewController : UIViewController
{
    NSString *countClickss;
}

@property(nonatomic,strong)void(^block)(void);
-(void)setCountClickss:(NSString *)newsetCountClicks;
-(NSString *)countClickss;
@end

NS_ASSUME_NONNULL_END
