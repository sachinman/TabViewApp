//
//  AAMFeedbackViewController.h
//  TabViewApp
//
//  Created by Shicheng Zhang on 7/13/13.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AAMFeedbackViewController : UITableViewController<UITextViewDelegate,MFMailComposeViewControllerDelegate>
{
    UITextView  *_descriptionTextView;
    UITextField *_descriptionPlaceHolder;
    NSInteger _selectedTopicsIndex;
    BOOL _isFeedbackSent;
}

@property (retain, nonatomic) NSString *descriptionText;
@property (retain, nonatomic) NSArray *topics;
@property (retain, nonatomic) NSArray *topicsToSend;
@property (retain, nonatomic) NSArray *toRecipients;
@property (retain, nonatomic) NSArray *ccRecipients;
@property (retain, nonatomic) NSArray *bccRecipients;

+ (BOOL)isAvailable;
- (id)initWithTopics:(NSArray*)theTopics;

@end
