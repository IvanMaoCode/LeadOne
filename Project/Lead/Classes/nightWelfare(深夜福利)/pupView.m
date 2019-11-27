//
//  pupView.m
//  用户登录
//
//  Created by Kluth on 2019/11/7.
//  Copyright © 2019 yu_jing_shan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pupView.h"
#import "SafariServices/SafariServices.h"
#import "mainViewController.h"
#import "commonNav.h"
#define MJSSreenH [UIScreen mainScreen].bounds.size.height
#define MJSSreenW [UIScreen mainScreen].bounds.size.width
#define MJSColor(r,g,b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1];

@interface pupView()
{
	UIView * yjlview;
}
@property(nonatomic,strong) NSString *buttonCount;
@property(strong,nonatomic)pupView *myView;
@end
@implementation pupView

-(instancetype)initWithFrame:(CGRect)frame{
	if (self == [super initWithFrame:frame]) {
//		[self initview];
        [self addButton];
	}
	return self;
}
-(void)addButton{
    NSArray *imageArray= [NSArray arrayWithObjects:@"WechatIMG23",@"WechatIMG22",@"WechatIMG21",@"WechatIMG19",nil];
    for (int i=0; i<4; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(MJSSreenW/4*i, 50, MJSSreenW/4, MJSSreenW/4)];
        btn.tag=i;
        [btn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [self addSubview:btn];
//        [self->yjlview addSubview:btn];
    }
}
-(void)clickTap:(UIButton *)sender{
    if (sender.tag ==0) {
        if (!_clickTapBlock) {
            return;
        }
        _clickTapBlock();
        
        NSLog(@"块");
    }
}
-(void)initview{
	
	self.frame = CGRectMake(0, 0,MJSSreenW , MJSSreenH);
	self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
	self.userInteractionEnabled = YES;
	[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
	if (yjlview == nil) {
		yjlview = [[UIView alloc]initWithFrame:CGRectMake(0, MJSSreenH, MJSSreenW, MJSSreenH)];
		yjlview.backgroundColor =  MJSColor(42, 62, 80);
		[self addSubview:yjlview];
		
        [self manuallySetBtn];
        [self addButton];
	}
}
-(void)manuallySetBtn{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MJSSreenW/4, MJSSreenW/4)];
            UIImage *image = [UIImage imageNamed:@"WechatIMG23"];
    //        [btn1 setImage:image forState:UIControlStateNormal];
            [btn1 setBackgroundImage:image forState:UIControlStateNormal];
            btn1.backgroundColor = MJSColor(0, 62, 80);
            btn1.layer.cornerRadius = 22.3;
            btn1.layer.borderWidth = 1;
            btn1.clipsToBounds = YES;
            btn1.tag = 1;

            [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
            [self->yjlview addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(MJSSreenW/4, 0, MJSSreenW/4, MJSSreenW/4)];
            [btn2 setImage:[UIImage imageNamed:@"WechatIMG22"] forState:UIControlStateNormal];
            btn2.backgroundColor = MJSColor(0, 62, 80);
            btn2.layer.cornerRadius = 22.3;
                  btn2.layer.borderWidth = 1;
                  btn2.clipsToBounds = YES;
            btn2.tag = 2;
            [btn2 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
            [self->yjlview addSubview:btn2];
            
            UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(MJSSreenW/4*2, 0, MJSSreenW/4, MJSSreenW/4)];
            [btn3 setImage:[UIImage imageNamed:@"WechatIMG21"] forState:UIControlStateNormal];
            btn3.backgroundColor = MJSColor(0, 62, 80);
            btn3.layer.cornerRadius = 22.3;
                  btn3.layer.borderWidth = 1;
                  btn3.clipsToBounds = YES;
            btn3.tag = 3;
            [btn3 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
            [self->yjlview addSubview:btn3];
            
            UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(MJSSreenW/4*3, 0, MJSSreenW/4, MJSSreenW/4)];
            [btn4 setImage:[UIImage imageNamed:@"WechatIMG19"] forState:UIControlStateNormal];
            btn4.backgroundColor = MJSColor(0, 62, 80);
            btn4.layer.cornerRadius = 22.3;
                  btn4.layer.borderWidth = 1;
                  btn4.clipsToBounds = YES;
            btn4.tag = 4;
            [btn4 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
            [self->yjlview addSubview:btn4];
}
//点击了深夜福利
//PornHub: www.PornHub.com
//
//XNXX :www.xnxx.com
//
//Xvideo : www.xvideo.com
//
//youjizz : www.youjizz.com

-(void)btn1:(id)sender{
    UIButton *button = (UIButton *)sender;
    //进入的网址
    NSString *urlStr;
    switch (button.tag) {
        case 1:
            urlStr = @"https://www.baidu.com";
            if (!_clickTapBlock) {
                       return;
                   }
                   _clickTapBlock();
            break;
        case 2:
            urlStr = @"www.xvideo.com";
            break;
        case 3:
            urlStr = @"www.xnxx.com";
            break;
        case 4:
            urlStr = @"www.PornHub.com";
            break;
        default:
            break;
    }
}

- (void)coutomshowInView:(UIView *)view{
	if (!view){
		return;
	}
	[view addSubview:self];
	[view addSubview:yjlview];
	[yjlview setFrame:CGRectMake(0, MJSSreenH, MJSSreenW, 216)];
	[UIView animateWithDuration:0.3 animations:^{
		self.alpha = 1.0;
		[self->yjlview setFrame:CGRectMake(0, MJSSreenH - 216, MJSSreenW, 216)];
	} completion:nil];
}

- (void)showInView{
	[[UIApplication sharedApplication].keyWindow addSubview:self];
	[[UIApplication sharedApplication].keyWindow addSubview:yjlview];
	[yjlview setFrame:CGRectMake(0, MJSSreenH, MJSSreenW, 216)];
	[UIView animateWithDuration:0.3 animations:^{
		self.alpha = 1.0;
		[self->yjlview setFrame:CGRectMake(0, MJSSreenH - 216, MJSSreenW, 216)];
	} completion:nil];
    
  
}

- (void)dismissView{
	[yjlview setFrame:CGRectMake(0, MJSSreenH - 216, MJSSreenW, 216)];
	[UIView animateWithDuration:0.3f
					 animations:^{
						 self.alpha = 0.0;
						 
						 [self->yjlview setFrame:CGRectMake(0, MJSSreenH, MJSSreenW, 216)];
					 }
					 completion:^(BOOL finished){
						 [self removeFromSuperview];
						 [self->yjlview removeFromSuperview];
						 
    }];
}



@end
