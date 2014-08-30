//
//  LishiDuilianCell.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import <UIKit/UIKit.h>

@interface LishiDuilianCell : UITableViewCell

@property(copy, nonatomic)NSString *titleName;
@property(copy, nonatomic)NSString *duiLian;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *duilianLable;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UIImageView *classImage;

@end
