//
//  AssistantViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/5/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "AssistantViewController.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "JsonTool.h"
#import "TFunctionInfo.h"
#import "Pub.h"
#import "UIImageView+WebCache.h"
#import "UIView+Toast.h"
@interface AssistantViewController ()<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>
{
    
    GMGridView *_gmGridView;
    UINavigationController *_optionsNav;
    UIPopoverController *_optionsPopOver;
    
    NSMutableArray *assistantFuncs;
    NSInteger _lastDeleteItemIndexAsked;
}
@end

@implementation AssistantViewController


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
    
    
    assistantFuncs=[[NSMutableArray alloc]init];
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    NSMutableArray *funList=[[JsonTool defaultTool] getTFunctionInfoList:cacheString withKey:@"funList"];
    for (int i=0; i<[funList count]; i++) {
        TFunctionInfo *funcs=(TFunctionInfo*) [funList objectAtIndex:i];
        if([funcs.FUNC_TYPE isEqualToString:@"助手"])
        {
            [assistantFuncs addObject:funcs];
        }
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger spacing = 15;
    
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 64 , self.view.frame.size.width, self.view.frame.size.height-74)];
    //gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gmGridView];
    _gmGridView = gmGridView;
    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.actionDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;
    _gmGridView.centerGrid=NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _gmGridView.mainSuperView = self.navigationController.view;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [assistantFuncs count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(60, 80);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"del.png"];
        cell.deleteButtonOffset = CGPointMake(-10, -10);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    TFunctionInfo *func= (TFunctionInfo *)[assistantFuncs objectAtIndex:index];
    
    CGRect imageFrame=CGRectMake(0, 0, size.width, size.width);
    UIImageView *image=[[UIImageView alloc]initWithFrame:imageFrame];
    [image setImageWithURL:func.FUNC_ICON];
    [cell.contentView addSubview:image];
    
    CGRect labelFrame=CGRectMake(0, 60 , 60, 20);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    //label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text =func.FUNC_NAME;
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
    TFunctionInfo *func=[assistantFuncs objectAtIndex:position];
    if(![func.IOS_CLASS isEqualToString:@""])
    {
        id viewController=[[NSClassFromString(func.IOS_CLASS)alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [self.navigationController.view makeToast:@"参数错误！"];
    }
    NSLog(@"Did tap at index %d", position);
}
@end
