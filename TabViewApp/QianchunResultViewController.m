//
//  QianchunResultViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/27/13.
//
//

#import "QianchunResultViewController.h"
#import "DuilianhuaViewController.h"
#import "DuilianDetailCell.h"


@interface QianchunResultViewController ()
@property (strong, nonatomic) DuilianhuaViewController *lianhuaController;
@end

@implementation QianchunResultViewController
@synthesize message=_message;
@synthesize detailList=_detailList;
@synthesize lastIndexPath=_lastIndexPath;
@synthesize resultTableView=_resultTableView;
@synthesize selectedDuilian=_selectedDuilian;
@synthesize lianhuaController=_lianhuaController;

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
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithTitle:@"生成对联画" style:UIBarButtonItemStylePlain target:self action:@selector(generateLianhua:)];
    self.navigationItem.rightBarButtonItem=rightBar;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
}
-(void)viewWillAppear:(BOOL)animated{
    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
    _detailList=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    self.title=[_detailList objectAtIndex:0];
    if ([[_detailList objectAtIndex:0] isEqualToString:@"经典对联"]) {
        UIAlertView *alerts=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"很抱歉,未能生成对联，我们为您准备了经典对联！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alerts show];
    }
    
    [self.resultTableView reloadData];
    [super viewWillAppear:animated];
}
-(void)generateLianhua:(NSString *)duiLian
{
    if (_selectedDuilian==nil) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"请选择一条对联!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    }else
    {
        NSInteger length;
        length=[_selectedDuilian length];
        if (length==11||length==15||length==17||length==25) {
            
            if (_lianhuaController==nil) {
                _lianhuaController=[[DuilianhuaViewController alloc]initWithNibName:@"DuilianhuaViewController"bundle:nil];
            }
            _lianhuaController.title=@"对联画";
            
            _lianhuaController.duiLian=_selectedDuilian;
            _lianhuaController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:_lianhuaController animated:YES];
            NSLog(_selectedDuilian,nil);
            NSLog(@"---",nil);
            
        } else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"暂只支持单联长度为5、7、8、11的对联生成对联画!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
    }
    
}

#pragma mark -
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_detailList count]-1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CheckMarkCellIdentifier=@"DuilianDetailIdentifier";
    
    static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib *nib=[UINib nibWithNibName:@"DuilianDetailCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CheckMarkCellIdentifier];
        nibsRegistered=YES;
    }
    
    DuilianDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:CheckMarkCellIdentifier];
    
    NSUInteger row=[indexPath row];
    NSUInteger oldRow=[_lastIndexPath row];
    
    NSString *duiLian=[[NSString alloc]initWithString:[_detailList objectAtIndex:row+1]];
    NSArray *shangxiaLian=[[NSArray alloc]init];
    shangxiaLian=[duiLian componentsSeparatedByString:NSLocalizedString(@";", nil)];
    cell.shangLian=[shangxiaLian objectAtIndex:0];
    cell.xiaLian=[shangxiaLian objectAtIndex:1];
    
    cell.accessoryType=(row==oldRow&&_lastIndexPath!=nil)?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int newRow=[indexPath row];
    int oldRow=(_lastIndexPath!=nil)?[_lastIndexPath row]:-1;
    if (newRow!=oldRow) {
        UITableViewCell *newCell=[tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType=UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell=[tableView cellForRowAtIndexPath:_lastIndexPath];
        oldCell.accessoryType=UITableViewCellAccessoryNone;
        _lastIndexPath=indexPath;
        _selectedDuilian=[_detailList objectAtIndex:newRow+1];
        NSLog(_selectedDuilian,nil);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setResultTableView:nil];
    [super viewDidUnload];
    self.message=nil;
    self.detailList=nil;
    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
}
@end
