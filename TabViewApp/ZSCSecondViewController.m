//
//  ZSCSecondViewController.m
//  TabViewApp
//
//  Created by student on 13-5-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ZSCSecondViewController.h"
#import "XiaYingViewController.h"
#import "QianDuiViewController.h"
#import "QianChunViewController.h"
#import "JobChunViewController.h"
#import "ZhuDuiViewController.h"

@interface ZSCSecondViewController ()
@property (strong, nonatomic) XiaYingViewController *xiayingViewController;
@property (strong, nonatomic) QianDuiViewController *qianduiViewController;
@property (strong, nonatomic) QianChunViewController *qianchunViewController;
@property (strong, nonatomic) JobChunViewController *jobchunViewController;
@property (strong, nonatomic) ZhuDuiViewController *zhuduiViewController;

@end

@implementation ZSCSecondViewController
@synthesize xiayingViewController=_xiayingViewController;
@synthesize qianduiViewController=_qianduiViewController;
@synthesize qianchunViewController=_qianchunViewController;
@synthesize jobchunViewController=_jobchunViewController;
@synthesize zhuduiViewController=_zhuduiViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"生成", @"生成");
        self.tabBarItem.image = [UIImage imageNamed:@"brush"];
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
    [self openDB];
    [self createTableNamed:@"Couplets" withField1:@"class" withField2:@"input" withField3:@"output"];
    sqlite3_close(db);
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

-(NSString *) filePath {
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,                                                                                           NSUserDomainMask, YES);
    
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}

-(void) openDB {
    //—-create database—-
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open.");
    }
}

-(void) createTableNamed:(NSString *)tableName withField1:(NSString *)field1 withField2:(NSString *)field2 withField3:(NSString *)field3{
    char *err;
    
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' "
                     "TEXT, '%@' TEXT, '%@' TEXT);",
                     tableName, field1, field2, field3];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)
        != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Tabled failed to create.");
    }
}


- (IBAction)xialianYingduiClick:(id)sender {
    [UIView beginAnimations:@"viewFlip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    if (_xiayingViewController==nil) {
        _xiayingViewController=[[XiaYingViewController alloc]initWithNibName:@"XiaYingViewController" bundle:nil];
    }
    
    _xiayingViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_xiayingViewController animated:YES];
    [UIView commitAnimations];
    
    //NSLog(@"ssss",nil);
}

- (IBAction)qianmingDuilianClick:(id)sender {
    [UIView beginAnimations:@"viewFlip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    if (_qianduiViewController==nil) {
        _qianduiViewController=[[QianDuiViewController alloc]initWithNibName:@"QianDuiViewController" bundle:nil];
    }
    
    _qianduiViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_qianduiViewController animated:YES];
    [UIView commitAnimations];
}

- (IBAction)qianmingchunlianClick:(id)sender {
    [UIView beginAnimations:@"viewFlip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    if (_qianchunViewController==nil) {
        _qianchunViewController=[[QianChunViewController alloc]initWithNibName:@"QianChunViewController" bundle:nil];
    }
    
    _qianchunViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_qianchunViewController animated:YES];
    [UIView commitAnimations];
}

- (IBAction)zhiyechunlianClick:(id)sender {
    [UIView beginAnimations:@"viewFlip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    if (_jobchunViewController==nil) {
        _jobchunViewController=[[JobChunViewController alloc]initWithNibName:@"JobChunViewController" bundle:nil];
    }
    
    _jobchunViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_jobchunViewController animated:YES];
    [UIView commitAnimations];
}

- (IBAction)zhutiduilianClick:(id)sender {
    [UIView beginAnimations:@"viewFlip" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    if (_zhuduiViewController==nil) {
        _zhuduiViewController=[[ZhuDuiViewController alloc]initWithNibName:@"ZhuDuiViewController" bundle:nil];
    }
    
    _zhuduiViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_zhuduiViewController animated:YES];
    [UIView commitAnimations];
}

- (IBAction)yaoyiyaoClick:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
	
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
	
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}
@end
