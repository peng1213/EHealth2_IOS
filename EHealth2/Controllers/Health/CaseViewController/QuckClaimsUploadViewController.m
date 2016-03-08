//
//  QuckClaimsUploadViewController.m
//  citic
//
//  Created by echoliu on 15-4-9.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "QuckClaimsUploadViewController.h"
#import "CommonUtil.h"
#import "ZTPickerView.h"
#import "ZTAlertView.h"
#import "ToastView.h"
#import "QuckClaimsUpladTableViewCell.h"
#import "QuckClaimsSecViewController.h"
#import "ImageAddViewController.h"
#import "SVProgressHUD.h"
#import "Pub.h"
#import "TReptImgInfo.h"
#import "MyCaseViewController.h"
#import "ImageShowViewController.h"
#import "QuckClaimsOKViewController.h"
#import "HealthViewController.h"
#import "TImgtypeConInfo.h"
#import "SVProgressHUD.h"


@interface QuckClaimsUploadViewController ()
{
    NSMutableArray * mlist;
    NSMutableArray * imageTypeList;
    NSMutableArray * imageDics;
    NSString *_imageKey;
    ASIFormDataRequest *request1;
    ASIFormDataRequest *request2;
    ASIFormDataRequest *request3;
}
-(void )reloadData;
-(NSMutableArray * )getArrayFromList:(NSMutableArray*) list withType:(NSString*) type;

@property(nonatomic,strong) UITableView *mainTableView;
@end

@implementation QuckClaimsUploadViewController
@synthesize currentCaseInfo;
@synthesize mainTableView;
@synthesize toastView;
@synthesize operType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景F0F0F0
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    //设置导航条的View
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    //设置导航View上的返回按钮 定义事件为backToPreViewController
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置导航View上的标题 快速报案
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"影像列表"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置一个流程导航的View 存放流程 基本信息－>收款信息->上传影像->确认信息
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64, self.view.frame.size.width,95)];
    [tableHeaderView setBackgroundColor:[UIColor whiteColor]];
    //基本信息
    UIImageView *baseInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [baseInfoImageView setImage:[UIImage imageNamed:@"reg_icon1"]];
    [tableHeaderView addSubview:baseInfoImageView];
    UILabel *baseInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 48+16, 64, 20)];
    [baseInfoLable setText:@"基本信息"];
    [baseInfoLable setTextAlignment:NSTextAlignmentCenter];
    [baseInfoLable setFont:[UIFont systemFontOfSize:13]];
    [baseInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [tableHeaderView addSubview:baseInfoLable];
    UIImageView *lineOImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [lineOImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:lineOImageView];
    //收款信息
    UIImageView *accountInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44+(self.view.frame.size.width-40-44*4)/3.0, 20, 44, 44)];
    [accountInfoImageView setImage:[UIImage imageNamed:@"reg_icon2.png"]];
    [tableHeaderView addSubview:accountInfoImageView];
    UILabel *accountInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44+(self.view.frame.size.width-40-44*4)/3.0, 48+16, 64, 20)];
    [accountInfoLable setText:@"收款信息"];
    [accountInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [accountInfoLable setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:accountInfoLable];
    UIImageView *line1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [line1ImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:line1ImageView];
    
    //上传影像
    UIImageView *uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 20, 44, 44)];
    [uploadImageView setImage:[UIImage imageNamed:@"report_icon2_current.png"]];
    [tableHeaderView addSubview:uploadImageView];
    UILabel *uploadInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 48+16, 64, 20)];
    [uploadInfoLable setText:@"上传影像"];
    [uploadInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [uploadInfoLable setTextAlignment:NSTextAlignmentCenter];
    [uploadInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:uploadInfoLable];
    UIImageView *lineTImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*3+(self.view.frame.size.width-40-44*4)/3.0*2, 25+16, (self.view.frame.size.width-40-44*4)/3.0, 5)];
    [lineTImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [tableHeaderView addSubview:lineTImageView];
    
    //确认信息
    UIImageView *comfirmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*3+(self.view.frame.size.width-40-44*4)/3.0*3, 20, 44, 44)];
    [comfirmImageView setImage:[UIImage imageNamed:@"report_icon3.png"]];
    [tableHeaderView addSubview:comfirmImageView];
    UILabel *comfirmInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*3+(self.view.frame.size.width-40-44*4)/3.0*3, 48+16, 64, 20)];
    [comfirmInfoLable setText:@"确认信息"];
    [comfirmInfoLable setTextAlignment:NSTextAlignmentCenter];
    [comfirmInfoLable setFont:[UIFont systemFontOfSize:13]];
    [comfirmInfoLable setTextColor:[UIColor lightGrayColor]];
    [tableHeaderView addSubview:comfirmInfoLable];
    [self.view addSubview:tableHeaderView];
    
    //--图片导航结束
    //初始化表格
    if (mainTableView==nil) {
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height, self.view.frame.size.height, self.view.frame.size.height-(tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height)-50) style:UITableViewStylePlain];
    }
    [mainTableView setRowHeight:70];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [self.view addSubview:mainTableView];
    //初始化底部的按钮
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,(self.view.frame.size.height - 50),self.view.frame.size.width,50)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[UIImage imageNamed:@"mycase_bottom_task_bg.png"]];
    [self.view addSubview:bottomView];
    
