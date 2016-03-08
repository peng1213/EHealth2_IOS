//
//  ClaimReportListViewController.m
//  EhealthClient
//
//  Created by jiaojunkang on 15-4-27.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "ClaimReportListViewController.h"
#import "UIWindow+YzdHUD.h"
#import "ConfigTool.h"
#import "ImageShowViewController.h"
#import "PDFViewController.h"
#import "ImageViewController.h"
#import "Pub.h"
#import "JsonTool.h"
#import "CommonUtil.h"

@interface ClaimReportListViewController ()

@end

@implementation ClaimReportListViewController
@synthesize currentMember;
@synthesize currentPolicy;
@synthesize currentReport;
@synthesize  REPORT_TYPE;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*01 屏蔽导航栏的遮挡效果 only for ios 7 and up*/
#ifdef IOS7_SDK_AVAILABLE
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
#endif
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
    [titleLable setText:@"理赔报告"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    
    REPORT_TYPE=@"PNG";
    [self reloadReportData:REPORT_TYPE];
}

//02.返回事件
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadReportData:(NSString *)rpttype
{
    NSURL *url =[ NSURL URLWithString : api_claim_reptinfo];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    //获取全局变量
    [request setPostValue:currentMember.MEME_KY forKey: @"MEME_KY"];
    [request setPostValue: currentPolicy.PLPL_ID forKey: @"PLPL_ID"];
    [request setPostValue: rpttype forKey: @"FILE_TYPE"];
    
    [request setRequestMethod:@"GET"];
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:60.0f];
    //[request startAsynchronous];//异步请求
    [request startAsynchronous];
    
    [self.view.window showHUDWithText:@"数据加载中" Type:ShowLoading Enabled:YES];
    
}

/*ASIHttp异步请求处理*/

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.view.window showHUDWithText:@"数据加载失败" Type:ShowPhotoNo Enabled:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    //UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"用户名或者密码错误" message:@"注册失败" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    //[av show];
    
    
    NSLog(@"返回结果啦 %@", request.responseString);
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        //缓存登陆用户信息
        currentReport =[[JsonTool defaultTool]getTClaimReportInfo:request.responseString withKey:@"model"];
        int fsize=[currentReport.FILE_SEZE intValue];
        fsize=fsize/1024;
        self.FILE_SIZE_Label.text=[NSString stringWithFormat:@"%dKB",fsize];
        self.CREATE_DT_Label.text=currentReport.CREATE_DT;
        self.FILE_TYPE_Label.text=REPORT_TYPE;
        [self.view.window showHUDWithText:@"数据加载成功" Type:ShowPhotoYes Enabled:YES];
        
    }else{
        self.FILE_SIZE_Label.text=@"";
        self.CREATE_DT_Label.text=@"";
        self.FILE_TYPE_Label.text=@"暂无报告";
        [self.QUERY_BTN setHidden:YES];
        [self.view.window showHUDWithText:@"暂无信息" Type:ShowPhotoNo Enabled:YES];
        
    }
}
/*ASIHttp异步请求 结束*/


- (IBAction)btnQueryClick:(id)sender {
    if ([REPORT_TYPE isEqualToString:@"PNG"]) {
        ImageViewController  *pdfView = [[ImageViewController alloc]initWithNibName:@"ImageViewController"  bundle:nil];
        [pdfView setIMAGE_PATH:currentReport.FILE_PATH];
        [pdfView setTitle:@"图片报告"];
        [self.navigationController pushViewController:pdfView animated:YES];
    }
    else
    {
        PDFViewController  *pdfView = [[PDFViewController alloc]init];
        [pdfView setPDF_PATH:currentReport.FILE_PATH];
        [pdfView setTitle:@"PDF报告"];
        [self.navigationController pushViewController:pdfView animated:YES];
    }
    
}





-(void) initViewData:(TClaimReportInfo *) rpt
{
    self.FILE_SIZE_Label.text=rpt.FILE_SEZE;
    self.CREATE_DT_Label.text=rpt.CREATE_DT;
    self.FILE_TYPE_Label.text=REPORT_TYPE;
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)RptTypeSegmentChange:(id)sender {
    UISegmentedControl *control =(UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            //
            REPORT_TYPE=@"PNG";
            [self reloadReportData:@"PNG"];
            break;
        case 1:
            //
            REPORT_TYPE=@"PDF";
            [self reloadReportData:@"PDF"];
            break;
            
            
        default:
            break;
    }
}



@end
