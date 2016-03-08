//
//  WelcomViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/5/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "WelcomViewController.h"
#import "SDCycleScrollView.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "JsonTool.h"
#import "ConfigTool.h"
#import "Pub.h"
#import "UIImageView+WebCache.h"
#import "FuncListViewController.h"
#import "HtmlViewController.h"

@interface WelcomViewController ()<SDCycleScrollViewDelegate,GMGridViewTransformationDelegate,GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewActionDelegate>
{
    GMGridView *_gmGridView;
    UINavigationController *_optionsNav;
    UIPopoverController *_optionsPopOver;
    
    NSMutableArray *modules;
    NSInteger _lastDeleteItemIndexAsked;
    UIView *deletedView;
}

@end

@implementation WelcomViewController
@synthesize bannerList;
-(void)loadData
{
    modules = [[NSMutableArray alloc] init];
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    NSMutableArray *funList=[[JsonTool defaultTool] getTFunctionInfoList:cacheString withKey:@"funList"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"fastFuncs"] ==nil)
    {
        NSMutableArray *temp=[[NSMutableArray alloc]init];
        NSArray *fastArray=[[NSArray alloc]init];
        for (int i=0; i<7; i++) {
            if(i==funList.count)
                break;
            TFunctionInfo *func=[funList objectAtIndex:i];
            [modules addObject:func];
            [temp addObject:func.PV_KY];
        }
        fastArray=[temp copy];
        [defaults setObject:fastArray forKey:@"fastFuncs"];
    }
    else
    {
        NSArray *fastArray= [defaults objectForKey:@"fastFuncs"];
        for (int i=0; i<fastArray.count; i++) {
            for (int j=0; j<funList.count; j++) {
                TFunctionInfo *func=[funList objectAtIndex:j];
                if([func.PV_KY isEqualToString:[fastArray objectAtIndex:i]])
                {
                    [modules addObject:func];
                }
            }
        }
    }
    
    
    TFunctionInfo *add=[[TFunctionInfo alloc]init];
    add.FUNC_ICON=@"btn_add_normal";
    add.FUNC_TYPE=@"add";
    [modules addObject:add];
    
    //    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    //    NSArray *array= [settings objectForKey:@"modules"];
    //    if(array !=nil)
    //    {
    //        NSMutableArray *moduleList=[[NSMutableArray alloc]init];
    //        for (NSObject *obj in array) {
    //            NSString *pvKY= [NSString stringWithFormat:@"%@",obj];
    //            for (NSObject * obj2 in moduleList) {
    //                TFunctionInfo *func=(TFunctionInfo*)obj2;
    //                if([func.PV_KY isEqualToString:pvKY])
    //                {
    //                    [moduleList addObject:func];
    //                }
    //            }
    //        }
    //        modules=moduleList;
    //    }
}

