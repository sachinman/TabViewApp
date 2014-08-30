//
//  WenZiViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/9/13.
//
//

#import <UIKit/UIKit.h>

@interface WenZiViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *wenziLabel;
@property NSInteger listPointer;
@property NSInteger viewPointer;

@end
