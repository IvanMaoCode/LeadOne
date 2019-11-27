//
//  SHFontCycleLabel.m
//  textscroll
//
//  Created by Kluth on 2019/11/25.
//  Copyright © 2019 Kluth. All rights reserved.
//


#import "SHFontCycleLabel.h"


@interface SHFontCycleLabel ()

@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) NSTimer *myTimer;

@end

@implementation SHFontCycleLabel

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.myLabel];
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)setLabelText:(NSString *)labelText{
    
    [self.myTimer invalidate];
    self.myTimer = nil;
    [self.secondLabel removeFromSuperview];
    
    self.myLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _labelText = labelText;
    self.myLabel.textColor = MJSColor(168, 42, 23);
    self.myLabel.text = _labelText;
    
    CGRect rect = [_labelText boundingRectWithSize:CGSizeMake(10000, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.myLabel.font} context:nil];
    
    if (rect.size.width > self.frame.size.width) {
        
        self.myLabel.frame = CGRectMake(0, 0, rect.size.width + 30, self.frame.size.height);
        [self createSecondLabel];
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(startFontCycle) userInfo:nil repeats:YES];
    }
}

- (void)startFontCycle{
    
    self.myLabel.frame = CGRectMake(self.myLabel.frame.origin.x - 1, 0, self.myLabel.frame.size.width, self.myLabel.frame.size.height);
    self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.myLabel.frame), 0, self.secondLabel.frame.size.width, self.secondLabel.frame.size.height);
    self.secondLabel.textColor = MJSColor(168, 42, 23);
    if (CGRectGetMaxX(self.myLabel.frame) < 0) {
        
        UILabel *tempLabel;
        tempLabel = self.myLabel;
        self.myLabel = self.secondLabel;
        self.secondLabel = tempLabel;
    }
}



- (void)createSecondLabel{
    
    if (self.secondLabel) {
        
        self.secondLabel = nil;
    }
    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.myLabel.frame.size.width, 0, self.myLabel.frame.size.width, self.frame.size.height)];
    self.secondLabel.text = self.myLabel.text;
    
    [self addSubview:self.secondLabel];
}

- (UILabel *)myLabel{
    
    if (!_myLabel) {
        
        _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    
    return _myLabel;
}


- (void)dealloc{
    
    [self.myTimer invalidate];
    self.myTimer = nil;
}

@end
