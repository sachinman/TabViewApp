//
//  AboutViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 7/12/13.
//
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize aboutWebView=_aboutWebView;
@synthesize htmlName=_htmlName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViews];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_htmlName ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [_aboutWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAboutWebView:nil];
    [super viewDidUnload];
}
#pragma mark - Private methods

- (void)initViews
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
}
@end
