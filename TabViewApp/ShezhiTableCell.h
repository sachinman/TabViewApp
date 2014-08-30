//
//  ShezhiTableCell.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/7/13.
//
//

#import <UIKit/UIKit.h>

@interface ShezhiTableCell : UITableViewCell

@property(copy, nonatomic)NSString *baocunTitle;

@property (strong, nonatomic) IBOutlet UILabel *baocunLabel;
@property (strong, nonatomic) IBOutlet UISwitch *baocunSwitch;

@end
