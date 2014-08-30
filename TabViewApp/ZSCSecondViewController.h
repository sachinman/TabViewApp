//
//  ZSCSecondViewController.h
//  TabViewApp
//
//  Created by student on 13-5-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "MBProgressHUD.h"


@class XiaYingViewController;

@interface ZSCSecondViewController : UIViewController<MBProgressHUDDelegate>
{
    sqlite3 *db;
    MBProgressHUD *HUD;
}
-(NSString *) filePath;
-(void) openDB;
-(void) createTableNamed:(NSString *) tableName withField1:(NSString *) field1 withField2:(NSString *) field2 withField3:(NSString *) field3;

- (IBAction)xialianYingduiClick:(id)sender;
- (IBAction)qianmingDuilianClick:(id)sender;
- (IBAction)qianmingchunlianClick:(id)sender;
- (IBAction)zhiyechunlianClick:(id)sender;
- (IBAction)zhutiduilianClick:(id)sender;
- (IBAction)yaoyiyaoClick:(id)sender;

@end
