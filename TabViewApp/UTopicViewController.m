//
//  UTopicViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/27/13.
//
//

#import "UTopicViewController.h"
#import "DTopicViewController.h"

@interface UTopicViewController ()
{
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    
    NSXMLParser *xmlParser;
    BOOL elementFound;
    
}
@property (strong, nonatomic) DTopicViewController *xialianController;
@end

@implementation UTopicViewController
@synthesize message=_message;
@synthesize detailList=_detailList;
@synthesize lastIndexPath=_lastIndexPath;
@synthesize shangTableView=_shangTableView;
@synthesize selectedDuilian=_selectedDuilian;
@synthesize xialianController=_xialianController;

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
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithTitle:@"生成下联" style:UIBarButtonItemStylePlain target:self action:@selector(generateXialian:)];
    self.navigationItem.rightBarButtonItem=rightBar;
}
-(void)viewWillAppear:(BOOL)animated{

    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
    _detailList=[_message componentsSeparatedByString:NSLocalizedString(@",", nil)];
  
    [self.shangTableView reloadData];
    [super viewWillAppear:animated];
}

-(void)generateXialian:(NSString *)duiLian
{
    if (_selectedDuilian==nil) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"请选择一条上联!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    }else
    {
        NSString *soapMsg =
        [NSString stringWithFormat:
         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
         "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         "<soap:Body>"
         "<GetDownCouplet xmlns=\"http://tempuri.org/\">"
         "<_upline>%@</_upline>"
         "</GetDownCouplet>"
         "</soap:Body>"
         "</soap:Envelope>",  _selectedDuilian
         ];
        
        //---print it to the Debugger Console for verification---
        NSLog(@"%@",soapMsg);
        
        NSURL *url = [NSURL URLWithString: @"http://192.168.49.227/WebService1.asmx"];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        //---set the various headers---
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
        [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [req addValue:@"http://tempuri.org/GetDownCouplet" forHTTPHeaderField:@"SOAPAction"];
        [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        
        //---set the HTTP method and body---
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
        
        //[activityIndicator startAnimating];
        
        conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        if (conn) {
            webData = [NSMutableData data];
        }
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    
}

-(void) connection:(NSURLConnection *) connection
didReceiveResponse:(NSURLResponse *) response {
    [webData setLength: 0];
    expectedLength = [response expectedContentLength];
	currentLength = 0;
	HUD.mode = MBProgressHUDModeDeterminate;
}

-(void) connection:(NSURLConnection *) connection
    didReceiveData:(NSData *) data {
    [webData appendData:data];
    currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

-(void) connection:(NSURLConnection *) connection
  didFailWithError:(NSError *) error {
    //[webData release];
    //[connection release];
    webData=nil;
    connection=nil;
    [HUD hide:YES];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSLog(@"DONE. Received Bytes: %d", [webData length]);
    NSString *theXML = [[NSString alloc]
                        initWithBytes: [webData mutableBytes]
                        length:[webData length]
                        encoding:NSUTF8StringEncoding];
    //---shows the XML---
    NSLog(@"%@",theXML);
   	
    //[activityIndicator stopAnimating];
    
	//if (xmlParser) {
    //[xmlParser release];
    // }
	
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
}

//---when the start of an element is found---
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName
  namespaceURI:(NSString *) namespaceURI
 qualifiedName:(NSString *) qName
	attributes:(NSDictionary *) attributeDict {
    
    if( [elementName isEqualToString:@"GetDownCoupletResult"]) {
        if (!soapResults) {
            soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
}

//---when the text in an element is found---
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound)
    {
        [soapResults appendString: string];
    }
}

//---when the end of element is found---
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"GetDownCoupletResult"]) {
        //---displays the country---
        NSLog(@"%@",soapResults);
        
        NSArray *fenlian=[[NSArray alloc]init];
        fenlian=[soapResults componentsSeparatedByString:NSLocalizedString(@",", nil)];
        
        if ([fenlian count]>1) {
            if (_xialianController==nil) {
                _xialianController=[[DTopicViewController alloc]initWithNibName:@"DTopicViewController"bundle:nil];
            }
            _xialianController.title=@"生成结果";
            NSString *duilianResult=[[NSString alloc]initWithFormat:@"%@|%@",_selectedDuilian,soapResults];
            _xialianController.message=duilianResult;
            
            [self openDB];
            [self insertRecordIntoTableNamed:@"Couplets" withField1:@"class" field1Value:@"主题对联" andField2:@"input" field2Value:self.title andField3:@"output" field3Value:duilianResult];
            sqlite3_close(db);
            
            [self.navigationController pushViewController:_xialianController animated:YES];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"很抱歉,未能成功生成下联,换一句上联试试!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
                
        [soapResults setString:@""];
        elementFound = FALSE;
    }
    [HUD hide:YES afterDelay:0];
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
-(void)insertRecordIntoTableNamed:(NSString *)tableName withField1:(NSString *)field1 field1Value:(NSString *)field1Value andField2:(NSString *)field2 field2Value:(NSString *)field2Value andField3:(NSString *)field3 field3Value:(NSString *)field3Value{
    
    NSString *sqlStr = [NSString stringWithFormat:
                        @"INSERT OR REPLACE INTO '%@' ('%@', '%@', '%@') "
                        "VALUES (?,?,?)", tableName, field1, field2, field3];
    const char *sql = [sqlStr UTF8String];
    
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [field1Value UTF8String],
                          -1, NULL);
        sqlite3_bind_text(statement, 2, [field2Value UTF8String],
                          -1, NULL);
        sqlite3_bind_text(statement, 3, [field3Value UTF8String],
                          -1, NULL);
    }
    
    
    if (sqlite3_step(statement) != SQLITE_DONE)
        NSAssert(0, @"Error updating table.");
    sqlite3_finalize(statement);
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}

#pragma mark -
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_detailList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CheckMarkCellIdentifier=@"ShanglianIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CheckMarkCellIdentifier];
    
    
     if (cell==nil) {
     cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CheckMarkCellIdentifier];
     }
    
    NSUInteger row=[indexPath row];
    NSUInteger oldRow=[_lastIndexPath row];
    
    cell.textLabel.text=[_detailList objectAtIndex:row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
        
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
        NSLog(_selectedDuilian,nil);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setShangTableView:nil];
    [super viewDidUnload];
    self.message=nil;
    self.detailList=nil;
    self.lastIndexPath=nil;
    self.selectedDuilian=nil;
}
@end
