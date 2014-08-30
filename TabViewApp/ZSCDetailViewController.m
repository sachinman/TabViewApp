//
//  ZSCDetailViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import "ZSCDetailViewController.h"
#import "DuilianDetailCell.h"
#import "DuilianhuaViewController.h"

@interface ZSCDetailViewController ()
@property (strong, nonatomic) DuilianhuaViewController *lianhuaController;

@end

@implementation ZSCDetailViewController

@synthesize inputStr=_inputStr;
@synthesize message=_message;
@synthesize className=_className;
@synthesize detailList=_detailList;
@synthesize lastIndexPath=_lastIndexPath;
@synthesize detailTableView=_detailTableView;
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
    [self.tableView setBackgroundView:imgView];
}

-(void)viewDidUnload
{
    [self setDetailTableView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    self.inputStr=nil;
    self.className=nil;
    self.message=nil;
    self.detailList=nil;
    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
    
}

-(void)viewWillAppear:(BOOL)animated{
   
    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
    //_detailList=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    
    if ([_className isEqualToString:@"下联应对"]&&_detailList==nil) {
        NSArray *fenlian=[[NSArray alloc]init];
        fenlian=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        NSArray *array=[[NSArray alloc]init];
        array=[[fenlian objectAtIndex:1] componentsSeparatedByString:NSLocalizedString(@",", nil)];
        NSString *duilian;        
        _detailList=[[NSMutableArray alloc]init];
        for (int i=0; i<[array count]; i++) {
            duilian=[[NSString alloc]initWithFormat:@"%@;%@",[fenlian objectAtIndex:0],[array objectAtIndex:i]];
            [_detailList addObject:duilian];
            //NSLog(duilian,nil);
        }        
    }
    if ([_className isEqualToString:@"嵌名对联"]&&_detailList==nil) {
        NSArray *array=[[NSArray alloc]init];
        array=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        _detailList=[[NSMutableArray alloc]initWithArray:array];
    }
    if ([_className isEqualToString:@"嵌名春联"]&&_detailList==nil) {
        NSArray *array=[[NSArray alloc]init];
        array=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        _detailList=[[NSMutableArray alloc]initWithArray:array];
        [_detailList removeObjectAtIndex:0];
    }
    if ([_className isEqualToString:@"职业春联"]&&_detailList==nil) {
        NSArray *array=[[NSArray alloc]init];
        array=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        _detailList=[[NSMutableArray alloc]initWithArray:array];
        [_detailList removeObjectAtIndex:0];
    }
    if ([_className isEqualToString:@"主题对联"]&&_detailList==nil) {
        NSArray *fenlian=[[NSArray alloc]init];
        fenlian=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        NSArray *array=[[NSArray alloc]init];
        array=[[fenlian objectAtIndex:1] componentsSeparatedByString:NSLocalizedString(@",", nil)];
        NSString *duilian;
        _detailList=[[NSMutableArray alloc]init];
        for (int i=0; i<[array count]; i++) {
            duilian=[[NSString alloc]initWithFormat:@"%@;%@",[fenlian objectAtIndex:0],[array objectAtIndex:i]];
            [_detailList addObject:duilian];
            //NSLog(duilian,nil);
        }
    }

    //NSLog(_message,nil);
    //NSLog(@"%@",_detailList);
    
    [self.detailTableView reloadData];
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    _detailList=nil;
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [_detailList count];
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
    
    /*
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CheckMarkCellIdentifier];
    }
     */
    
    NSUInteger row=[indexPath row];
    NSUInteger oldRow=[_lastIndexPath row];
    
    //cell.textLabel.text=[_detailList objectAtIndex:row];
    //cell.detailTextLabel.text=[_detailList objectAtIndex:row];
    //cell.detailTextLabel.textColor=[UIColor blackColor];
    
    NSString *duiLian=[[NSString alloc]initWithString:[_detailList objectAtIndex:row]];
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
        _selectedDuilian=[_detailList objectAtIndex:newRow];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}



@end
