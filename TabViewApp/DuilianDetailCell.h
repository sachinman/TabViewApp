//
//  DuilianDetailCell.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import <UIKit/UIKit.h>

@interface DuilianDetailCell : UITableViewCell

@property(copy, nonatomic)NSString *shangLian;
@property(copy, nonatomic)NSString *xiaLian;

@property (strong, nonatomic) IBOutlet UILabel *shangLabel;
@property (strong, nonatomic) IBOutlet UILabel *xiaLable;

@end
