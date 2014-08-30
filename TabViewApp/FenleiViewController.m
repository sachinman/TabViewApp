//
//  FenleiViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/9/13.
//
//

#import "FenleiViewController.h"

@interface FenleiViewController ()

@end

@implementation FenleiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"对联分类";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    // If you want a cell open on load, run this method:
    //[myCollapseClick openCollapseClickCellAtIndex:1 animated:NO];
    
    /*
     // If you'd like multiple cells open on load, create an NSArray of NSNumbers
     // with each NSNumber corresponding to the index you'd like to open.
     // - This will open Cells at indexes 0,2 automatically
     
     NSArray *indexArray = @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:2]];
     [myCollapseClick openCollapseClickCellsWithIndexes:indexArray animated:NO];
     */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 11;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    switch (index) {
        case 0:
            return @"春联";
            break;
        case 1:
            return @"寿联";
            break;
        case 2:
            return @"挽联";
            break;
        case 3:
            return @"名胜联";
            break;
        case 4:
            return @"节令联";
            break;
        case 5:
            return @"喜庆联";
            break;
        case 6:
            return @"行业联";
            break;
        case 7:
            return @"题赠联";
            break;
        case 8:
            return @"学术联";
            break;
        case 9:
            return @"趣巧联";
            break;
        case 10:
            return @"杂感联";
            break;

        default:
            return @"";
            break;
    }
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return test1View;
            break;
        case 1:
            return test2View;
            break;
        case 2:
            return test3View;
            break;
        case 3:
            return mingshengView;
            break;
        case 4:
            return jieriView;
            break;
        case 5:
            return qingheView;
            break;
        case 6:
            return hangyeView;
            break;
        case 7:
            return tizengView;
            break;
        case 8:
            return xueshuView;
            break;
        case 9:
            return quqiaoView;
            break;
        case 10:
            return zaganView;
            break;

            
        default:
            return mingshengView;
            break;
    }
}


// Optional Methods

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    return [UIColor colorWithRed:223/255.0f green:47/255.0f blue:51/255.0f alpha:1.0];
}


-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithWhite:1.0 alpha:0.85];
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithWhite:0.0 alpha:0.25];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
   // NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
}



@end
