//
//  ZSCThirdViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/1/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ZSCThirdViewController : UITableViewController
{
    sqlite3 *db;
}

@property (strong, nonatomic) NSArray *list;

@property (strong, nonatomic) NSMutableArray *duilianList;
-(IBAction)toggleEdit:(id)sender;

-(NSString *) filePath;
-(void) openDB;
-(void) getAllRowsFromTableNamed: (NSString *) tableName;

@end
