//
//  UILabel+Safe.m
//  Lead
//
//  Created by Kluth on 2019/11/27.
//  Copyright © 2019 lorenzotech. All rights reserved.
//
//
//#import "UILabel+Safe.h"
//#import "NSObject+SafeSwizzle.h"
//
//@implementation UILabel (Safe)
//
//+ (void)load{
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//         [self exchangeInstance:[UILabel class] selector:@selector(setText:) withSwizzledSelector:@selector(safe_setText:)];
//    });
//}
//
//- (void)safe_setText:(NSString *)text{
//
//    if(!text){
//
//        text = @"";
//    }
//
//    if(![text isKindOfClass:[NSString class]]){
//
//        text = [NSString stringWithFormat:@"%@", text];
//    }
//
//    // invoke originalimplemention
//    [self safe_setText:text];
//}

//@end
