//
//  deepNightController.m
//  Lead
//
//  Created by Kluth on 2019/11/25.
//  Copyright © 2019 lorenzotech. All rights reserved.
//

#import "deepNightController.h"
#import "SafariServices/SafariServices.h"
#import "SHFontCycleLabel.h"
@interface deepNightController ()

@end

@implementation deepNightController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =  MJSColor(42, 62, 80);
    [self addButton];
    
    NSString *Str = @"深夜福利  深夜福利  深夜福利  深夜福利  ";
    SHFontCycleLabel *label = [[SHFontCycleLabel alloc]initWithFrame:CGRectMake((MJSSreenW - 120)/2, 20, 120, 40)];
    UIColor *colorbg = MJSColor(42, 62, 80);
    [label setBackgroundColor:colorbg];
    label.labelText = Str ;
    [self.view addSubview:label];
}

-(void)addButton{
    NSArray *imageArray= [NSArray arrayWithObjects:@"WechatIMG23",@"WechatIMG22",@"WechatIMG21",@"WechatIMG19",nil];
    for (int i=0; i<4; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(MJSSreenW/4*i+2, 80, MJSSreenW/4-5, MJSSreenW/4-5)];
        btn.tag=i;
        btn.layer.cornerRadius = 22.3;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
//        [self->yjlview addSubview:btn];
    }
}
//youjizz : www.youjizz.com

-(void)clickTap:(UIButton *)sender{
    NSString *urlStr;
    switch (sender.tag) {
        case 0:
            NSLog(@"点击了1");
            urlStr = @"https://www.baidu.com";
            break;
        case 1:
            NSLog(@"点击了2");
            urlStr = @"https://www.xvideo.com";
            break;
        case 2:
            NSLog(@"点击了3");
            urlStr = @"https://www.xnxx.com";
            break;
        case 3:
            urlStr = @"https://www.PornHub.com";
            NSLog(@"点击了4");
            break;
        default:
            break;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
     SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
    [self presentViewController:safariVc animated:YES completion:nil];

}
@end
