//
//  WenZiViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/9/13.
//
//

#import "WenZiViewController.h"

@interface WenZiViewController ()
@property (strong, nonatomic) NSString *fullPath;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *array1Text;
@property (strong, nonatomic) NSArray *array2Text;
@end

@implementation WenZiViewController
@synthesize scrollView=_scrollView;
@synthesize wenziLabel=_wenziLabel;
@synthesize listPointer=_listPointer;
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
    NSArray *array1=[[NSArray alloc]initWithObjects:@"duilianjianshi", @"duilianqiyuan",@"yinglianjianshi",@"chunlianlishi",@"menshenchunlian",@"jiulianqutan",@"chayuyinglian",nil];
    _array1Text=[[NSArray alloc]initWithArray:array1];
    NSArray *array2=[[NSArray alloc]initWithObjects:@"duiliangelv",@"pingzekuanyan",@"pingzejianbiao",@"yishujiqiao",@"tediangeshi",@"jiezoufengge",@"moupianchuangzuo",@"jufajiegou",@"duizhanggejue",@"shiqifa",@"xiucishoufa",@"yongzijiqiao",nil];
    _array2Text=[[NSArray alloc]initWithArray:array2];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back-568h.png"]]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_viewPointer==1) {
        _fullPath = [[NSBundle mainBundle] pathForResource:[_array1Text objectAtIndex:_listPointer] ofType:@"txt"];
    } else if(_viewPointer==2){
        _fullPath = [[NSBundle mainBundle] pathForResource:[_array2Text objectAtIndex:_listPointer] ofType:@"txt"];
    }else{
        _fullPath = [[NSBundle mainBundle] pathForResource:@"fillerati" ofType:@"txt"];
        //NSLog(_fullPath,nil);
    }
    _text = [NSString stringWithContentsOfFile:_fullPath
                                      encoding:NSUTF8StringEncoding
                                         error:nil];
    
    _wenziLabel.text=_text;
    _wenziLabel.numberOfLines=0;
    _wenziLabel.frame=CGRectMake(20, 20, 280, 376);
    [_wenziLabel sizeToFit];
    //NSLog(_wenziLabel.text,nil);
    _scrollView.frame=CGRectMake(0, 0, 320, 416);
    [_scrollView setContentSize:self.wenziLabel.frame.size];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setWenziLabel:nil];
    [super viewDidUnload];
}
@end
