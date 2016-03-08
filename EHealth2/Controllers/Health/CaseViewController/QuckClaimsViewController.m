//
//  QuckClaimsViewController.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/26.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "QuckClaimsViewController.h"
#import "CommonUtil.h"
#import "ZTPickerView.h"
#import "ZTAlertView.h"
#import "MemeListViewController.h"
#import "QuckClaimsSecViewController.h"
#import "TUserInfo.h"
#import "AppDelegate.h"
#import "Pub.h"
#import "SVProgressHUD.h"
#import "UIKeyboardViewController.h"
#import "NSMutableArray+FieldConfig.h"

@interface QuckClaimsViewController ()<ZTPickerViewDelegate,UIKeyboardViewControllerDelegate,UIAlertViewDelegate>
{
    UIImageView *visitdtIcon;
    UIImageView *toDtIcon;
    UIImageView *resonIcon;
    UIButton *nextButton;
    UIImageView *imgIcon;
    UIImageView *clivIcon;
    UIImageView *hphpIcon;
    UIScrollView *contentView;
    UIKeyboardViewController *keyBoardController;
    NSMutableDictionary *currentFields;
    NSMutableArray *keyArray;
}
@property (nonatomic, strong) UIActionSheet *pationtActionSheet;
@property ZTPickerView *datePickerView;
@property ZTPickerView *datePickerView2;

//新增控件

@property (nonatomic, strong) UILabel *CASE_TYPE;
@property (nonatomic, strong) UITextField *MEME_NAME;
@property (nonatomic, strong) UITextField *APPL_AMT;

@property (nonatomic, strong) UILabel *VISIT_FRM_DT;
@property (nonatomic, strong) UILabel *VISIT_TO_DT;
@property (nonatomic, strong) UITextField *DEDE_NAME;
@property (nonatomic, strong) UITextField *HPHP_NAME;
@property (nonatomic, strong) UITextField *IMG_COUNT;
@property (nonatomic, strong) UITextField *CLIV_COUNT;

@property (nonatomic, strong) UIButton *casetypeButton;
@property (nonatomic, strong) UIButton *memenameButton;
@property (nonatomic, strong) UIButton *visitdtButton;
@property (nonatomic, strong) UIButton *visittodtButton;



- (void)backToPreViewController;
- (void)backToHomeButtonClick;
-(void)initDataWithModel:(TReptCaseInfo*) model;

@end

