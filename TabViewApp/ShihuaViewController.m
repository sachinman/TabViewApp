//
//  ShihuaViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/8/13.
//
//

#import "ShihuaViewController.h"
#import "WenZiViewController.h"

@interface ShihuaViewController ()
@property (strong, nonatomic) WenZiViewController *wenziController;
@end

@implementation ShihuaViewController
@synthesize shihuaData=_shihuaData;
@synthesize jiqiaoData=_jiqiaoData;
@synthesize viewPointer=_viewPointer;

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
    if (_viewPointer==1) {
        self.title=@"对联史话";
        NSArray *array=[[NSArray alloc]initWithObjects:@"对联简介", @"对联的起源",@"楹联简史",@"谈谈春联的历史",@"门神春联的由来",@"酒联趣谈",@"茶与楹联",nil];
        self.shihuaData=array;
    }else{
        self.title=@"对联技巧";
        NSArray *array=[[NSArray alloc]initWithObjects:@"浅谈对联格律",@"对联平仄的宽严", @"平仄简表",@"对联的艺术技巧",@"对联的特点与格式",@"对联的节奏与风格",@"对联的谋篇与创作",@"对联的句法与结构",@"对仗歌诀",@"对仗十七法",@"常见的对联修辞手法",@"对联的用字技巧",nil];
        self.jiqiaoData=array;
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tableView setBackgroundView:imgView];
    
    
}

-(void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    self.shihuaData=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_viewPointer==1) {
        return [self.shihuaData count];
    } 
    return [self.jiqiaoData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShihuaTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSUInteger row=[indexPath row];
    if (_viewPointer==1) {
        cell.textLabel.text=[_shihuaData objectAtIndex:row];
    } else {
        cell.textLabel.text=[_jiqiaoData objectAtIndex:row];
    }
    
    cell.textLabel.font=[UIFont fontWithName:@"System" size:17.0];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row];
    //NSLog(@"%d",row);
    if (_wenziController==nil) {
        _wenziController=[[WenZiViewController alloc]init];
    }
    
    if (_viewPointer==1) {
        _wenziController.title=[_shihuaData objectAtIndex:row];
        _wenziController.viewPointer=1;
    } else {
        _wenziController.title=[_jiqiaoData objectAtIndex:row];
        _wenziController.viewPointer=2;
    }
    _wenziController.listPointer=row;
    _wenziController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_wenziController animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

@end
