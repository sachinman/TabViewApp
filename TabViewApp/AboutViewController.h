//
//  AboutViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 7/12/13.
//
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (copy, nonatomic) NSString *htmlName;
@property (strong, nonatomic) IBOutlet UIWebView *aboutWebView;


@end