-(id)init
{
    if ((self =[super init]))
    {
        
        [self loadData];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [_gmGridView reloadData];
}

-(void)loadView
{
    [super loadView];
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icc_cs_bg_nav"]]];
    [self.view addSubview:navigationBarView];
    UIImageView *titleLogo=[[UIImageView alloc]initWithFrame:CGRectMake(40, 17, self.view.frame.size.width-80, 44)];
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *compID= [plistDic objectForKey:@"COMP_ID"];
    NSString *compICON=[NSString stringWithFormat:@"%@%@",@"comp_icon_",compID];
    [titleLogo setImage:[UIImage imageNamed:compICON]];
    [titleLogo setContentMode:UIViewContentModeScaleAspectFit];
    [navigationBarView addSubview:titleLogo];
    SDCycleScrollView *cycleScrollView ;
    CGFloat w = self.view.bounds.size.width;
    if(bannerList!=nil&&bannerList.count>0)
    {
        NSMutableArray *imgUrlArray=[[NSMutableArray alloc]init];
        for (Banner *banner in bannerList) {
            [imgUrlArray addObject:banner.IMG_PATH];
        }
        cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 160) imageURLStringsGroup:[imgUrlArray copy]];
    }
    else
    {
        AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        UIImage * img= [UIImage imageNamed:[NSString stringWithFormat:@"b1_%@",appDelegate.COMP_ID]];
        NSArray *imageArray=nil;
        if (img!=nil) {
            imageArray=[[NSArray alloc]initWithObjects:[UIImage imageNamed:[NSString stringWithFormat:@"b1_%@",appDelegate.COMP_ID]],[UIImage imageNamed:[NSString stringWithFormat:@"b2_%@",appDelegate.COMP_ID]],[UIImage imageNamed:[NSString stringWithFormat:@"b3_%@",appDelegate.COMP_ID]], nil];
        }
        else
        {
            imageArray=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"bimg1.jpg"],[UIImage imageNamed:@"bimg2.jpg"],[UIImage imageNamed:@"bimg3.jpg"], nil];
        }
        cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 160) imagesGroup:imageArray];
    }
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger spacing = 15;
    
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 210, w, 220)];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gmGridView];
    _gmGridView = gmGridView;
    
    _gmGridView.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.centerGrid = YES;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;
    //_gmGridView.enableEditOnLongPress=YES;
    //_gmGridView.disableEditOnEmptySpaceTap=YES;
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(bannerList!=nil&&bannerList.count!=0&&[bannerList objectAtIndex:index]!=nil)
    {
        Banner *banner= [bannerList objectAtIndex:index];
        if([banner.TYPE isEqualToString:@"跳转"])
        {
            if (![banner.IOS_CLASS isEqualToString:@""]) {
                id viewController=[[NSClassFromString(banner.IOS_CLASS)alloc]init];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else if(![banner.URL isEqualToString:@""])
            {
                HtmlViewController *vc=[[HtmlViewController alloc]init];
                vc.URL=banner.URL;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////
#pragma mark memory management
//////////////////////////////////////////////////////////////

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

//////////////////////////////////////////////////////////////
#pragma mark orientation management
//////////////////////////////////////////////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [modules count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    
    return CGSizeMake(60 , 80);
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    //CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    TFunctionInfo *func=(TFunctionInfo*)[modules objectAtIndex:index];
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"del.png"];
        cell.deleteButtonOffset = CGPointMake(-15, -15);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60 , 80)];
        //view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [icon sd_setImageWithURL:[NSURL URLWithString:func.FUNC_ICON]];
    [cell.contentView addSubview:icon];
    if([func.FUNC_TYPE isEqualToString:@"add"])
    {
        [icon setImage:[UIImage imageNamed:func.FUNC_ICON]];
        return  cell;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 60, 20)];
    label.text = func.FUNC_NAME;
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:label];
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    TFunctionInfo *func=(TFunctionInfo*)[modules objectAtIndex:position];
    if([func.FUNC_TYPE isEqualToString:@"add"])
    {
        FuncManageViewController *vc=[[FuncManageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        if(![func.IOS_CLASS isEqualToString:@""])
        {
            id viewController=[[NSClassFromString(func.IOS_CLASS)alloc]init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else
            [self.navigationController.view makeToast:@"参数错误！"];
    }
    NSLog(@"Did tap at index %d", position);
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
    
    _lastDeleteItemIndexAsked = index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [modules removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
    }
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSObject *object = [modules objectAtIndex:oldIndex];
    [modules removeObject:object];
    [modules insertObject:object atIndex:newIndex];
    NSLog(@"MOVE");
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    [modules exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    NSLog(@"ecchange");
}




//////////////////////////////////////////////////////////////
#pragma mark private methods
//////////////////////////////////////////////////////////////

- (void)addMoreItem
{
    // Example: adding object at the last position
    NSString *newItem = [NSString stringWithFormat:@"%d", (int)(arc4random() % 1000)];
    
    [modules addObject:newItem];
    [_gmGridView insertObjectAtIndex:[modules count] - 1 withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
}

- (void)removeItem
{
    // Example: removing last item
    if ([modules count] > 0)
    {
        NSInteger index = [modules count] - 1;
        
        [_gmGridView removeObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
        [modules removeObjectAtIndex:index];
    }
}

- (void)refreshItem
{
    // Example: reloading last item
    if ([modules count] > 0)
    {
        int index = [modules count] - 1;
        
        NSString *newMessage = [NSString stringWithFormat:@"%d", (arc4random() % 1000)];
        
        [modules replaceObjectAtIndex:index withObject:newMessage];
        [_gmGridView reloadObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
    }
}

- (void)presentInfo
{
    NSString *info = @"Long-press an item and its color will change; letting you know that you can now move it around. \n\nUsing two fingers, pinch/drag/rotate an item; zoom it enough and you will enter the fullsize mode";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                        message:info
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [alertView show];
}



@end
