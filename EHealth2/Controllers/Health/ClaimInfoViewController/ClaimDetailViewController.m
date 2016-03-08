//
//  ClaimDetailViewController.m
//  citic
//
//  Created by echoliu on 15-4-14.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ClaimDetailViewController.h"

#import "Pub.h" 
#import "CommonUtil.h"
#import "MyCaseTableViewCell.h"
#import "QuckClaimsViewController.h"
#import "TClaimInfo.h"
#import "ClaimDetailTableViewCell.h"
#import "InvoiceListViewController.h"
#import "ImageListViewController.h"
@interface ClaimDetailViewController ()
{
    //未完成列表
    NSMutableArray * mlist;
    //待初审列表
    NSMutableArray * mlist1;
}
- (void)backToPreViewController;
- (void)homeCaseButtonClick;
- (void)segmentAction:(UISegmentedControl *)segment;
//by fishpro
-(void )reloadData;
@end

@implementation ClaimDetailViewController
@synthesize CLIM_INSURED_NAME_Label;
@synthesize  PSPS_DT_Label;
@synthesize CLIM_RETURN_DT_Label;
@synthesize bank;
@synthesize accno;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"责任信息"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
//    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 27.0, 30.0, 30.0)];
//    [homeButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_home_icon"] forState:UIControlStateNormal];
//    [homeButton addTarget:self
//                   action:@selector(homeCaseButtonClick)
//         forControlEvents:UIControlEventTouchUpInside];
//    [navigationBarView addSubview:homeButton];
    
    //定义个基本信息-------

    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.frame.size.width, 105.0)];
    [topImageView setImage:[UIImage imageNamed:@"mycase_topview_bg.png"]];
    [topImageView setUserInteractionEnabled:YES];
    [self.view addSubview:topImageView];
    //第一行
    UILabel *memeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 60, 20)];
    [memeLabel setBackgroundColor:[UIColor clearColor]];
    [memeLabel setTextColor:[UIColor blackColor]];
    [memeLabel setText:@"被保人"];
    [memeLabel setFont:[UIFont systemFontOfSize:13]];
    [memeLabel setTextAlignment:NSTextAlignmentLeft];
    [topImageView addSubview:memeLabel];
    
    if (self.CLIM_INSURED_NAME_Label == nil) {
        CLIM_INSURED_NAME_Label = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 70, 20)];
    }
    
    [CLIM_INSURED_NAME_Label setTextAlignment:NSTextAlignmentLeft];
    [CLIM_INSURED_NAME_Label setTextColor:[UIColor blackColor]];
    [CLIM_INSURED_NAME_Label setText:@"-"];
    [CLIM_INSURED_NAME_Label setFont:[UIFont systemFontOfSize:13]];
    [topImageView addSubview:CLIM_INSURED_NAME_Label];

    UILabel *returnLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 5, 65, 20)];
    [returnLabel setBackgroundColor:[UIColor clearColor]];
    [returnLabel setTextColor:[UIColor blackColor]];
    [returnLabel setText:@"结案时间"];
    [returnLabel setFont:[UIFont systemFontOfSize:13]];
    [returnLabel setTextAlignment:NSTextAlignmentLeft];
    [topImageView addSubview:returnLabel];
    
    if (self.CLIM_RETURN_DT_Label == nil) {
        CLIM_RETURN_DT_Label = [[UILabel alloc] initWithFrame:CGRectMake(225, 5, 80, 20)];
    }
    
    [CLIM_RETURN_DT_Label setTextAlignment:NSTextAlignmentLeft];
    [CLIM_RETURN_DT_Label setTextColor:[UIColor blackColor]];
    [CLIM_RETURN_DT_Label setText:@"-"];
    [CLIM_RETURN_DT_Label setFont:[UIFont systemFontOfSize:13]];
    [topImageView addSubview:CLIM_RETURN_DT_Label];
    
    //第二行
    UILabel *pspsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 60, 20)];
    [pspsLabel setBackgroundColor:[UIColor clearColor]];
    [pspsLabel setTextColor:[UIColor blackColor]];
    [pspsLabel setText:@"保险年度"];
    [pspsLabel setFont:[UIFont systemFontOfSize:13]];
    [pspsLabel setTextAlignment:NSTextAlignmentLeft];
    [topImageView addSubview:pspsLabel];
    
    if (self.PSPS_DT_Label == nil) {
        PSPS_DT_Label = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 170, 20)];
    }
    
    [PSPS_DT_Label setTextAlignment:NSTextAlignmentLeft];
    [PSPS_DT_Label setTextColor:[UIColor blackColor]];
    [PSPS_DT_Label setText:@"-"];
    [PSPS_DT_Label setFont:[UIFont systemFontOfSize:13]];
    [topImageView addSubview:PSPS_DT_Label];

    UILabel *bankLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 55, 60, 20)];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setTextColor:[UIColor blackColor]];
    [bankLabel setText:@"开户行"];
    [bankLabel setFont:[UIFont systemFontOfSize:13]];
    [bankLabel setTextAlignment:NSTextAlignmentLeft];
    [topImageView addSubview:bankLabel];

    bank = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, 170, 20)];
    [bank setTextAlignment:NSTextAlignmentLeft];
    [bank setTextColor:[UIColor blackColor]];
    [bank setText:@"-"];
    [bank setFont:[UIFont systemFontOfSize:13]];
    [topImageView addSubview:bank];
    
    UILabel *accnoLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 80, 60, 20)];
    [accnoLabel setBackgroundColor:[UIColor clearColor]];
    [accnoLabel setTextColor:[UIColor blackColor]];
    [accnoLabel setText:@"银行账号"];
    [accnoLabel setFont:[UIFont systemFontOfSize:13]];
    [accnoLabel setTextAlignment:NSTextAlignmentLeft];
    [topImageView addSubview:accnoLabel];

    accno = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 170, 20)];
    [accno setTextAlignment:NSTextAlignmentLeft];
    [accno setTextColor:[UIColor blackColor]];
    [accno setText:@"-"];
    [accno setFont:[UIFont systemFontOfSize:13]];
    [topImageView addSubview:accno];
    //第二行button
    
    
    
        //初始化表格
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, topImageView.frame.origin.y+topImageView.frame.size.height, self.view.frame.size.height, self.view.frame.size.height-(topImageView.frame.origin.y+topImageView.frame.size.height)-50) style:UITableViewStylePlain];
    [mainTableView setRowHeight:70];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [self.view addSubview:mainTableView];
    //初始化底部的按钮
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,(self.view.frame.size.height - 50),self.view.frame.size.width,50)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[UIImage imageNamed:@"mycase_bottom_task_bg.png"]];
    [self.view addSubview:bottomView];
    
    UIButton *quckClaimsButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2.0, 7.5, 140, 35)];
    [quckClaimsButton setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [quckClaimsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quckClaimsButton setTitle:@"查看赔案影像" forState:UIControlStateNormal];
    [quckClaimsButton addTarget:self
                         action:@selector(claimsButtonClick)
               forControlEvents:UIControlEventTouchUpInside];    [bottomView addSubview:quckClaimsButton];
    
    //test data
    [self reloadData];
    
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)homeCaseButtonClick
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[HomeViewController class]]) {
//            [self.navigationController popToViewController:controller
//                                                  animated:YES];
//        }
    }
}

