//
//  ZhuDuiViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/6/13.
//
//

#import "ZhuDuiViewController.h"
#import "UTopicViewController.h"

@interface ZhuDuiViewController ()
{
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    
    NSXMLParser *xmlParser;
    BOOL elementFound;
    
}
@property (strong, nonatomic) UTopicViewController *childController;
@end

@implementation ZhuDuiViewController
@synthesize lengthField=_lengthField;
@synthesize topicField=_topicField;
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
    self.navigationItem.title=@"主题对联";
    _lengthField.delegate=self;
    _topicField.delegate=self;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
}

-(void)shengchengDuilian
{
    NSString *para=[[NSString alloc]initWithFormat:@"%@-%@",_topicField.text,_lengthField.text];
    NSString *soapMsg =
	[NSString stringWithFormat:
	 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
	 "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
	 "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
	 "<soap:Body>"
	 "<GetTopicCouplet xmlns=\"http://tempuri.org/\">"
	 "<para>%@</para>"
	 "</GetTopicCouplet>"
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
    [req addValue:@"http://tempuri.org/GetTopicCouplet" forHTTPHeaderField:@"SOAPAction"];
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
    
    if( [elementName isEqualToString:@"GetTopicCoupletResult"]) {
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
    if ([elementName isEqualToString:@"GetTopicCoupletResult"]) {
        //---displays the country---
        NSLog(@"%@",soapResults);
        
        NSArray *fenlian=[[NSArray alloc]init];
        fenlian=[soapResults componentsSeparatedByString:NSLocalizedString(@",", nil)];
        
        if ([fenlian count]>1) {
            if (_childController==nil) {
                _childController=[[UTopicViewController alloc]initWithNibName:@"UTopicViewController"bundle:nil];
            }
            NSString *para=[[NSString alloc]initWithFormat:@"%@-%@",_topicField.text,_lengthField.text];
            _childController.title=para;
            _childController.message=soapResults;
            
            [self.navigationController pushViewController:_childController animated:YES];
            
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"很抱歉,未能成功生成上联,换一个主题试试!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
        
        [soapResults setString:@""];
        elementFound = FALSE;
    }
    [HUD hide:YES afterDelay:0];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLengthField:nil];
    [self setTopicField:nil];
    [super viewDidUnload];
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
    [_lengthField resignFirstResponder];
    [_topicField resignFirstResponder];

}
-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}
@end
