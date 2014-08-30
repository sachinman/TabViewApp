//
//  ZSCFourthViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 5/29/13.
//
//

#import "ZSCFourthViewController.h"
#import "ShezhiTableCell.h"
#import "AboutViewController.h"
#import "AAMFeedbackViewController.h"
#import "BaiduSocialShareAPIControllerView.h"

@interface ZSCFourthViewController ()

@end

@implementation ZSCFourthViewController
@synthesize sectionNames=_sectionNames;
@synthesize childNames=_childNames;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"设置", @"设置");
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array=[[NSArray alloc]initWithObjects:@"设置",@"关于", nil];
    self.sectionNames=array;
    NSArray *array1=[[NSArray alloc]initWithObjects:@"清除历史数据库", @"分享平台授权",nil];
    NSArray *array2=[[NSArray alloc]initWithObjects:@"功能介绍",@"DMI研究中心", @"意见反馈",nil];
    NSDictionary *childDic=[[NSDictionary alloc]initWithObjectsAndKeys:array1,@"设置",array2,@"关于" ,nil];
    self.childNames=childDic;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tableView setBackgroundView:imgView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_sectionNames count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key=[_sectionNames objectAtIndex:section];
    NSArray *nameSection=[_childNames objectForKey:key];
    return [nameSection count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger section=[indexPath section];
    NSUInteger row=[indexPath row];
    
    NSString *key=[_sectionNames objectAtIndex:section];
    NSArray *nameSection=[_childNames objectForKey:key];
    
    static NSString *SectionTableIdentifier=@"ShezhiCellIdentifier";
    
    static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib *nib=[UINib nibWithNibName:@"ShezhiTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:SectionTableIdentifier];
        nibsRegistered=YES;
    }
    
    
    ShezhiTableCell *cell=[tableView dequeueReusableCellWithIdentifier:SectionTableIdentifier];
    /*
    if (cell==nil) {
        cell=[[ShezhiTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionTableIdentifier];
    }*/
    
    //cell.textLabel.text=[nameSection objectAtIndex:row];
    cell.baocunTitle=[nameSection objectAtIndex:row];
    if (section==1) {
        cell.baocunSwitch.hidden=YES;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (section==0) {
        cell.baocunSwitch.hidden=YES;
        if (row==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }        
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *key=[_sectionNames objectAtIndex:section];
    return key;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSUInteger row=[indexPath row];
    //NSUInteger section=[indexPath section];
    //if (row==0&&section==0) {
    //    return nil;
    //}
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row];
    NSUInteger section=[indexPath section];
    //NSLog(@"%d",section);
    //NSLog(@"%d",row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (section==0&&row==0) {
        UIAlertView *alterview=[[UIAlertView alloc]initWithTitle:@"警告" message:@"确定要删除历史对联生成记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterview show];
    }
    if (section==0&&row==1) {
        BaiduSocialShareAPIControllerView *apiController = [[BaiduSocialShareAPIControllerView alloc] initWithNibName:@"BaiduSocialShareAPIControllerView" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:apiController animated:YES];
        
    }
    if (section==1&&row==0) {
        AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
        vc.htmlName=@"app";
        vc.title=@"功能介绍";
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (section==1&&row==1) {
        AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
        vc.htmlName=@"about";
        vc.title=@"DMI研究中心";
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (section==1&&row==2) {
        AAMFeedbackViewController *vc = [[AAMFeedbackViewController alloc]init];
        vc.toRecipients = [NSArray arrayWithObject:@"f4-rf5u56@163.com"];
        vc.ccRecipients = nil;
        vc.bccRecipients = nil;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

#pragma mark -
#pragma mark Alert View  Methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self openDB];
        [self deleteTableNamed:@"Couplets"];
        [self createTableNamed:@"Couplets" withField1:@"class" withField2:@"input" withField3:@"output"];
        sqlite3_close(db);
    }
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
-(void)deleteTableNamed:(NSString *)tableName
{
    char *errorMsg;
    NSString *sqlStr = [NSString stringWithFormat:
                        @"DROP TABLE %@", tableName];
    if (sqlite3_exec(db, [sqlStr UTF8String], NULL, NULL, &errorMsg)
        != SQLITE_OK) {
        NSAssert(0, @"Tabled failed to delete.");
    }
    
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
