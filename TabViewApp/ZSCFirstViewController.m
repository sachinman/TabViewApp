//
//  ZSCFirstViewController.m
//  TabViewApp
//
//  Created by student on 13-5-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ZSCFirstViewController.h"
#import "ShihuaViewController.h"
#import "FenleiViewController.h"
#import "JingdianViewController.h"

@interface ZSCFirstViewController ()
@property (strong, nonatomic) JingdianViewController *wenziController;
@end

@implementation ZSCFirstViewController
@synthesize wenziController=_wenziController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"知识", @"知识");
        self.tabBarItem.image = [UIImage imageNamed:@"book"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)shihuaClick:(id)sender {
    [UIView beginAnimations:@"viewFlip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    ShihuaViewController *shihuaViewController=[[ShihuaViewController alloc]initWithNibName:@"ShihuaViewController" bundle:nil];
    shihuaViewController.viewPointer=1;
    //qianchunViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:shihuaViewController animated:YES];
    [UIView commitAnimations];

}

- (IBAction)fenleiClick:(id)sender {
    
    FenleiViewController *fenleiViewController=[[FenleiViewController alloc]initWithNibName:@"FenleiViewController" bundle:nil];
    //fenleiViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:fenleiViewController animated:YES];
}

- (IBAction)jiqiaoClick:(id)sender {
    ShihuaViewController *jiqiaoViewController=[[ShihuaViewController alloc]initWithNibName:@"ShihuaViewController" bundle:nil];
    jiqiaoViewController.viewPointer=2;
    //qianchunViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:jiqiaoViewController animated:YES];
}

- (IBAction)jingdianClick:(id)sender {
    if (_wenziController==nil) {
        _wenziController=[[JingdianViewController alloc]init];
    }
    
    _wenziController.hidesBottomBarWhenPushed=YES;
    _wenziController.title=@"对联经典";
    [self.navigationController pushViewController:_wenziController animated:YES];
}
@end
