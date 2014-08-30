//
//  AAMFeedbackTopicsViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 7/13/13.
//
//

#import <UIKit/UIKit.h>

@interface AAMFeedbackTopicsViewController : UITableViewController {
    NSInteger _selectedIndex;
}

@property (assign, nonatomic) id delegate;
@property (assign, nonatomic) NSInteger selectedIndex;

@end

@protocol AAMFeedbackTopicsViewControllerDelegate<NSObject>

- (void)feedbackTopicsViewController:(AAMFeedbackTopicsViewController *)feedbackTopicsViewController didSelectTopicAtIndex:(NSInteger)selectedIndex;

@end
