//
//  DuilianhuaViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/20/13.
//
//

#import "DuilianhuaViewController.h"
#import "ImagePickViewController.h"
#import <BaiduSocialShare/BDSocialShareSDK.h>
#import <QuartzCore/QuartzCore.h>

@interface DuilianhuaViewController (){
    CGFloat leftX;
    CGFloat rightX;
    CGFloat topY;
    CGFloat addY;
    CGFloat fontSize;
    NSInteger showTimes;
    NSInteger selectedImageId;
}
@property(strong, nonatomic) ImagePickViewController *imagePickController;

@end

@implementation DuilianhuaViewController
@synthesize duiLian=_duiLian;
@synthesize imageView=_imageView;
@synthesize zuobiaoData=_zuobiaoData;
@synthesize imagePickController=_imagePickController;

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
    //UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithTitle:@"保存与分享" style:UIBarButtonItemStylePlain target:self action:nil];
    //UIBarButtonItem *rightBar2=[[UIBarButtonItem alloc]initWithTitle:@"更换图片" style:UIBarButtonItemStylePlain target:self action:@selector(changImageView)];
    
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtnClick)];
    UIBarButtonItem *rightBar2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(changImageView)];
    
    NSArray *array=[[NSArray alloc]initWithObjects:rightBar ,rightBar2 ,nil];
    self.navigationItem.rightBarButtonItems=array;
    //self.navigationItem.rightBarButtonItem=rightBar;
    
    showTimes=1;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *useImage = [[UIImage alloc] init];
    
    if (showTimes==1) {
        useImage = [UIImage imageNamed:@"duilian_s1.png"];
        showTimes=2;
        selectedImageId=1;
    } else {
        
        //selectedImageId=12;
        
        NSString *imageName=[[NSString alloc]initWithString:[NSString stringWithFormat:@"duilian_s%d.png",selectedImageId]];
        useImage = [UIImage imageNamed:imageName];
    }
    NSRange range;
    range=[_duiLian rangeOfString:@","];
    if (range.location!=NSNotFound) {
        NSArray *chudouLian=[[NSArray alloc]init];
        chudouLian=[_duiLian componentsSeparatedByString:NSLocalizedString(@",", nil)];
        NSString *lianStr=[NSString stringWithFormat:@"%@%@%@",[chudouLian objectAtIndex:0],[chudouLian objectAtIndex:1],[chudouLian objectAtIndex:2]];
        _duiLian=lianStr;
    }
           
    _zuobiaoData=[self getZuobiaoDataFor:selectedImageId andLength:[_duiLian length]/2];
    leftX=[[_zuobiaoData objectAtIndex:0] floatValue];
    rightX=[[_zuobiaoData objectAtIndex:1] floatValue];
    topY=[[_zuobiaoData objectAtIndex:2] floatValue];
    addY=[[_zuobiaoData objectAtIndex:3] floatValue];
    fontSize=[[_zuobiaoData objectAtIndex:4] floatValue];
    
    //加文字
    [_imageView setImage:[self addText2:useImage withText:_duiLian]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}

-(void)passValue:(NSInteger)imageId
{
    selectedImageId=imageId;
}

-(void)shareBtnClick
{
    BDSocialShareEventHandler result = ^(SHARE_RESULT requestResult, NSString *shareType, id response, NSError *error)
    {
        if (requestResult == BD_SOCIAL_SHARE_SUCCESS) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"%@分享成功",shareType] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"%@分享成功",shareType);
        } else if (requestResult == BD_SOCIAL_SHARE_CANCEL){
            NSLog(@"分享取消");
        } else if (requestResult == BD_SOCIAL_SHARE_FAIL){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@分享失败\n error code:%d;\n error message:%@",shareType,error.code,[error localizedDescription]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"%@分享失败\n error code:%d;\n error message:%@",shareType,error.code,[error localizedDescription]);
        }
    };
    
    SHARE_MENU_STYLE style = BD_SOCIAL_SHARE_MENU_THEME_STYLE;
    
    NSString *descriptionStr=[NSString stringWithFormat:@"我使用智能对联生成客户端生成了一副对联：%@，大家快来看一看！",_duiLian];
    BDSocialShareContent *content = [BDSocialShareContent shareContentWithDescription:descriptionStr url:@"http://www.dmhci.net" title:@"智能对联生成"];
    [content addImageWithImageSource:_imageView.image imageUrl:nil];
    [content setWXShareContentType:BD_SOCIAL_SHARE_WX_CONTENT_TYPE_IMAGE];
    
    
    [BDSocialShareSDK showShareMenuWithShareContent:content menuStyle:style result:result];
    
    
}

-(void)changImageView
{
    
    if (_imagePickController==nil) {
        _imagePickController=[[ImagePickViewController alloc]initWithNibName:@"ImagePickViewController" bundle:nil];
    }
    _imagePickController.title=@"背景画";
    _imagePickController.delegate=self;
    
    _imagePickController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:_imagePickController animated:YES];
}


