//
//  ImagePickViewController.m
//  TabViewApp
//
//  Created by Shicheng Zhang on 6/21/13.
//
//

#import "ImagePickViewController.h"
#import "ImagePickCell.h"

@interface ImagePickViewController ()
{
    NSInteger selectedId;
}
@end

@implementation ImagePickViewController
@synthesize delegate;

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
    
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okClick)];
    self.navigationItem.rightBarButtonItem=rightBar;
    
    
    [self.collectionView registerClass:[ImagePickCell class] forCellWithReuseIdentifier:@"simpleCell"];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(144, 158)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 2, 0, 0);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.collectionView setBackgroundView:imgView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    selectedId=0;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 17;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    static NSString *cellIdentifier=@"simpleCell";
    // Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    ImagePickCell *cell=(ImagePickCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    // make the cell's title the actual NSIndexPath value
    cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row+1, (long)indexPath.section];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"duilian_s%d.png", indexPath.row+1];
    cell.image.image = [UIImage imageNamed:imageToLoad];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedId=[indexPath row]+1;
}

-(void)okClick
{
    if (selectedId==0) {
        //[self.navigationController popToRootViewControllerAnimated:YES];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"敬告" message:@"请选择一幅图片!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }else
    {
        [delegate passValue:selectedId];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCollectionView:nil];
    [super viewDidUnload];
}
@end
