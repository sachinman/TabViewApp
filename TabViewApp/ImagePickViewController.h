//
//  ImagePickViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/21/13.
//
//

#import <UIKit/UIKit.h>
#import "UIViewValuePassDelegate.h"

@interface ImagePickViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSObject<UIViewValuePassDelegate> *delegate;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end
