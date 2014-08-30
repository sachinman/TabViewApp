//
//  ShezhiTableCell.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/7/13.
//
//

#import "ShezhiTableCell.h"

@implementation ShezhiTableCell
@synthesize baocunLabel=_baocunLabel;
@synthesize baocunTitle=_baocunTitle;
@synthesize baocunSwitch=_baocunSwitch;

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

-(void)setBaocunTitle:(NSString *)baocunTitle
{
    if (![baocunTitle isEqualToString:_baocunTitle]) {
        _baocunTitle = [baocunTitle copy];
        _baocunLabel.text = _baocunTitle;
    }
}



@end
