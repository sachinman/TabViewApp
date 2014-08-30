//
//  QianDuiViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/1/13.
//
//

#import "QianDuiViewController.h"
#import "QianduiResultViewController.h"

@interface QianDuiViewController ()
{
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    
    NSXMLParser *xmlParser;
    BOOL elementFound;
    
}
@property (strong, nonatomic) QianduiResultViewController *childController;
@end

@implementation QianDuiViewController
@synthesize shangziField=_shangziField;
@synthesize xiaziField=_xiaziField;
@synthesize childController=_childController;

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
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(shengchengDuilian)];
    self.navigationItem.rightBarButtonItem=rightBar;
    self.navigationItem.title=@"嵌名对联";
    _shangziField.delegate=self;
    _xiaziField.delegate=self;
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
}

-(void)shengchengDuilian
{
    NSString *para=[[NSString alloc]initWithFormat:@"%@%@",_shangziField.text,_xiaziField.text];
    NSString *soapMsg =
	[NSString stringWithFormat:
	 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
	 "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
	 "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
	 "<soap:Body>"
	 "<GetNameCouplet xmlns=\"http://tempuri.org/\">"
	 "<para>%@</para>"
	 "</GetNameCouplet>"
	 "</soap:Body>"
	 "</soap:Envelope>",  para
	 ];
	
    //---print it to the Debugger Console for verification---
    NSLog(@"%@",soapMsg);
    
    NSURL *url = [NSURL URLWithString: @"http://192.168.49.227/WebService1.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	
    //---set the various headers---
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://tempuri.org/GetNameCouplet" forHTTPHeaderField:@"SOAPAction"];
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
    
    if( [elementName isEqualToString:@"GetNameCoupletResult"]) {
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
    if ([elementName isEqualToString:@"GetNameCoupletResult"]) {
        //---displays the country---
        NSLog(@"%@",soapResults);
        
        NSArray *fenlian=[[NSArray alloc]init];
        fenlian=[soapResults componentsSeparatedByString:NSLocalizedString(@"|", nil)];
        
        if ([fenlian count]>1) {
            
            if (_childController==nil) {
                _childController=[[QianduiResultViewController alloc]initWithNibName:@"QianduiResultViewController"bundle:nil];
            }
            NSString *para=[[NSString alloc]initWithFormat:@"%@%@",_shangziField.text,_xiaziField.text];
            _childController.title=para;
            _childController.message =soapResults;
            
            [self openDB];
            [self insertRecordIntoTableNamed:@"Couplets" withField1:@"class" field1Value:@"嵌名对联" andField2:@"input" field2Value:para andField3:@"output" field3Value:soapResults];
            sqlite3_close(db);
            
            [self.navigationController pushViewController:_childController animated:YES];
            
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"很抱歉,未能成功生成对联,换一个名字试试!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
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

int prewTag;
float prewMoveY;
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (prewTag==-1) {
        return;
    }
    float moveY;
    NSTimeInterval animationDuration=0.30f;
    CGRect frame=self.view.frame;
    if (prewTag==textField.tag) {
        moveY=prewMoveY;
        frame.origin.y+=moveY;
        frame.size.height-=moveY;
        self.view.frame=frame;
    }
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame=frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFrame=textField.frame;
    float textY=textFrame.origin.y+textFrame.size.height;
    float bottomY=self.view.frame.size.height-textY;
    //NSLog(@"%f",bottomY);
    //判断当前的高度是否已经有256，如果超过了就不需要再移动主界面的view高度
    if (bottomY>=256) {
        prewTag=-1;
        return;
    }
    prewTag=textField.tag;
    float moveY=256-bottomY;
    prewMoveY=moveY;
    
    NSTimeInterval animationDuration=0.30f;
    CGRect frame=self.view.frame;
    frame.origin.y-=moveY; //view的y轴上移
    frame.size.height+=moveY; //view的高度增加
    self.view.frame=frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame=frame;
    [UIView commitAnimations];
    
}
-(IBAction)backgroundTap:(id)sender
{
    [_shangziField resignFirstResponder];
    [_xiaziField resignFirstResponder];
}
-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setShangziField:nil];
    [self setXiaziField:nil];
    [super viewDidUnload];
}
@end
