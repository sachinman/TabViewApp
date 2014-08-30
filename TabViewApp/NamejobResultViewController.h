//
//  NamejobResultViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/27/13.
//
//

#import <UIKit/UIKit.h>

@interface NamejobResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *detailList;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *selectedDuilian;
@property (strong, nonatomic) IBOutlet UITableView *resultTableView;

@end
