//
//  BaiduSocialShareAPIControllerView.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 7/15/13.
//
//

#import "BaiduSocialShareAPIControllerView.h"
#import <BaiduSocialShare/BDSocialShareSDK.h>

@interface BaiduSocialShareAPIControllerView ()
@property (nonatomic,retain)NSArray *groupList;
@property (nonatomic,retain)NSArray *itemList;
@property (nonatomic,retain)NSDictionary *platforms;
@end

@implementation BaiduSocialShareAPIControllerView
@synthesize tableView = _tableView;
@synthesize groupList = _groupList;
@synthesize itemList = _itemList;
@synthesize platforms = _platforms;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.groupList = [NSArray arrayWithObjects:[NSString stringWithFormat:@"第三方平台授权"],[NSString stringWithFormat:@"分享设置"], nil];
        self.itemList = [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"新浪微博"],[NSString stringWithFormat:@"腾讯微博"],[NSString stringWithFormat:@"QQ空间"],[NSString stringWithFormat:@"人人网"],[NSString stringWithFormat:@"开心网"], nil],[NSArray arrayWithObjects:[NSString stringWithFormat:@"清除所有授权信息"], nil],nil];
        
        self.platforms = [NSDictionary dictionaryWithObjectsAndKeys:kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO,@"新浪微博",
                          kBD_SOCIAL_SHARE_PLATFORM_KAIXIN,@"开心网",
                          kBD_SOCIAL_SHARE_PLATFORM_QQZONE,@"QQ空间",
                          kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO,@"腾讯微博",
                          kBD_SOCIAL_SHARE_PLATFORM_RENREN,@"人人网",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"分享平台设置";
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tableView setBackgroundView:imgView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)authSwitchChangeHandler:(id)sender
{
    UISwitch *authSwitch = (UISwitch *)sender;
    if ([[authSwitch superview] isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)[authSwitch superview];
        NSString *shareType = [self.platforms objectForKey:cell.textLabel.text];
        if ([BDSocialShareSDK isAccessTokenValidWithShareType:shareType]) {
            [BDSocialShareSDK clearAuthorizeWithShareType:shareType];
        } else {
            [BDSocialShareSDK authorizeWithShareType:shareType result:
             ^(SHARE_RESULT requestResult, NSString *mediaType, id response, NSError *error) {
                 if (requestResult == BD_SOCIAL_SHARE_SUCCESS) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"授权成功" message:[NSString stringWithFormat:@"%@授权成功",shareType] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                     [alert show];
                     NSLog(@"%@授权成功",shareType);
                     authSwitch.on = YES;
                 } else if (requestResult == BD_SOCIAL_SHARE_CANCEL){
                     NSLog(@"%@授权取消",shareType);
                     authSwitch.on = NO;
                 } else if (requestResult == BD_SOCIAL_SHARE_FAIL){
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"授权失败" message:[NSString stringWithFormat:@"%@授权失败\n error code:%d;\n error message:%@",shareType,error.code,[error localizedDescription]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                     [alert show];
                     NSLog(@"%@授权失败\n error code:%d;\n error message:%@",shareType,error.code,[error localizedDescription]);
                     authSwitch.on = NO;
                 }
             }];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if (indexPath.section != 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"apicell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"apicell"];
        }
        
        cell.textLabel.text = [[self.itemList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"authcell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"authcell"];
            
            UISwitch *switchCtrl = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchCtrl sizeToFit];
            [switchCtrl addTarget:self action:@selector(authSwitchChangeHandler:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchCtrl;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[self.itemList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        
        UISwitch *switchCtrl = (UISwitch *)cell.accessoryView;
        switchCtrl.on = [BDSocialShareSDK isAccessTokenValidWithShareType:[self.platforms objectForKey:cell.textLabel.text]];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.itemList objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.itemList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.groupList objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            [BDSocialShareSDK clearAllAuthorize];
            [self.tableView reloadData];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清除成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        } 
    }
}



@end
