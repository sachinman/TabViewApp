//
//  LishiDuilianCell.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import "LishiDuilianCell.h"

@implementation LishiDuilianCell
@synthesize titleName=_titleName;
@synthesize duiLian=_duiLian;
@synthesize titleLabel=_titleLabel;
@synthesize duilianLable=_duilianLable;

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
-(void)setTitleName:(NSString *)n
{
    if (![n isEqualToString:_titleName]) {
        _titleName = [n copy];
        _titleLabel.text = _titleName;
    }
}


- (void)setDuiLian:(NSString *)c
{
    if (![c isEqualToString:_duiLian]) {
        _duiLian = [c copy];
        _duilianLable.text = _duiLian;
    }
}

@end
