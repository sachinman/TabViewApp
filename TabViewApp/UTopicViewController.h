//
//  UTopicViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/27/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "MBProgressHUD.h"

@interface UTopicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,MBProgressHUDDelegate>
{
    sqlite3 *db;
    MBProgressHUD *HUD;
	
	long long expectedLength;
	long long currentLength;
}

@property (strong, nonatomic) NSArray *detailList;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *selectedDuilian;
@property (strong, nonatomic) IBOutlet UITableView *shangTableView;

-(NSString *) filePath;
-(void) openDB;
-(void) insertRecordIntoTableNamed:(NSString *) tableName
                        withField1:(NSString *) field1
                       field1Value:(NSString *) field1Value
                         andField2:(NSString *) field2
                       field2Value:(NSString *) field2Value
                         andField3:(NSString *) field3
                       field3Value:(NSString *) field3Value;


@end
