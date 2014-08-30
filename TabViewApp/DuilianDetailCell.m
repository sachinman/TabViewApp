//
//  DuilianDetailCell.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import "DuilianDetailCell.h"

@implementation DuilianDetailCell
@synthesize shangLian=_shangLian;
@synthesize xiaLian=_xiaLian;
@synthesize shangLabel=_shangLabel;
@synthesize xiaLable=_xiaLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShangLian:(NSString *)shangLian
{
    if (![shangLian isEqualToString:_shangLian]) {
        _shangLian = [shangLian copy];
        _shangLabel.text = _shangLian;
    }
}


- (void)setXiaLian:(NSString *)xiaLian
{
    if (![xiaLian isEqualToString:_xiaLian]) {
        _xiaLian = [xiaLian copy];
        _xiaLable.text = _xiaLian;
    }
}

@end
