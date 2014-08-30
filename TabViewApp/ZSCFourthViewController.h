//
//  ZSCFourthViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 5/29/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ZSCFourthViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    sqlite3 *db;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *sectionNames;
@property (strong,nonatomic) NSDictionary *childNames;

-(NSString *) filePath;
-(void) openDB;
-(void) createTableNamed:(NSString *) tableName withField1:(NSString *) field1 withField2:(NSString *) field2 withField3:(NSString *) field3;
-(void)deleteTableNamed:(NSString *)tableName;

@end