//    UIButton *uploadpicButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2.0-130, 7.5, 110, 35)];
//    [uploadpicButton setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
//    [uploadpicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [uploadpicButton setTitle:@"影像上传" forState:UIControlStateNormal];
//    [uploadpicButton addTarget:self
//                        action:@selector(uploadButtonClick)
//              forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview:uploadpicButton];
//    
    
    UIButton *quckClaimsButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2.0-55, 7.5, 110, 35)];
    [quckClaimsButton setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [quckClaimsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quckClaimsButton setTitle:@"确认影像" forState:UIControlStateNormal];
    [quckClaimsButton addTarget:self
                         action:@selector(confirmButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:quckClaimsButton];
    
    UIButton *goNext = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2.0-55, 7.5, 110, 35)];
    [goNext setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [goNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goNext setTitle:@"下一步" forState:UIControlStateNormal];
    [goNext addTarget:self
               action:@selector(goNext)
     forControlEvents:UIControlEventTouchUpInside];
    [goNext setHidden:YES];
    [bottomView addSubview:goNext];
    //定义个toastView
    if (toastView == nil) {
        toastView = [[ToastView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-280)/2.0,self.view.frame.size.height,280.0f,30.0f)];
    }
    [self.view addSubview:toastView];
    
    //初始化
    
    [self reloadData];
    
    //观察者观察
    /*为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerUploadCompletion:)
                                                 name:@"RegisterUploadNotification"
                                               object:nil];
    if([operType isEqualToString:@"read"])
    {
        [quckClaimsButton setHidden:YES];
        [goNext setHidden:NO];
    }
    else
    {
        [quckClaimsButton setHidden:NO];
        [goNext setHidden:YES];
    }

}

-(void)registerUploadCompletion:(NSNotification*)notification
{
    [self.mainTableView reloadData];
}

-(NSMutableArray * )getArrayFromList:(NSMutableArray*) list withType:(NSString*) type
{
    NSMutableArray * newlist=[[NSMutableArray alloc ]init] ;
    for (TReptImgInfo * img in list) {
        if([img.IMAGE_TYPE_DESC isEqualToString:type] || [img.IMAGE_TYPE_CODE isEqualToString:type] )
        {
            [newlist removeObject:img];
            [newlist addObject:img];
        }
    }
    return newlist;
}

-(void)loadImageType
{
    
    AppDelegate *delegate=   (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[[NSURL alloc] initWithString:api_image_typelist];
    request1=[ASIFormDataRequest requestWithURL:url];
    [request1 setPostValue:delegate.COMP_ID forKey:@"COMP_ID"];
    [request1 setPostValue:currentCaseInfo.CASE_TYPE forKey:@"CASE_TYPE"];
    [request1 setPostValue: delegate.token forKey: @"token"];
    [request1 setRequestMethod:@"POST"];
    [request1 buildPostBody];
    [request1 setDelegate:self];
    [request1 setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request1 startAsynchronous];
    [SVProgressHUD show];
    //同步方式在此处理返回结果
}

-(void)loadImage
{
    NSURL *url=[[NSURL alloc] initWithString:api_case_image_list];
    request2=[ASIFormDataRequest requestWithURL:url];
    [request2 setPostValue:[NSString stringWithFormat:@"%d",currentCaseInfo.REPT_KY] forKey:@"REPT_KY"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request2 setPostValue: appDelegate.token forKey: @"token"];
    [request2 setRequestMethod:@"POST"];
    [request2 buildPostBody];
    [request2 setDelegate:self];
    [request2 setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request2 startAsynchronous];

}
//加载数据
-(void)reloadData{
    [self loadImageType];
    
}

/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [toastView toastTipsWithTips:@"请检查网络是否正确！"];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    NSLog(@"mlist count:%@",request.responseString);
    //如果返回成功显示
    if (model.ResultCode==0)
    {
        if(request==request1)
        {
            imageTypeList = [[JsonTool defaultTool] getTImgtypeConInfoList:request.responseString withKey:@"model"];
            [self loadImage];
        }
        else if(request==request2)
        {
            imageDics=[[NSMutableArray alloc]init];
            mlist = [[JsonTool defaultTool] getTReptImgInfoList:request.responseString withKey:@"model"];
            for (id type in imageTypeList) {
                TImgtypeConInfo *typeInfo=(TImgtypeConInfo*)type;
                NSMutableArray *array=[[NSMutableArray alloc]init];
                for (int i=0; i<mlist.count; i++) {
                    if([[(TReptImgInfo*)mlist[i] IMAGE_TYPE_DESC]isEqualToString:typeInfo.IMAGE_TYPE_DESC])
                    {
                        [array addObject:(TReptImgInfo*)mlist[i]];
                    }
                }
                ReportImage *reportImage=[[ReportImage alloc]init];
                reportImage.typeInfo=typeInfo;
                reportImage.images=array;
                [imageDics addObject:reportImage];
            }
            
            [self.mainTableView reloadData];
            [SVProgressHUD dismiss];
        }
    }
    else
    {
        [toastView toastTipsWithTips:[NSString stringWithFormat: @"%@",model.ResultDesc]];
    }
}

-(void)goNext
{
    QuckClaimsOKViewController *quckView =[[QuckClaimsOKViewController alloc] init];
    [quckView setCurrentCaseInfo:currentCaseInfo];
    [self.navigationController pushViewController:quckView animated:YES];
    
}

- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes
{
    
}

-(void)confirmButtonClick
{
    BOOL isValid=YES;
    for (id type in imageDics) {
        ReportImage *reptImage=(ReportImage*)type;
        
        TImgtypeConInfo *typeInfo=reptImage.typeInfo;
        NSMutableArray*array= reptImage.images;
        if([typeInfo.REQUIRED_COUNT isEqualToString:@"1"]&&array.count==0)
        {
            [toastView toastTipsWithTips:[NSString stringWithFormat: @"该报案未上传%@，请上传后再进行下一步！",typeInfo.IMAGE_TYPE_DESC]];
            isValid=NO;
            break;
        }
        else if([typeInfo.REQUIRED_COUNT isEqualToString:@"1"]&&array.count>1)
        {
            [toastView toastTipsWithTips:[NSString stringWithFormat: @"%@只能上传一张，请删除多余影像后后再进行下一步！",typeInfo.IMAGE_TYPE_DESC]];
            isValid=NO;
            break;
        }
        else if([typeInfo.REQUIRED_COUNT isEqualToString:@">=1"]&&array.count==0)
        {
            [toastView toastTipsWithTips:[NSString stringWithFormat: @"该报案未上传%@，请上传后再进行下一步！",typeInfo.IMAGE_TYPE_DESC]];
            isValid=NO;
            break;
        }
    }
    
    if(isValid)
    {
        if([operType isEqualToString:@"read"])
        {
            NSDictionary *dataDict = [NSDictionary dictionaryWithObject:@"ok"
                                                                 forKey:@"popitemname"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"RegisterMyCaseNotification"
             object:nil
             userInfo:dataDict];
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MyCaseViewController class]]) {
                    [self.navigationController popToViewController:controller
                                                          animated:YES];
                }
            }
        }
        else
        {
        QuckClaimsOKViewController *quckView =[[QuckClaimsOKViewController alloc] init];
        [quckView setCurrentCaseInfo:currentCaseInfo];
        [self.navigationController pushViewController:quckView animated:YES];
        }
    }
    
}


- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToHomeButtonClick
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HealthViewController class]]) {
            [self.navigationController popToViewController:controller
                                                  animated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//tableview的事件
#pragma mark --
#pragma mark --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imageDics.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportImage *reptImage=(ReportImage*)imageDics[indexPath.row];
    TImgtypeConInfo*type= reptImage.typeInfo;
    NSMutableArray *images=reptImage.images;
//    TImgtypeConInfo* keyType=reptImage.images;
//    for (TImgtypeConInfo* item in imageDics.allKeys) {
//        if([item.CON_KY isEqualToString:type.CON_KY])
//        {
//            keyType=item;
//            break;
//        }
//    }
    int count= [images count];
    CGFloat height=160;
    if(count==0)
    {
        height=160;
    }
    else if(count%4==0)
    {
        height= 60+20+80*(count/4);
    }
    else
    {
        height= 60+20+80*(count/4+1);
    }
    return height;
}


//获取cell的定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    //注意这里自定义了Cell
    QuckClaimsUpladTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[QuckClaimsUpladTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    ReportImage *reptImage=(ReportImage*)imageDics[indexPath.row];
    TImgtypeConInfo*type= reptImage.typeInfo;
    NSMutableArray *images=reptImage.images;
//    
//    TImgtypeConInfo*type= (TImgtypeConInfo*)imageTypeList[rowNum];
//    TImgtypeConInfo* keyType=nil;
//    for (TImgtypeConInfo* item in imageDics.allKeys) {
//        if([item.CON_KY isEqualToString:type.CON_KY])
//        {
//            keyType=item;
//            break;
//        }
//    }
//    NSMutableArray *array=(NSMutableArray*) imageDics[keyType];
//    if(array ==nil)
//    {
//        array=[[NSMutableArray alloc]init];
//    }
    [cell setCellValue:images type:type viewController:self];
    cell.addBtn.tag=rowNum+100;
    cell.editBtn.tag=rowNum+100;
    cell.imagesView.tag=rowNum+100;
    return cell;
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSURL *url=[[NSURL alloc] initWithString:api_case_image_delete];
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setPostValue:_imageKey forKey:@"IMG_KY"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [request setPostValue: appDelegate.token forKey: @"token"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setDelegate:self];
        [request setTimeOutSeconds:60];
        //设定同步还是异步方式
        [request startSynchronous];
        TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        if(result.ResultCode==0)
        {
            [self reloadData];
        }
        else
        {
            NSLog(@"%@",result.ResultDesc);
            [toastView toastTipsWithTips:@"删除失败！"];
        }
    }
}

-(void)sec0ButtonClick
{
    NSLog(@"LOG SEC0");
}


-(void)sec1ButtonClick
{
    NSLog(@"LOG SEC1");
}


-(void)sec2ButtonClick
{
    NSLog(@"LOG SEC3");}


-(void)sec3ButtonClick
{
    NSLog(@"LOG SEC4");
}


@end