@implementation QuckClaimsViewController
@synthesize operType;
@synthesize pationtActionSheet;
@synthesize datePickerView;
@synthesize datePickerView2;
@synthesize CASE_TYPE;
@synthesize APPL_AMT;
@synthesize MEME_NAME;
@synthesize DEDE_NAME;
@synthesize VISIT_FRM_DT;
@synthesize VISIT_TO_DT;
@synthesize currentCaseInfo;
@synthesize casetypeButton;
@synthesize memenameButton;
@synthesize visitdtButton;
@synthesize visittodtButton;
@synthesize HPHP_NAME;
@synthesize CLIV_COUNT;
@synthesize IMG_COUNT;
@synthesize fieldConfigList;


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景F0F0F0
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    currentFields=[[NSMutableDictionary alloc]init];
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
    [titleLable setText:@"快速报案"];
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
    [lineOImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [tableHeaderView addSubview:lineOImageView];
    //收款信息
    UIImageView *accountInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44+(self.view.frame.size.width-40-44*4)/3.0, 20, 44, 44)];
    [accountInfoImageView setImage:[UIImage imageNamed:@"reg_gray_icon2.png"]];
    [tableHeaderView addSubview:accountInfoImageView];
    UILabel *accountInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44+(self.view.frame.size.width-40-44*4)/3.0, 48+16, 64, 20)];
    [accountInfoLable setText:@"收款信息"];
    [accountInfoLable setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLable setFont:[UIFont systemFontOfSize:13]];
    [accountInfoLable setTextColor:[UIColor lightGrayColor]];
    [tableHeaderView addSubview:accountInfoLable];
    UIImageView *line1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [line1ImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [tableHeaderView addSubview:line1ImageView];
    
    //上传影像
    UIImageView *uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 20, 44, 44)];
    [uploadImageView setImage:[UIImage imageNamed:@"report_icon2.png"]];
    [tableHeaderView addSubview:uploadImageView];
    UILabel *uploadInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 48+16, 64, 20)];
    [uploadInfoLable setText:@"上传影像"];
    [uploadInfoLable setTextAlignment:NSTextAlignmentCenter];
    [uploadInfoLable setFont:[UIFont systemFontOfSize:13]];
    [uploadInfoLable setTextColor:[UIColor lightGrayColor]];
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
    //下面设置一个日期控件
    if (self.datePickerView == nil) {
        NSDate *date = [NSDate date];
        datePickerView = [[ZTPickerView alloc] initDatePickWithDate:date
                                                     datePickerMode:UIDatePickerModeDate
                                                 isHaveNavControler:NO];
    }
    [datePickerView setDelegate:self];
    [datePickerView setToolBarTintColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [datePickerView setBackgroundColor:[UIColor whiteColor]];
    
    if (self.datePickerView2 == nil) {
        NSDate *date = [NSDate date];
        datePickerView2 = [[ZTPickerView alloc] initDatePickWithDate:date
                                                      datePickerMode:UIDatePickerModeDate
                                                  isHaveNavControler:NO];
    }
    [datePickerView2 setDelegate:self];
    [datePickerView2 setToolBarTintColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [datePickerView2 setBackgroundColor:[UIColor whiteColor]];
    
    contentView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-tableHeaderView.frame.origin.y-tableHeaderView.frame.size.height)];
    //    contentView.scrollEnabled=YES;
    //    contentView.showsVerticalScrollIndicator=YES;
    //    contentView.backgroundColor=[UIColor redColor];
    [self.view addSubview:contentView];
    //就诊类型
    UIImageView *casetypeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 20, self.view.frame.size.width, 40.0)];
    [casetypeIcon setUserInteractionEnabled:YES];
    [casetypeIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:casetypeIcon];
    UILabel *casetypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [casetypeLabel setFont:[UIFont systemFontOfSize:15]];
    [casetypeLabel setText:@"就诊类型"];
    casetypeLabel.tag=100000;
    [casetypeLabel setTextAlignment:NSTextAlignmentLeft];
    [casetypeLabel setTextColor:[UIColor blackColor]];
    [casetypeIcon addSubview:casetypeLabel];
    
    //    UIImageView *required1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    //    required1.image=[UIImage imageNamed:@"hits_star"];
    //    required1.contentMode=UIViewContentModeScaleAspectFit;
    //    [casetypeIcon addSubview:required1];
    if (self.CASE_TYPE == nil) {
        CASE_TYPE = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-265, 0, 230, 40)];
    }
    [CASE_TYPE setTextColor:[UIColor lightGrayColor]];
    [CASE_TYPE setTextAlignment:NSTextAlignmentRight];
    [CASE_TYPE setFont:[UIFont systemFontOfSize:13]];
    [CASE_TYPE setText:@"请选择就诊类型"];
    CASE_TYPE.tag=100001;
    [casetypeIcon addSubview:CASE_TYPE];
    
    
    //箭头
    UIImageView *casetypeArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32, 9, 22, 22)];
    [casetypeArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
    [casetypeIcon addSubview:casetypeArrow];
    
    //加载事件的按钮
    casetypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, casetypeIcon.frame.size.width, 40)];
    [casetypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [casetypeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [casetypeButton setTitle:@"下一步" forState:UIControlStateNormal];
    [casetypeButton addTarget:self
                       action:@selector(casetypeButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
    [casetypeIcon addSubview:casetypeButton];
    
    
    [currentFields setObject:casetypeIcon forKey:@"CASE_TYPE"];
    //就诊人------------------------------
    UIImageView *memenameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, casetypeIcon.frame.origin.y+casetypeIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [memenameIcon setUserInteractionEnabled:YES];
    [memenameIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:memenameIcon];
    
    UILabel *memenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [memenameLabel setFont:[UIFont systemFontOfSize:15]];
    [memenameLabel setText:@"就诊人"];
    memenameLabel.tag=100000;
    [memenameLabel setTextAlignment:NSTextAlignmentLeft];
    [memenameLabel setTextColor:[UIColor blackColor]];
    [memenameIcon addSubview:memenameLabel];
    //    UIImageView *required2=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    //    required2.image=[UIImage imageNamed:@"hits_star"];
    //    required2.contentMode=UIViewContentModeScaleAspectFit;
    //    [memenameIcon addSubview:required2];
    if (self.MEME_NAME == nil) {
        MEME_NAME = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-265, 0, 205, 40)];
    }
    //[MEME_NAME setTextColor:[UIColor lightGrayColor]];
    [MEME_NAME setTextAlignment:NSTextAlignmentRight];
    [MEME_NAME setFont:[UIFont systemFontOfSize:13]];
    //[MEME_NAME setText:@"请输入就诊人"];
    MEME_NAME.tag=100001;
    [memenameIcon addSubview:MEME_NAME];

    
    //加号
    UIButton *addBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-55, 5, 30, 30)];
    
    [addBtn setImage:[UIImage imageNamed:@"icon_add1.png"] forState:UIControlStateNormal];
    
    [memenameIcon addSubview:addBtn];
    [addBtn addTarget:self action:@selector(memenameButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    //箭头
//    UIImageView *memenameArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32, 9, 22, 22)];
//    [memenameArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
//    [memenameIcon addSubview:memenameArrow];
//    
//    //加载事件的按钮
//    memenameButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, casetypeIcon.frame.size.width, 40)];
//    [memenameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [memenameButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [memenameButton setTitle:@"下一步" forState:UIControlStateNormal];
//    [memenameButton addTarget:self
//                       action:@selector(memenameButtonClick)
//             forControlEvents:UIControlEventTouchUpInside];
//    [memenameIcon addSubview:memenameButton];
    
    [currentFields setObject:memenameIcon forKey:@"MEME_NAME"];
    //申请金额
    UIImageView *appamtIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, memenameIcon.frame.origin.y+memenameIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [appamtIcon setUserInteractionEnabled:YES];
    [appamtIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:appamtIcon];
    
    UILabel *amtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [amtLabel setFont:[UIFont systemFontOfSize:15]];
    [amtLabel setText:@"申请金额"];
    amtLabel.tag=100000;
    [amtLabel setTextAlignment:NSTextAlignmentLeft];
    [amtLabel setTextColor:[UIColor blackColor]];
    [appamtIcon addSubview:amtLabel];
    //    UIImageView *required3=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    //    required3.image=[UIImage imageNamed:@"hits_star"];
    //    required3.contentMode=UIViewContentModeScaleAspectFit;
    //    [appamtIcon addSubview:required3];
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.APPL_AMT == nil) {
        APPL_AMT = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (appamtIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [APPL_AMT setDelegate:self];
    [APPL_AMT setPlaceholder:@"请输入金额"];
    [APPL_AMT setBackgroundColor:[UIColor whiteColor]];
    [APPL_AMT setFont:[UIFont systemFontOfSize:13.0f]];
    [APPL_AMT setTextColor:[UIColor blackColor]];
    [APPL_AMT setText:@""];
    APPL_AMT.tag=100001;
    [APPL_AMT setKeyboardType:UIKeyboardTypeDecimalPad];
    [APPL_AMT setTextAlignment:NSTextAlignmentRight];
    [APPL_AMT setReturnKeyType:UIReturnKeyNext];
    [APPL_AMT.layer setCornerRadius:3.0];
    [appamtIcon addSubview:APPL_AMT];
    [currentFields setObject:appamtIcon forKey:@"APPL_AMT"];
    
    hphpIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, appamtIcon.frame.origin.y+appamtIcon.frame.size.height+10, self.view.frame.size.width, 40.0)];
    [hphpIcon setUserInteractionEnabled:YES];
    [hphpIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:hphpIcon];
    
    UILabel *HPHPLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [HPHPLabel setFont:[UIFont systemFontOfSize:15]];
    [HPHPLabel setText:@"就诊医院"];
    HPHPLabel.tag=100000;
    [HPHPLabel setTextAlignment:NSTextAlignmentLeft];
    [HPHPLabel setTextColor:[UIColor blackColor]];
    [hphpIcon addSubview:HPHPLabel];
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.HPHP_NAME == nil) {
        HPHP_NAME = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (hphpIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [HPHP_NAME setDelegate:self];
    [HPHP_NAME setPlaceholder:@"请输入就诊医院"];
    [HPHP_NAME setBackgroundColor:[UIColor whiteColor]];
    [HPHP_NAME setFont:[UIFont systemFontOfSize:13.0f]];
    [HPHP_NAME setTextColor:[UIColor blackColor]];
    [HPHP_NAME setText:@""];
    HPHP_NAME.tag=100001;
    [HPHP_NAME setTextAlignment:NSTextAlignmentRight];
    [HPHP_NAME setReturnKeyType:UIReturnKeyDone];
    [HPHP_NAME.layer setCornerRadius:3.0];
    [hphpIcon addSubview:HPHP_NAME];
    [currentFields setObject:hphpIcon forKey:@"HPHP_NAME"];
    //就诊时间
    visitdtIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, hphpIcon.frame.origin.y+hphpIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [visitdtIcon setUserInteractionEnabled:YES];
    [visitdtIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:visitdtIcon];
    
    
    UILabel *visitdtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [visitdtLabel setFont:[UIFont systemFontOfSize:15]];
    [visitdtLabel setText:@"就诊时间"];
    visitdtLabel.tag=100000;
    [visitdtLabel setTextAlignment:NSTextAlignmentLeft];
    [visitdtLabel setTextColor:[UIColor blackColor]];
    [visitdtIcon addSubview:visitdtLabel];
    //    UIImageView *required5=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    //    required5.image=[UIImage imageNamed:@"hits_star"];
    //    required5.contentMode=UIViewContentModeScaleAspectFit;
    //    [visitdtIcon addSubview:required5];
    
    if (self.VISIT_FRM_DT == nil) {
        VISIT_FRM_DT = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-265, 0, 230, 40)];
    }
    [VISIT_FRM_DT setTextColor:[UIColor lightGrayColor]];
    [VISIT_FRM_DT setTextAlignment:NSTextAlignmentRight];
    [VISIT_FRM_DT setFont:[UIFont systemFontOfSize:13]];
    [VISIT_FRM_DT setText:@"请选择就诊时间"];
    VISIT_FRM_DT.tag=100001;
    [visitdtIcon addSubview:VISIT_FRM_DT];
    
    //加载事件的按钮
    visitdtButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, casetypeIcon.frame.size.width, 40)];
    [visitdtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [visitdtButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [visitdtButton setTitle:@"下一步" forState:UIControlStateNormal];
    [visitdtButton addTarget:self
                      action:@selector(visitdtButtonClick)
            forControlEvents:UIControlEventTouchUpInside];
    [visitdtIcon addSubview:visitdtButton];
    
    
    //箭头
    UIImageView *visitdtArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32, 9, 22, 22)];
    [visitdtArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
    [visitdtIcon addSubview:visitdtArrow];
    
    [currentFields setObject:visitdtIcon forKey:@"VISIT_FRM_DT"];
    
    
    
    toDtIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, hphpIcon.frame.origin.y+hphpIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [toDtIcon setUserInteractionEnabled:YES];
    [toDtIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [toDtIcon setHidden:YES];
    [contentView addSubview:toDtIcon];
    //    UIImageView *required6=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    //    required6.image=[UIImage imageNamed:@"hits_star"];
    //    required6.contentMode=UIViewContentModeScaleAspectFit;
    //    [toDtIcon addSubview:required6];
    //
    UILabel *todtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [todtLabel setFont:[UIFont systemFontOfSize:15]];
    [todtLabel setText:@"出院时间"];
    todtLabel.tag=100000;
    [todtLabel setTextAlignment:NSTextAlignmentLeft];
    [todtLabel setTextColor:[UIColor blackColor]];
    [toDtIcon addSubview:todtLabel];
    
    if (self.VISIT_TO_DT == nil) {
        VISIT_TO_DT = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-265, 0, 230, 40)];
    }
    [VISIT_TO_DT setTextColor:[UIColor lightGrayColor]];
    [VISIT_TO_DT setTextAlignment:NSTextAlignmentRight];
    [VISIT_TO_DT setFont:[UIFont systemFontOfSize:13]];
    [VISIT_TO_DT setText:@"请选择出院时间"];
    VISIT_TO_DT.tag=100001;
    [toDtIcon addSubview:VISIT_TO_DT];
    
    
    //加载事件的按钮
    visittodtButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, casetypeIcon.frame.size.width, 40)];
    [visittodtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [visittodtButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [visittodtButton setTitle:@"下一步" forState:UIControlStateNormal];
    [visittodtButton addTarget:self
                        action:@selector(visittodtButtonClick)
              forControlEvents:UIControlEventTouchUpInside];
    [toDtIcon addSubview:visittodtButton];
    [currentFields setObject:toDtIcon forKey:@"VISIT_TO_DT"];
    
    //箭头
    UIImageView *visittodtArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32, 9, 22, 22)];
    [visittodtArrow setImage:[UIImage imageNamed:@"common_right_arrow_icon.png"]];
    [toDtIcon addSubview:visittodtArrow];
    
    
    
    //病因
    resonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, visitdtIcon.frame.origin.y+visitdtIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [resonIcon setUserInteractionEnabled:YES];
    [resonIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:resonIcon];
    //    UIImageView *required7=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
    //    required7.image=[UIImage imageNamed:@"hits_star"];
    //    required7.contentMode=UIViewContentModeScaleAspectFit;
    //    [resonIcon addSubview:required7];
    UILabel *resonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [resonLabel setFont:[UIFont systemFontOfSize:15]];
    [resonLabel setText:@"病因"];
    resonLabel.tag=100000;
    [resonLabel setTextAlignment:NSTextAlignmentLeft];
    [resonLabel setTextColor:[UIColor blackColor]];
    [resonIcon addSubview:resonLabel];
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.DEDE_NAME == nil) {
        DEDE_NAME = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (resonIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [DEDE_NAME setDelegate:self];
    [DEDE_NAME setPlaceholder:@"请输入病因"];
    [DEDE_NAME setBackgroundColor:[UIColor whiteColor]];
    [DEDE_NAME setFont:[UIFont systemFontOfSize:13.0f]];
    [DEDE_NAME setTextColor:[UIColor blackColor]];
    [DEDE_NAME setText:@""];
    DEDE_NAME.tag=100001;
    [DEDE_NAME setTextAlignment:NSTextAlignmentRight];
    [DEDE_NAME setReturnKeyType:UIReturnKeyDone];
    [DEDE_NAME.layer setCornerRadius:3.0];
    [resonIcon addSubview:DEDE_NAME];
    [currentFields setObject:resonIcon forKey:@"DEDE_NAME"];
    imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, resonIcon.frame.origin.y+resonIcon.frame.size.height+10, self.view.frame.size.width, 40.0)];
    [imgIcon setUserInteractionEnabled:YES];
    [imgIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:imgIcon];
    
    UILabel *IMGLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [IMGLabel setFont:[UIFont systemFontOfSize:15]];
    [IMGLabel setText:@"影像数"];
    IMGLabel.tag=100000;
    [IMGLabel setTextAlignment:NSTextAlignmentLeft];
    [IMGLabel setTextColor:[UIColor blackColor]];
    [imgIcon addSubview:IMGLabel];
    
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.IMG_COUNT == nil) {
        IMG_COUNT = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (imgIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [IMG_COUNT setDelegate:self];
    [IMG_COUNT setPlaceholder:@"请输入影像数"];
    [IMG_COUNT setBackgroundColor:[UIColor whiteColor]];
    [IMG_COUNT setFont:[UIFont systemFontOfSize:13.0f]];
    [IMG_COUNT setTextColor:[UIColor blackColor]];
    [IMG_COUNT setText:@""];
    IMG_COUNT.tag=100001;
    [IMG_COUNT setTextAlignment:NSTextAlignmentRight];
    [IMG_COUNT setKeyboardType:UIKeyboardTypeNumberPad];
    [IMG_COUNT setReturnKeyType:UIReturnKeyDone];
    [IMG_COUNT.layer setCornerRadius:3.0];
    [imgIcon addSubview:IMG_COUNT];
    
    [currentFields setObject:imgIcon forKey:@"IMG_COUNT"];
    clivIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, imgIcon.frame.origin.y+imgIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [clivIcon setUserInteractionEnabled:YES];
    [clivIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:clivIcon];
    
    UILabel *CLIVLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [CLIVLabel setFont:[UIFont systemFontOfSize:15]];
    [CLIVLabel setText:@"发票数"];
    CLIVLabel.tag=100000;
    [CLIVLabel setTextAlignment:NSTextAlignmentLeft];
    [CLIVLabel setTextColor:[UIColor blackColor]];
    [clivIcon addSubview:CLIVLabel];
    
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.CLIV_COUNT == nil) {
        CLIV_COUNT = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (clivIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [CLIV_COUNT setDelegate:self];
    [CLIV_COUNT setPlaceholder:@"请输入发票数"];
    [CLIV_COUNT setBackgroundColor:[UIColor whiteColor]];
    [CLIV_COUNT setFont:[UIFont systemFontOfSize:13.0f]];
    [CLIV_COUNT setTextColor:[UIColor blackColor]];
    [CLIV_COUNT setText:@""];
    CLIV_COUNT.tag=100001;
    [CLIV_COUNT setKeyboardType:UIKeyboardTypeNumberPad];
    [CLIV_COUNT setTextAlignment:NSTextAlignmentRight];
    [CLIV_COUNT setReturnKeyType:UIReturnKeyDone];
    [CLIV_COUNT.layer setCornerRadius:3.0];
    [clivIcon addSubview:CLIV_COUNT];
    [currentFields setObject:clivIcon forKey:@"CLIV_COUNT"];
    keyArray=[[NSMutableArray alloc]initWithObjects:@"CASE_TYPE",@"MEME_NAME",@"APPL_AMT",@"HPHP_NAME",@"VISIT_FRM_DT",@"VISIT_TO_DT",@"DEDE_NAME",@"IMG_COUNT",@"CLIV_COUNT", nil];
    //按钮下一步
    nextButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, clivIcon.frame.size.height+clivIcon.frame.origin.y+20, 270, 49)];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(nextButtonClick)
         forControlEvents:UIControlEventTouchUpInside];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [contentView addSubview:nextButton];
    contentView.contentSize=CGSizeMake(self.view.frame.size.width,nextButton.frame.origin.y+nextButton.frame.size.height+20 );

    //观察者观察
    /*为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
    
    if(currentMemeber==nil)
    {
        currentMemeber =[[TMemberInfo alloc] init];
    }
    [self loadFieldConfig];
    //初始化
    if(currentCaseInfo==nil)
    {
        currentCaseInfo =[[TReptCaseInfo alloc] init];
        
    }
    else{
        if(currentCaseInfo.REPT_KY>0)
        {
            [self initDataWithModel:currentCaseInfo];
        }
    }
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(hideTheKeyBoard:)];
    [tapgesture setNumberOfTapsRequired:1];
    [tapgesture setNumberOfTouchesRequired:1];
    [contentView addGestureRecognizer:tapgesture];
    [self loadDate];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
}

-(void)loadFieldConfig
{
    CGFloat position=0;
    CGFloat nextBtnPosition=0;
    for (NSString * key in keyArray) {
        FieldConfig *config= [fieldConfigList getConfigByName:key];
        UIImageView *fieldContainer=(UIImageView*)[currentFields objectForKey:key];
        UILabel *label=(UILabel*)[fieldContainer viewWithTag:100000];
        label.text=config.FIELD_DISP_NAME;
        if([config.IS_SHOW isEqualToString:@"Y"])
        {
            UIView *textView= [fieldContainer viewWithTag:100001];
            if([textView isKindOfClass:[UILabel class]])
            {
                ((UILabel*)textView).text=[NSString stringWithFormat:@"请选择%@",config.FIELD_DISP_NAME];
            }
            if([textView isKindOfClass:[UITextField class]])
            {
                ((UITextField*)textView).placeholder=[NSString stringWithFormat:@"请输入%@",config.FIELD_DISP_NAME];
            }
            if([config.FIELD_NAME isEqualToString:@"VISIT_TO_DT"])
            {
                [fieldContainer setHidden:YES];
            }
            else
                [fieldContainer setHidden:NO];
            CGRect frame= fieldContainer.frame;
            frame.origin.y-=position;
            fieldContainer.frame=frame;
            nextBtnPosition=frame.origin.y+frame.size.height+20;
            UIImageView *required=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-15, 12.5, 15, 15)];
            required.image=[UIImage imageNamed:@"hits_star"];
            required.contentMode=UIViewContentModeScaleAspectFit;
            [fieldContainer addSubview:required];
            
            if ([config.IS_REQUIRED isEqualToString:@"Y"]) {
                [required setHidden:NO];
            }
            else
            {
                [required setHidden:YES];
            }
        }
        else
        {
            if(![config.FIELD_NAME isEqualToString:@"VISIT_TO_DT"])
            {
                position+= 40;
            }
            [fieldContainer setHidden:YES];
        }
        
    }
    CGRect frame= nextButton.frame;
    frame.origin.y=nextBtnPosition;
    nextButton.frame=frame;
    contentView.contentSize=CGSizeMake(self.view.frame.size.width,nextButton.frame.origin.y+nextButton.frame.size.height+20 );
}

#pragma - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}
/**
 * 这是一个通知事件方法 当弹出页面返回的时候 接收到此参数
 */