-(UIImage *)addText2:(UIImage *)img withText:(NSString *)duilian
{
    int w = img.size.width;
    int h = img.size.height;
    
    //NSLog(@"%d,%d",w,h);
    
    UIGraphicsBeginImageContext(img.size);
    [[UIColor blackColor]set];
    [img drawInRect:CGRectMake(0, 0, w, h)];
    
    NSLog(@"%d",[duilian length]);
    NSArray *shangxiaLian=[[NSArray alloc]init];
    shangxiaLian=[duilian componentsSeparatedByString:NSLocalizedString(@";", nil)];
    
    NSString *shangLian=[[NSString alloc]init];
    NSString *xiaLian=[[NSString alloc]init];
    shangLian=[shangxiaLian objectAtIndex:0];
    xiaLian=[shangxiaLian objectAtIndex:1];
    
    for (int i=0; i<[shangLian length]; i++) {
        unichar c=[shangLian characterAtIndex:i];
        unichar cc[1];
        cc[0]=c;
        NSString *tre=[NSString stringWithCharacters:cc length:1];
        [tre drawAtPoint:CGPointMake(leftX, topY+i*addY) withFont:[UIFont systemFontOfSize:fontSize]];
    }
    for (int j=0; j<[xiaLian length]; j++) {
        unichar c=[xiaLian characterAtIndex:j];
        unichar cc[1];
        cc[0]=c;
        NSString *tre=[NSString stringWithCharacters:cc length:1];
        [tre drawAtPoint:CGPointMake(rightX, topY+j*addY) withFont:[UIFont systemFontOfSize:fontSize]];
    }
    
    
    UIImage *aimg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}

-(NSArray *)getZuobiaoDataFor:(NSInteger)imageId andLength:(NSInteger)length
{
    NSArray *array;
    
    if (imageId==1) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:25],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:25],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18.5], [NSNumber numberWithFloat:201.5],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==2) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:25],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:25],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18.5], [NSNumber numberWithFloat:201.5],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==3) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:195],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:23],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:23],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:40],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==4) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:58],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:49],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:25],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:49],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:25],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:200],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:22],nil];
        }
    }
    if (imageId==5) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:57],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:48],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:48],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:22],nil];
        }
    }
    if (imageId==6) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:195],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:23],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:23],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:23], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==7) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:25],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:25],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18.5], [NSNumber numberWithFloat:201.5],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==8) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:195],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:23],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:23],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:40],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==9) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:200],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:200],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:24],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:200],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:24],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18], [NSNumber numberWithFloat:201],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:21],nil];
        }
    }
    if (imageId==10) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:53],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:54],[NSNumber numberWithFloat:31],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:50],[NSNumber numberWithFloat:28],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:21],nil];
        }
    }
    if (imageId==11) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:65],[NSNumber numberWithFloat:43],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:61],[NSNumber numberWithFloat:31],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:58],[NSNumber numberWithFloat:28],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:21],nil];
        }
    }
    if (imageId==12) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:23], [NSNumber numberWithFloat:192],[NSNumber numberWithFloat:70],[NSNumber numberWithFloat:43],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:24], [NSNumber numberWithFloat:193],[NSNumber numberWithFloat:65],[NSNumber numberWithFloat:31],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:24], [NSNumber numberWithFloat:193],[NSNumber numberWithFloat:65],[NSNumber numberWithFloat:27],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:24], [NSNumber numberWithFloat:193],[NSNumber numberWithFloat:62],[NSNumber numberWithFloat:20],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==13) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:58],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:58],[NSNumber numberWithFloat:31],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:58],[NSNumber numberWithFloat:27],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:54],[NSNumber numberWithFloat:20],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==14) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:47],[NSNumber numberWithFloat:25],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:35],[NSNumber numberWithFloat:25],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:16], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:30],[NSNumber numberWithFloat:25],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18.5], [NSNumber numberWithFloat:201.5],[NSNumber numberWithFloat:42],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:20],nil];
        }
    }
    if (imageId==15) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18], [NSNumber numberWithFloat:196],[NSNumber numberWithFloat:58],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:33],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:55],[NSNumber numberWithFloat:28],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:22],nil];
        }
    }
    if (imageId==16) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:18], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:62],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:57],[NSNumber numberWithFloat:33],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:57],[NSNumber numberWithFloat:28],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:19], [NSNumber numberWithFloat:199],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:22],[NSNumber numberWithFloat:21],nil];
        }
    }
    if (imageId==17) {
        if (length==5) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:20], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:63],[NSNumber numberWithFloat:45],[NSNumber numberWithFloat:24],nil];
        }
        if (length==7) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:59],[NSNumber numberWithFloat:32],[NSNumber numberWithFloat:22],nil];
        }
        if (length==8) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:21], [NSNumber numberWithFloat:197],[NSNumber numberWithFloat:60],[NSNumber numberWithFloat:27],[NSNumber numberWithFloat:22],nil];
        }
        if (length==11) {
            array=[NSArray arrayWithObjects:[NSNumber numberWithFloat:22], [NSNumber numberWithFloat:198],[NSNumber numberWithFloat:57],[NSNumber numberWithFloat:20],[NSNumber numberWithFloat:20],nil];
        }
    }
    return array;
}

@end
