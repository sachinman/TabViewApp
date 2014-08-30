//
//  ImagePickCell.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/21/13.
//
//

#import "ImagePickCell.h"
#import "CustomCellBackground.h"

@implementation ImagePickCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews=[[NSBundle mainBundle]loadNibNamed:@"ImagePickCell" owner:self options:nil];
        if (arrayOfViews.count<1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0]isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        self=[arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // change to our custom selected background view
        CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
