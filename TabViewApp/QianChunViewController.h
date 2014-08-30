//
//  QianChunViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/2/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "MBProgressHUD.h"

@interface QianChunViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate,MBProgressHUDDelegate>
{
    sqlite3 *db;
    MBProgressHUD *HUD;
	
	long long expectedLength;
	long long currentLength;
}

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UISwitch *switchView;

-(NSString *) filePath;
-(void) openDB;
-(void) insertRecordIntoTableNamed:(NSString *) tableName
                        withField1:(NSString *) field1
                       field1Value:(NSString *) field1Value
                         andField2:(NSString *) field2
                       field2Value:(NSString *) field2Value
                         andField3:(NSString *) field3
                       field3Value:(NSString *) field3Value;

- (IBAction)switchChanged:(id)sender;

-(IBAction)backgroundTap:(id)sender;
-(IBAction)textFieldDoneEditing:(id)sender;
@end
