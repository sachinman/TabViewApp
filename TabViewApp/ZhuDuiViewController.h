//
//  ZhuDuiViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ZhuDuiViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
	
	long long expectedLength;
	long long currentLength;
}
@property (strong, nonatomic) IBOutlet UITextField *lengthField;

@property (strong, nonatomic) IBOutlet UITextField *topicField;

-(IBAction)backgroundTap:(id)sender;
-(IBAction)textFieldDoneEditing:(id)sender;
@end
