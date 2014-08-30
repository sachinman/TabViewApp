//
//  QianduiResultViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/26/13.
//
//

#import <UIKit/UIKit.h>

@interface QianduiResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *detailList;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *selectedDuilian;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
