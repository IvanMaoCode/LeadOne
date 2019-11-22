//
//  MJSCell.m
//  Lead
//
//  Created by Kluth on 2019/11/22.
//  Copyright © 2019 lorenzotech. All rights reserved.
//

#import "MJSCell.h"
#import "UIImageView+WebCache.h"
#import "MJSSquareItem.h"
@interface MJSCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end
@implementation MJSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setItem:(MJSSquareItem *)item{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
    
    _iconView.layer.cornerRadius = 13;
}
@end
