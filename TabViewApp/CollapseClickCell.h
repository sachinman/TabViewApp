//
//  CollapseClickCell.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/9/13.
//
//

#import <UIKit/UIKit.h>
#import "CollapseClickArrow.h"

#define kCCHeaderHeight 50

@interface CollapseClickCell : UIView

// Header
@property (weak, nonatomic) IBOutlet UIView *TitleView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *TitleButton;
@property (weak, nonatomic) IBOutlet CollapseClickArrow *TitleArrow;

// Body
@property (weak, nonatomic) IBOutlet UIView *ContentView;

// Properties
@property (nonatomic, assign) BOOL isClicked;
@property (nonatomic, assign) int index;

// Init
+ (CollapseClickCell *)newCollapseClickCellWithTitle:(NSString *)title index:(int)index content:(UIView *)content;



@end
