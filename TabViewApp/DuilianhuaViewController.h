//
//  DuilianhuaViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/20/13.
//
//

#import <UIKit/UIKit.h>
#import "UIViewValuePassDelegate.h"

@interface DuilianhuaViewController : UIViewController<UIViewValuePassDelegate>
@property (copy, nonatomic) NSString *duiLian;
@property (strong, nonatomic) NSArray *zuobiaoData;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
