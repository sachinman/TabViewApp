//
//  ZSCDetailViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import <UIKit/UIKit.h>

@interface ZSCDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *detailList;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@property (copy, nonatomic) NSString *className;
@property (copy, nonatomic) NSString *inputStr;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *selectedDuilian;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
