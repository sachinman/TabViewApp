//
//  ResultViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/23/13.
//
//

#import "ResultViewController.h"
#import "DuilianhuaViewController.h"
#import "DuilianDetailCell.h"

@interface ResultViewController ()
@property (strong, nonatomic) DuilianhuaViewController *lianhuaController;
@end

@implementation ResultViewController
@synthesize message=_message;
@synthesize detailList=_detailList;
@synthesize lastIndexPath=_lastIndexPath;
@synthesize resultTableView=_resultTableView;
@synthesize selectedDuilian=_selectedDuilian;
@synthesize lianhuaController=_lianhuaController;
@synthesize fenlian=_fenlian;

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
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
    _fenlian=[_message componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    _detailList=[[_fenlian objectAtIndex:1] componentsSeparatedByString:NSLocalizedString(@",", nil)];
    
    //NSLog(_message,nil);
    //NSLog(@"%@",_detailList);
    
    [self.resultTableView reloadData];
    [super viewWillAppear:animated];
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
    self.fenlian=nil;
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
    
    //NSString *duiLian=[[NSString alloc]initWithString:[_detailList objectAtIndex:row]];
    //NSArray *shangxiaLian=[[NSArray alloc]init];
    //shangxiaLian=[duiLian componentsSeparatedByString:NSLocalizedString(@";", nil)];
    cell.shangLian=[_fenlian objectAtIndex:0];
    cell.xiaLian=[_detailList objectAtIndex:row];
    
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
        _selectedDuilian=[[NSString alloc]initWithFormat:@"%@;%@",[_fenlian objectAtIndex:0],[_detailList objectAtIndex:newRow]];
        //_selectedDuilian=[_detailList objectAtIndex:newRow];
        NSLog(_selectedDuilian,nil);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

@end
