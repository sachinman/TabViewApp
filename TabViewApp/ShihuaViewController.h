//
//  ShihuaViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/8/13.
//
//

#import <UIKit/UIKit.h>

@interface ShihuaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *shihuaData;

@property (strong, nonatomic) NSArray *jiqiaoData;

@property NSInteger viewPointer;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