-(void)registerCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    currentMemeber = [theData objectForKey:@"popitemname"];
    
    NSLog(@"username = %@",currentMemeber.MEME_NAME);
    /*获取返回值 刷新本页列表*/
    [self.MEME_NAME setText:currentMemeber.MEME_NAME];
    
}


-(void)registerPolicy:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    currentMemeber = [theData objectForKey:@"popitemname"];
    
    NSLog(@"username = %@",currentMemeber.MEME_NAME);
    /*获取返回值 刷新本页列表*/
    [self.MEME_NAME setText:currentMemeber.MEME_NAME];
    
}
-(void)initDataWithModel:(TReptCaseInfo *)model
{
    if([operType isEqualToString:@"read"])
    {
        [casetypeButton setUserInteractionEnabled:NO];
        [memenameButton setUserInteractionEnabled:NO];
        [visitdtButton setUserInteractionEnabled:NO];
        [APPL_AMT setUserInteractionEnabled:NO];
        [DEDE_NAME setUserInteractionEnabled:NO];
        [visittodtButton setUserInteractionEnabled:NO];
        [HPHP_NAME setUserInteractionEnabled:NO];
        [IMG_COUNT setUserInteractionEnabled:NO];
        [CLIV_COUNT setUserInteractionEnabled:NO];
        
    }
    currentMemeber.MEME_KY=model.MEME_KY;
    currentMemeber.MEME_NAME=model.MEME_NAME;
    self.MEME_NAME.text=model.MEME_NAME;
    self.APPL_AMT.text=model.APPL_AMT;
    self.CASE_TYPE.text=model.CASE_TYPE;
    self.DEDE_NAME.text=model.DEDE_NAME;
    self.VISIT_FRM_DT.text=model.VISIT_FRM_DT;
    self.VISIT_TO_DT.text=model.VISIT_TO_DT;
    self.HPHP_NAME.text=model.HPHP_NAME;
    self.IMG_COUNT.text=model.IMG_COUNT;
    self.CLIV_COUNT.text=model.CLIV_COUNT;
}
- (void)backToPreViewController
{
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:@"ok"
                                                         forKey:@"popitemname"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RegisterMyCaseNotification"
     object:nil
     userInfo:dataDict];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)casetypeButtonClick
{
    if (self.pationtActionSheet == nil) {
        pationtActionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"请选%@",[fieldConfigList getConfigByName:@"CASE_TYPE"].FIELD_DISP_NAME]
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"门诊", @"住院",@"生育",@"其他",nil];
    }
    [pationtActionSheet showInView:self.view];
    NSLog(@"CAETYPE");
}
//memenameButtonClick

