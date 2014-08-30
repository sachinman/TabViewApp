//
//  FenleiViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/9/13.
//
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface FenleiViewController : UIViewController<CollapseClickDelegate>{
    IBOutlet UIView *test1View;
    IBOutlet UIView *test2View;
    IBOutlet UIView *test3View;
    IBOutlet UIView *mingshengView;
    IBOutlet UIView *jieriView;
    IBOutlet UIView *qingheView;
    IBOutlet UIView *hangyeView;
    IBOutlet UIView *tizengView;
    IBOutlet UIView *xueshuView;
    IBOutlet UIView *quqiaoView;
    IBOutlet UIView *zaganView;
    
    
    __weak IBOutlet CollapseClick *myCollapseClick;
}

@end
