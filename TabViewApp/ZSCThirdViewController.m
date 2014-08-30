//
//  ZSCThirdViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/1/13.
//
//

#import "ZSCThirdViewController.h"
#import "ZSCDetailViewController.h"
#import "LishiDuilianCell.h"

@interface ZSCThirdViewController ()

@property (strong, nonatomic) ZSCDetailViewController *childController;
@end

@implementation ZSCThirdViewController
@synthesize list=_list;
@synthesize childController=_childController;
@synthesize duilianList=_duilianList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //self.tabBarItem.image = [UIImage imageNamed:@"historical"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIBarButtonItem *editButton=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEdit:)];
    self.navigationItem.rightBarButtonItem=editButton;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tableView setBackgroundView:imgView];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (_duilianList==nil) {
        
        _duilianList=[[NSMutableArray alloc]init];
        [self openDB];
        [self getAllRowsFromTableNamed:@"Couplets"];
        sqlite3_close(db);
        
    }else
    {
        _duilianList=nil;
        _duilianList=[[NSMutableArray alloc]init];
        [self openDB];
        [self getAllRowsFromTableNamed:@"Couplets"];
        sqlite3_close(db);
        
    }
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(void)viewDidUnload{
    [super viewDidUnload];
    //self.list=nil;
    self.childController=nil;
    self.duilianList=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toggleEdit:(id)sender{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:@"删除"];
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

-(void) getAllRowsFromTableNamed: (NSString *) tableName {
    //—-retrieve rows—-
    NSString *qsql = [NSString stringWithFormat:@"SELECT * FROM %@",
                      tableName];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( db, [qsql UTF8String], -1,
                           &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *field0 = (char *) sqlite3_column_text(statement, 0);
            NSString *field0Str =
            [[NSString alloc] initWithUTF8String: field0];
            
            char *field1 = (char *) sqlite3_column_text(statement, 1);
            NSString *field1Str =
            [[NSString alloc] initWithUTF8String: field1];
            
            char *field2 = (char *) sqlite3_column_text(statement, 2);
            NSString *field2Str =
            [[NSString alloc] initWithUTF8String: field2];
            
            char *field3 = (char *) sqlite3_column_text(statement, 3);
            NSString *field3Str =
            [[NSString alloc] initWithUTF8String: field3];
            
            NSDictionary *row=[[NSDictionary alloc]initWithObjectsAndKeys:field0Str,@"id",field1Str,@"class",field2Str,@"input" ,field3Str,@"output" ,nil];
            [_duilianList addObject:row];
            
            
            //NSString *str = [[NSString alloc] initWithFormat:@"%@v%@v%@",
             //                field1Str, field2Str, field3Str];
            //NSLog(@"%@", str);
            
        }
        
        //—-deletes the compiled statement from memory—-
        sqlite3_finalize(statement);
    }
}
-(void)deleteOneFromTableNamed:(NSString *)tableName withId:(NSInteger)itemId
{
    char *errorMsg;
    NSString *sqlStr = [NSString stringWithFormat:
                        @"DELETE FROM %@ WHERE ID = %d", tableName, itemId];
    if (sqlite3_exec(db, [sqlStr UTF8String], NULL, NULL, &errorMsg)
        != SQLITE_OK) {
        NSAssert(0, @"Tabled failed to delete.");
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [_list count];
    return [_duilianList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";
    static BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib *nib=[UINib nibWithNibName:@"LishiDuilianCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered=YES;
    }
    
    LishiDuilianCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    /*
    if (cell == nil) {
        cell = [[LishiDuilianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }*/
    
    // Configure the cell...
    NSUInteger row=[indexPath row];
    NSDictionary *rowData=[self.duilianList objectAtIndex:row];
   
    //[cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-568h.png"]]];
    cell.titleName=[rowData objectForKey:@"input"];
    cell.duiLian=[rowData objectForKey:@"output"];
    //cell.classLabel.text=[rowData objectForKey:@"id"];
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    // load the image for this cell
    NSString *iconName=[[NSString alloc]init];
    if ([[rowData objectForKey:@"class"]isEqualToString:@"下联应对"]) {
        iconName=@"xiaying";
    }
    if ([[rowData objectForKey:@"class"]isEqualToString:@"嵌名对联"]) {
        iconName=@"qiandui";
    }
    if ([[rowData objectForKey:@"class"]isEqualToString:@"嵌名春联"]) {
        iconName=@"qianchun";
    }
    if ([[rowData objectForKey:@"class"]isEqualToString:@"主题对联"]) {
        iconName=@"zhudui";
    }
    if ([[rowData objectForKey:@"class"]isEqualToString:@"职业春联"]) {
        iconName=@"jobchun";
    }
    if ([[rowData objectForKey:@"class"]isEqualToString:@"摇一摇"]) {
        iconName=@"yaoyao";
    }
    
    NSString *imageToLoad = [NSString stringWithFormat:@"%@.png", iconName];
    cell.classImage.image = [UIImage imageNamed:imageToLoad];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=[indexPath row];
    NSString *idStr=[NSString stringWithString:[[_duilianList objectAtIndex:row]objectForKey:@"id"]];
    NSInteger idNum=[idStr integerValue];
    [self openDB];
    [self deleteOneFromTableNamed:@"Couplets" withId:idNum];
    sqlite3_close(db);
    [self.duilianList removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (_childController==nil) {
        _childController=[[ZSCDetailViewController alloc]initWithNibName:@"ZSCDetailViewController"bundle:nil];
    }
    _childController.title=@"详细•选择";
    NSUInteger row=[indexPath row];
    
    NSDictionary *rowData=[self.duilianList objectAtIndex:row];
    NSString *detailMessage=[[NSString alloc]initWithString:[rowData objectForKey:@"output"]];
    NSString *className=[[NSString alloc]initWithString:[rowData objectForKey:@"class"]];
    NSString *inputStr=[[NSString alloc]initWithString:[rowData objectForKey:@"input"]];
    _childController.inputStr=inputStr;
    _childController.className=className;
    _childController.message=detailMessage;
    
    [self.navigationController pushViewController:_childController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}

@end