-(void)memenameButtonClick
{
    
    MemeListViewController *policyViewController = [[MemeListViewController alloc] init];
    [self.navigationController pushViewController:policyViewController animated:YES];
    //先获取返回结果 加载到对象中 传递到下一个也没
    
    NSLog(@"memenameButtonClick");
}
//visitdtButtonClick

-(void)visitdtButtonClick
{
    [datePickerView show];
    NSLog(@"memenameButtonClick");
}

-(void)visittodtButtonClick
{
    [datePickerView2 show];
}

#pragma mark --
#pragma amek --
- (void)pickerBarDoneClick:(ZTPickerView *)pickerView resultString:(NSString *)resultString
{
    if (pickerView==datePickerView) {
        self.VISIT_FRM_DT.text=resultString;
    }
    else
    {
        self.VISIT_TO_DT.text=resultString;
    }
}

#pragma mark --
#pragma mark -- UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.pationtActionSheet&&actionSheet.cancelButtonIndex!=buttonIndex) {
        
        self.CASE_TYPE.text=[actionSheet buttonTitleAtIndex:buttonIndex];
        [self loadDate];
    }
}

-(void)loadDate
{
    FieldConfig *config= [fieldConfigList getConfigByName:@"VISIT_TO_DT"];
    
    if([CASE_TYPE.text isEqualToString:@"住院"]&&[config.IS_SHOW isEqualToString:@"Y"])
    {
        if(toDtIcon.isHidden)
        {
        CGRect toDtFrame=toDtIcon.frame;
        CGRect reasonFrame=resonIcon.frame;
        CGRect nextbtnFrame=nextButton.frame;
        CGRect imgFrame=imgIcon.frame;
        CGRect clivFrame=clivIcon.frame;
        toDtFrame.origin.y=toDtFrame.origin.y+40;
        reasonFrame.origin.y=reasonFrame.origin.y+40;
        imgFrame.origin.y=imgFrame.origin.y+40;
        clivFrame.origin.y=clivFrame.origin.y+40;
        nextbtnFrame.origin.y=nextbtnFrame.origin.y+40;
        [UIView animateWithDuration:0.3
                         animations:^{
                             toDtIcon.frame = toDtFrame;
                             resonIcon.frame=reasonFrame;
                             nextButton.frame=nextbtnFrame;
                             imgIcon.frame=imgFrame;
                             clivIcon.frame=clivFrame;
                             [toDtIcon setHidden:NO];
                         } completion:^(BOOL finished) {
                             
                         }];
        }
    }
    else
    {
        if (!toDtIcon.isHidden) {
            CGRect toDtFrame=toDtIcon.frame;
            CGRect reasonFrame=resonIcon.frame;
            CGRect nextbtnFrame=nextButton.frame;
            CGRect imgFrame=imgIcon.frame;
            CGRect clivFrame=clivIcon.frame;
            toDtFrame.origin.y=toDtFrame.origin.y-40;
            reasonFrame.origin.y=reasonFrame.origin.y-40;
            imgFrame.origin.y=imgFrame.origin.y-40;
            clivFrame.origin.y=clivFrame.origin.y-40;
            nextbtnFrame.origin.y=nextbtnFrame.origin.y-40;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 toDtIcon.frame = toDtFrame;
                                 resonIcon.frame=reasonFrame;
                                 nextButton.frame=nextbtnFrame;
                                 imgIcon.frame=imgFrame;
                                 clivIcon.frame=clivFrame;
                             } completion:^(BOOL finished) {
                                 [toDtIcon setHidden:YES];
                             }];
            
            
        }
    }
    contentView.contentSize=CGSizeMake(self.view.frame.size.width,nextButton.frame.origin.y+nextButton.frame.size.height+20 );
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField ==APPL_AMT)
        return [self validateNumber:string];
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)nextButtonClick
{
    if(![operType isEqualToString:@"read"])
    {
        for (NSString * key in keyArray) {
            FieldConfig *config= [fieldConfigList getConfigByName:key];
            UIImageView *fieldContainer=(UIImageView*)[currentFields objectForKey:key];
            if([config.IS_REQUIRED isEqualToString:@"Y"])
            {
                UIView *textView= [fieldContainer viewWithTag:100001];
                if([textView isKindOfClass:[UILabel class]])
                {
                    if([((UILabel*)textView).text isEqualToString:[NSString stringWithFormat:@"请选择%@",config.FIELD_DISP_NAME]]&&!fieldContainer.hidden)
                    {
                        [self.navigationController.view makeToast:[NSString stringWithFormat:@"请选择%@",config.FIELD_DISP_NAME]];
                        return;
                    }
                    
                }
                else if([textView isKindOfClass:[UITextField class]])
                {
                    if([((UITextField*)textView).text isEqualToString:[NSString stringWithFormat:@"请输入%@",config.FIELD_DISP_NAME]]||[((UITextField*)textView).text isEqualToString:@""])
                    {
                        [self.navigationController.view makeToast:[NSString stringWithFormat:@"请输入%@",config.FIELD_DISP_NAME]];
                        return;
                    }
                }
                
            }
        }
        
        AppDelegate * appDelegate=[[UIApplication sharedApplication] delegate];
        TUserInfo *user=appDelegate.User;
        currentCaseInfo.CASE_TYPE=self.CASE_TYPE.text;
        currentCaseInfo.MEME_NAME=currentMemeber.MEME_NAME;
        currentCaseInfo.MEME_KY=currentMemeber.MEME_KY;
        currentCaseInfo.MEME_CERT_ID=currentMemeber.MEME_CERT_ID_NUM;
        currentCaseInfo.MAIN_MEME_KY=user.MEME_KY;
        
        currentCaseInfo.COMP_ID=user.COMP_ID;
        currentCaseInfo.COMP_NAME=user.COMP_NAME;
        currentCaseInfo.MNG_ID=user.USUS_MNG_ID;
        currentCaseInfo.MNG_NAME=user.USUS_MNG_NAME;
        currentCaseInfo.REPT_CREATE_DT=[CommonUtil getSysTime];
        currentCaseInfo.QUEUE_CODE=@"Q1001";
        currentCaseInfo.QUEUE_DESC=@"未完成";
        currentCaseInfo.REPT_CREATE_USER=user.USUS_ID;
        currentCaseInfo.DEDE_NAME=self.DEDE_NAME.text;
        currentCaseInfo.APPL_AMT=[self.APPL_AMT.text isEqualToString:@""]?@"0":self.APPL_AMT.text;
        FieldConfig *frmConfig=(FieldConfig*)[ fieldConfigList getConfigByName:@"VISIT_FRM_DT"];
        FieldConfig *toConfig=(FieldConfig*)[ fieldConfigList getConfigByName:@"VISIT_TO_DT"];
        currentCaseInfo.VISIT_FRM_DT=([self.VISIT_FRM_DT.text isEqualToString:@""]||[self.VISIT_FRM_DT.text isEqualToString:[NSString stringWithFormat: @"请选择%@",frmConfig.FIELD_DISP_NAME]])?@"":self.VISIT_FRM_DT.text;
        currentCaseInfo.VISIT_TO_DT=([self.VISIT_TO_DT.text isEqualToString:@""]||[self.VISIT_TO_DT.text isEqualToString:[NSString stringWithFormat: @"请选择%@",toConfig.FIELD_DISP_NAME]])?@"":self.VISIT_TO_DT.text;
        currentCaseInfo.HPHP_NAME=self.HPHP_NAME.text;
        currentCaseInfo.IMG_COUNT=self.IMG_COUNT.text;
        currentCaseInfo.CLIV_COUNT=self.CLIV_COUNT.text;
        
        currentCaseInfo.PLATFORM=[NSString stringWithFormat:@"%@ %@ %@",[[UIDevice currentDevice]model],[[UIDevice currentDevice]systemName],[[UIDevice currentDevice]systemVersion]];
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_case_save];
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: [NSString stringWithFormat:@"%d",currentCaseInfo.REPT_KY]  forKey: @"REPT_KY"];
        [request setPostValue: currentCaseInfo.CASE_TYPE forKey: @"CASE_TYPE"];
        [request setPostValue: currentCaseInfo.MEME_NAME forKey: @"MEME_NAME"];
        [request setPostValue: currentCaseInfo.MEME_KY forKey: @"MEME_KY"];
        [request setPostValue: currentCaseInfo.MAIN_MEME_KY forKey: @"MAIN_MEME_KY"];
        [request setPostValue: currentCaseInfo.MEME_CERT_ID forKey: @"MEME_CERT_ID"];
        [request setPostValue: currentCaseInfo.VISIT_FRM_DT forKey: @"VISIT_FRM_DT"];
        [request setPostValue: currentCaseInfo.VISIT_TO_DT forKey: @"VISIT_TO_DT"];
        [request setPostValue: currentCaseInfo.DEDE_NAME forKey: @"DEDE_NAME"];
        [request setPostValue: currentCaseInfo.HPHP_NAME forKey: @"HPHP_NAME"];
        [request setPostValue: currentCaseInfo.IMG_COUNT forKey: @"IMG_COUNT"];
        [request setPostValue: currentCaseInfo.CLIV_COUNT forKey: @"CLIV_COUNT"];
        [request setPostValue: currentCaseInfo.APPL_AMT forKey: @"APPL_AMT"];
        [request setPostValue: currentCaseInfo.COMP_ID forKey: @"COMP_ID"];
        [request setPostValue: currentCaseInfo.COMP_NAME forKey: @"COMP_NAME"];
        [request setPostValue: currentCaseInfo.MNG_ID forKey: @"MNG_ID"];
        [request setPostValue: currentCaseInfo.MNG_NAME forKey: @"MNG_NAME"];
        [request setPostValue: currentCaseInfo.PLATFORM forKey: @"PLATFORM"];
        [request setPostValue: currentCaseInfo.REPT_CREATE_USER forKey: @"REPT_CREATE_USER"];
        [request setPostValue: currentCaseInfo.REPT_ID forKey: @"REPT_ID"];
        [request setPostValue: @"Q1001" forKey: @"QUEUE_CODE"];
        [request setPostValue: @"未完成" forKey: @"QUEUE_DESC"];
        [request setPostValue: appDelegate.token forKey: @"token"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setDelegate:self];
        [request setTimeOutSeconds:60.0f];
        [request startAsynchronous];
        //显示进度滚动
        [SVProgressHUD show];
    }
    
    else
    {
        QuckClaimsSecViewController *vc=[[QuckClaimsSecViewController alloc] init];
        [vc setCurrentCaseInfo:currentCaseInfo ];
        [vc setOperType:operType];
        [vc setFieldConfigList:fieldConfigList];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"请检查网络是否正确！"];
    
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        TReptCaseInfo *caseInfo=[[JsonTool defaultTool] getTReptCaseInfo:request.responseString withKey:@"model"];
        currentCaseInfo=caseInfo;
        [SVProgressHUD dismiss];
        QuckClaimsSecViewController *vc=[[QuckClaimsSecViewController alloc] init];
        [vc setCurrentCaseInfo:caseInfo ];
        [vc setFieldConfigList:fieldConfigList];
        [vc setOperType:operType];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        [self.navigationController.view makeToast:model.ResultDesc];
        [SVProgressHUD dismiss];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

#pragma mark --
#pragma mark --UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    if(textField==self.DEDE_NAME){
        viewFrame.origin.y=-80;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = viewFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
    return YES;
}

- (void)hideTheKeyBoard
{
    [self.APPL_AMT resignFirstResponder];
    [self.DEDE_NAME resignFirstResponder];
    [self.HPHP_NAME resignFirstResponder];
    [self.IMG_COUNT resignFirstResponder];
    [self.CLIV_COUNT resignFirstResponder];
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = viewFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideTheKeyBoard];
    return YES;
}

/**
 *  隐藏键盘
 *
 *  @param tapgesture
 */
- (void)hideTheKeyBoard:(UITapGestureRecognizer*)tapgesture
{
    [self hideTheKeyBoard];
}

@end