//分段控件的事件 的按钮事件
- (void)segmentAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)index);
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}


//03.表格相关事件
#pragma mark --
#pragma mark -- UITableViewDelegate UITableViewDataSource
//表格分组事件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//表格最大行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mlist count];
}

//单元格cell初始化
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    //注意这里自定义了Cell
    ClaimDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[ClaimDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    TDutybaseInfo *model=[[TDutybaseInfo alloc] init];
    model=mlist[rowNum];
    [cell setCellValue:model ];
    return cell;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger rowNum = [indexPath row];
    TDutybaseInfo *paperModel = mlist[rowNum];
    InvoiceListViewController *cellView=[[InvoiceListViewController alloc]init];
    [cellView setCurrentDutybaseInfo:paperModel];
    [self.navigationController pushViewController:cellView animated:YES];
    
}


/**
 * 高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ClaimDetailTableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 240;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载数据
-(void)reloadData{
    //set model
    if (self.currentClaimInfo!=nil) {
        self.CLIM_INSURED_NAME_Label.text=self.currentClaimInfo.CLIM_INSURED_NAME;
        self.PSPS_DT_Label.text=[NSString stringWithFormat:@"%@到%@",self.currentClaimInfo.PSPS_START_DT,self.currentClaimInfo.PSPS_END_DT];
        self.CLIM_RETURN_DT_Label.text=self.currentClaimInfo.CLIM_TPA_RETURN_DT;
        self.bank.text=self.currentClaimInfo.BANK_NAME;
        self.accno.text=self.currentClaimInfo.ACCNO;
    }
    
    
    
    NSURL *url=[[NSURL alloc] initWithString:api_duty_baseinfo_get];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.currentClaimInfo.CLIM_KY forKey:@"CLIM_KY"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue:appDelegate.COMP_ID forKey:@"COMP_ID"];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request startSynchronous];
    //同步方式在此处理返回结果
    TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    NSLog(@"mlist count:%@",request.responseString);
    //如果返回成功显示
    if (result.ResultCode==0)
    {
        //返回数组
        mlist = [[JsonTool defaultTool] getTDutybaseInfoList:request.responseString withKey:@"dutyList"];
    }
    
}

//图片展示列表
-(void)claimsButtonClick
{
     ImageListViewController *imgView = [[ImageListViewController alloc] init];
    [imgView setCLIM_KY:self.currentClaimInfo.CLIM_KY];
    [imgView setIMG_KY:@"0"];

    [self.navigationController pushViewController:imgView animated:YES];
    
}
- (void)dealloc
{
    
}

@end