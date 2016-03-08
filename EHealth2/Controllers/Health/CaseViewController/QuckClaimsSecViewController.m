//
//  QuckClaimsSecViewController.m
//  citic
//
//  Created by echoliu on 15-4-9.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import "QuckClaimsSecViewController.h"
#import "CommonUtil.h"
#import "ZTPickerView.h"
#import "ZTAlertView.h"
#import "QuckClaimsUploadViewController.H"
#import "SVProgressHUD.h"
#import "Pub.h"
#import "BankListViewController.h"
#import "UIKeyboardViewController.h"
#import "NSMutableArray+FieldConfig.h"
#import "UploadViewController.h"
#import "BankCashierAlterViewController.h"

@interface QuckClaimsSecViewController ()
{
    UIScrollView *contentView;
    UIKeyboardViewController *keyBoardController;
    NSMutableDictionary *currentFields;
    NSMutableArray *keyArray;
}

//新增控件

@property (nonatomic, strong) UITextField *BANK_NAME;
@property (nonatomic, strong) UITextField *BANK_NAME_Code;
@property (nonatomic, strong) UITextField *BANK_SITE;
@property (nonatomic, strong) UITextField *ACCOUNT_NAME;
@property (nonatomic, strong) UITextField *ACCOUNT_NO;
@property (nonatomic, strong) UITextField *PHONE_NUM;
@property (nonatomic, strong) UITextField *EMAIL;
@property (nonatomic, strong) UIButton *banknameButton;
@property (nonatomic, strong) UITextField *ADDRESS;
@property (nonatomic, strong) UITextField *ZIP_CODE;
@property (nonatomic, strong) UIButton *nextButton;

-(void)initDataWithModel:(TReptCaseInfo*) model;
@end

@implementation QuckClaimsSecViewController
@synthesize BANK_NAME;
@synthesize BANK_NAME_Code;
@synthesize ACCOUNT_NAME;
@synthesize ACCOUNT_NO;
@synthesize PHONE_NUM;
@synthesize ADDRESS;
@synthesize ZIP_CODE;
@synthesize operType;
@synthesize currentCaseInfo;
@synthesize banknameButton;
@synthesize BANK_SITE;
@synthesize EMAIL;
@synthesize fieldConfigList;
@synthesize nextButton;
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
    contentView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-tableHeaderView.frame.origin.y-tableHeaderView.frame.size.height)];
    [self.view addSubview:contentView];
    //--图片导航结束
    
    //更改银行收款账号
    UIImageView *bankInFo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 10, self.view.frame.size.width, 80.0)];
    [bankInFo setUserInteractionEnabled:YES];
    [bankInFo setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:bankInFo];
    
    UILabel *default_BankName=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, (self.view.bounds.size.width/2)-50, 40)];
    [default_BankName setText:@"银行名称:工商银行"];
    [default_BankName setFont:[UIFont systemFontOfSize:13]];
    //default_BankName.backgroundColor=[UIColor redColor];
    [bankInFo addSubview:default_BankName];
    
    UILabel *default_AccountID=[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-30, 0, (self.view.bounds.size.width/2)+10, 40)];
    [default_AccountID setText:@"123456789012345678111"];
    [default_AccountID setFont:[UIFont systemFontOfSize:13]];
    default_AccountID.backgroundColor=[UIColor greenColor];
    [bankInFo addSubview:default_AccountID];
    
    UILabel *default_AccountName=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, (self.view.bounds.size.width/2)-50, 40)];
    [default_AccountName setText:@"账户名:"];
    [default_AccountName setFont:[UIFont systemFontOfSize:13]];
    default_AccountName.backgroundColor=[UIColor blueColor];
    [bankInFo addSubview:default_AccountName];
    
    UILabel *default_PhoneNum=[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-30, 40, (self.view.bounds.size.width/2)+10, 40)];
    [default_PhoneNum setText:@"手机:"];
    [default_PhoneNum setFont:[UIFont systemFontOfSize:13]];
    [bankInFo addSubview:default_PhoneNum];
    
    
    UIButton *bankBtn=[[UIButton alloc]init];
    bankBtn.frame=bankInFo.bounds;
    bankBtn.backgroundColor=[UIColor clearColor];
    [bankBtn addTarget:self action:@selector(bankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bankInFo addSubview:bankBtn];
    
    
    
    //银行
    UIImageView *banknameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, bankInFo.bounds.size.height+20, self.view.frame.size.width, 40.0)];
    [banknameIcon setUserInteractionEnabled:YES];
    [banknameIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:banknameIcon];
    
    UILabel *banknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [banknameLabel setFont:[UIFont systemFontOfSize:15]];
    [banknameLabel setText:@"银行名称"];
    [banknameLabel setTextAlignment:NSTextAlignmentLeft];
    [banknameLabel setTextColor:[UIColor blackColor]];
    [banknameIcon addSubview:banknameLabel];
    banknameLabel.tag=100000;
    
    if (self.BANK_NAME == nil) {
        BANK_NAME = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-295, 0, 235, 40)];
        BANK_NAME_Code = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-295, 0, 230, 40)];
    }
    [BANK_NAME setTextAlignment:NSTextAlignmentRight];
    [BANK_NAME setDelegate:self];
    [BANK_NAME setFont:[UIFont systemFontOfSize:15]];
    [BANK_NAME setPlaceholder:@"请输入或选择银行"];
    [BANK_NAME setReturnKeyType:UIReturnKeyDone];
    [BANK_NAME_Code setHidden:YES];
    BANK_NAME.tag=100001;
    [banknameIcon addSubview:BANK_NAME];
    [banknameIcon addSubview:BANK_NAME_Code];
    
    //加载事件的按钮
    banknameButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50,5, 30, 30)];
    [banknameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [banknameButton setBackgroundImage:[UIImage imageNamed:@"icon_add1"] forState:UIControlStateNormal];
    [banknameButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [banknameButton setTitle:@"" forState:UIControlStateNormal];
    [banknameButton addTarget:self
                       action:@selector(banknameButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
    [banknameIcon addSubview:banknameButton];
    [currentFields setObject:banknameIcon forKey:@"BANK_NAME"];
    
    
    UIImageView *banksiteIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, banknameIcon.frame.origin.y+banknameIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [banksiteIcon setUserInteractionEnabled:YES];
    [banksiteIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:banksiteIcon];
    
    UILabel *banksiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [banksiteLabel setFont:[UIFont systemFontOfSize:15]];
    [banksiteLabel setText:@"银行网点"];
    banksiteLabel.tag=100000;
    [banksiteLabel setTextAlignment:NSTextAlignmentLeft];
    [banksiteLabel setTextColor:[UIColor blackColor]];
    [banksiteIcon addSubview:banksiteLabel];
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.BANK_SITE == nil) {
        BANK_SITE = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (banksiteIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [BANK_SITE setDelegate:self];
    [BANK_SITE setPlaceholder:@"请输入银行网点"];
    [BANK_SITE setBackgroundColor:[UIColor whiteColor]];
    [BANK_SITE setFont:[UIFont systemFontOfSize:13.0f]];
    [BANK_SITE setTextColor:[UIColor blackColor]];
    [BANK_SITE setText:@""];
    BANK_SITE.tag=100001;
    [BANK_SITE setTextAlignment:NSTextAlignmentRight];
    [BANK_SITE setReturnKeyType:UIReturnKeyDone];
    [BANK_SITE.layer setCornerRadius:3.0];
    [banksiteIcon addSubview:BANK_SITE];
    
    [currentFields setObject:banksiteIcon forKey:@"BANK_SITE"];
    //账户名------------------------------
    UIImageView *accountnameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, banksiteIcon.frame.origin.y+banksiteIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [accountnameIcon setUserInteractionEnabled:YES];
    [accountnameIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:accountnameIcon];
    
    UILabel *accountnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [accountnameLabel setFont:[UIFont systemFontOfSize:15]];
    [accountnameLabel setText:@"账户名"];
    accountnameLabel.tag=100000;
    [accountnameLabel setTextAlignment:NSTextAlignmentLeft];
    [accountnameLabel setTextColor:[UIColor blackColor]];
    [accountnameIcon addSubview:accountnameLabel];
    
    if (self.ACCOUNT_NAME == nil) {
        ACCOUNT_NAME = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (accountnameIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [ACCOUNT_NAME setDelegate:self];
    [ACCOUNT_NAME setPlaceholder:@"请输入账户名"];
    [ACCOUNT_NAME setBackgroundColor:[UIColor whiteColor]];
    [ACCOUNT_NAME setFont:[UIFont systemFontOfSize:13.0f]];
    [ACCOUNT_NAME setTextColor:[UIColor blackColor]];
    [ACCOUNT_NAME setText:@""];
    ACCOUNT_NAME.tag=100001;
    [ACCOUNT_NAME setTextAlignment:NSTextAlignmentRight];
    [ACCOUNT_NAME setReturnKeyType:UIReturnKeyDone];
    [ACCOUNT_NAME.layer setCornerRadius:3.0];
    [accountnameIcon addSubview:ACCOUNT_NAME];
    
    [currentFields setObject:accountnameIcon forKey:@"ACCOUNT_NAME"];
    
    //账户号
    UIImageView *accountnoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, accountnameIcon.frame.origin.y+accountnameIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [accountnoIcon setUserInteractionEnabled:YES];
    [accountnoIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:accountnoIcon];
    
    UILabel *accountnoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [accountnoLabel setFont:[UIFont systemFontOfSize:15]];
    [accountnoLabel setText:@"账号"];
    accountnoLabel.tag=100000;
    [accountnoLabel setTextAlignment:NSTextAlignmentLeft];
    [accountnoLabel setTextColor:[UIColor blackColor]];
    [accountnoIcon addSubview:accountnoLabel];
    
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.ACCOUNT_NO == nil) {
        ACCOUNT_NO = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (accountnoIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [ACCOUNT_NO setDelegate:self];
    [ACCOUNT_NO setPlaceholder:@"请输入账号"];
    [ACCOUNT_NO setBackgroundColor:[UIColor whiteColor]];
    [ACCOUNT_NO setFont:[UIFont systemFontOfSize:13.0f]];
    [ACCOUNT_NO setTextColor:[UIColor blackColor]];
    [ACCOUNT_NO setText:@""];
    ACCOUNT_NO.tag=100001;
    [ACCOUNT_NO setTextAlignment:NSTextAlignmentRight];
    [ACCOUNT_NO setReturnKeyType:UIReturnKeyDone];
    [ACCOUNT_NO.layer setCornerRadius:3.0];
    [ACCOUNT_NO setKeyboardType:UIKeyboardTypeNumberPad];
    [accountnoIcon addSubview:ACCOUNT_NO];
    
    [currentFields setObject:accountnoIcon forKey:@"ACCOUNT_NO"];
    //电话
    UIImageView *phonenumIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, accountnoIcon.frame.origin.y+accountnoIcon.frame.size.height+10, self.view.frame.size.width, 40.0)];
    [phonenumIcon setUserInteractionEnabled:YES];
    [phonenumIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:phonenumIcon];
    
    
    UILabel *phonenumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [phonenumLabel setFont:[UIFont systemFontOfSize:15]];
    [phonenumLabel setText:@"手机"];
    phonenumLabel.tag=100000;
    [phonenumLabel setTextAlignment:NSTextAlignmentLeft];
    [phonenumLabel setTextColor:[UIColor blackColor]];
    [phonenumIcon addSubview:phonenumLabel];
    
    //定义的身份证号码输入控件 全局
    if (self.PHONE_NUM == nil) {
        PHONE_NUM = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (phonenumIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [PHONE_NUM setDelegate:self];
    [PHONE_NUM setPlaceholder:@"请输入手机"];
    [PHONE_NUM setBackgroundColor:[UIColor whiteColor]];
    [PHONE_NUM setFont:[UIFont systemFontOfSize:13.0f]];
    [PHONE_NUM setTextColor:[UIColor blackColor]];
    [PHONE_NUM setText:@""];
    PHONE_NUM.tag=100001;
    [PHONE_NUM setTextAlignment:NSTextAlignmentRight];
    [PHONE_NUM setReturnKeyType:UIReturnKeyDone];
    [PHONE_NUM setKeyboardType:UIKeyboardTypePhonePad];
    [PHONE_NUM.layer setCornerRadius:3.0];
    [phonenumIcon addSubview:PHONE_NUM];
    [currentFields setObject:phonenumIcon forKey:@"PHONE_NUM"];
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, phonenumIcon.frame.origin.y+phonenumIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [emailIcon setUserInteractionEnabled:YES];
    [emailIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:emailIcon];
    
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [emailLabel setFont:[UIFont systemFontOfSize:15]];
    [emailLabel setText:@"电子邮箱"];
    emailLabel.tag=100000;
    [emailLabel setTextAlignment:NSTextAlignmentLeft];
    [emailLabel setTextColor:[UIColor blackColor]];
    [emailIcon addSubview:emailLabel];
    //定义的身份证号码输入控件 全局
    if (self.EMAIL == nil) {
        EMAIL = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (emailIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [EMAIL setDelegate:self];
    [EMAIL setPlaceholder:@"请输入电子邮箱"];
    [EMAIL setBackgroundColor:[UIColor whiteColor]];
    [EMAIL setFont:[UIFont systemFontOfSize:13.0f]];
    [EMAIL setTextColor:[UIColor blackColor]];
    [EMAIL setText:@""];
    EMAIL.tag=100001;
    [EMAIL setTextAlignment:NSTextAlignmentRight];
    [EMAIL setReturnKeyType:UIReturnKeyDone];
    [EMAIL setKeyboardType:UIKeyboardTypeEmailAddress];
    [EMAIL.layer setCornerRadius:3.0];
    [emailIcon addSubview:EMAIL];
    [currentFields setObject:emailIcon forKey:@"EMAIL"];
    
    //地址
    UIImageView *addressIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, emailIcon.frame.origin.y+emailIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [addressIcon setUserInteractionEnabled:YES];
    [addressIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:addressIcon];
    
    UILabel *resonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [resonLabel setFont:[UIFont systemFontOfSize:15]];
    [resonLabel setText:@"地址"];
    resonLabel.tag=100000;
    [resonLabel setTextAlignment:NSTextAlignmentLeft];
    [resonLabel setTextColor:[UIColor blackColor]];
    [addressIcon addSubview:resonLabel];
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.ADDRESS == nil) {
        ADDRESS = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (addressIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [ADDRESS setDelegate:self];
    [ADDRESS setPlaceholder:@"请输入地址"];
    [ADDRESS setBackgroundColor:[UIColor whiteColor]];
    [ADDRESS setFont:[UIFont systemFontOfSize:13.0f]];
    [ADDRESS setTextColor:[UIColor blackColor]];
    [ADDRESS setText:@""];
    ADDRESS.tag=100001;
    [ADDRESS setTextAlignment:NSTextAlignmentRight];
    [ADDRESS setReturnKeyType:UIReturnKeyDone];
    [ADDRESS.layer setCornerRadius:3.0];
    [addressIcon addSubview:ADDRESS];
    [currentFields setObject:addressIcon forKey:@"ADDRESS"];
    //邮编
    UIImageView *zipcodeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, addressIcon.frame.origin.y+addressIcon.frame.size.height, self.view.frame.size.width, 40.0)];
    [zipcodeIcon setUserInteractionEnabled:YES];
    [zipcodeIcon setImage:[UIImage imageNamed:@"common_cell_bg.png"]];
    [contentView addSubview:zipcodeIcon];
    
    UILabel *zipcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 90.0, 40.0)];
    [zipcodeLabel setFont:[UIFont systemFontOfSize:15]];
    [zipcodeLabel setText:@"邮编"];
    zipcodeLabel.tag=100000;
    [zipcodeLabel setTextAlignment:NSTextAlignmentLeft];
    [zipcodeLabel setTextColor:[UIColor blackColor]];
    [zipcodeIcon addSubview:zipcodeLabel];
    //输入框
    //定义的身份证号码输入控件 全局
    if (self.ZIP_CODE == nil) {
        ZIP_CODE = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-235, (zipcodeIcon.frame.size.height-30)/2.0, 215, 30)];
    }
    [ZIP_CODE setDelegate:self];
    [ZIP_CODE setPlaceholder:@"请输入邮编"];
    [ZIP_CODE setBackgroundColor:[UIColor whiteColor]];
    [ZIP_CODE setFont:[UIFont systemFontOfSize:13.0f]];
    [ZIP_CODE setTextColor:[UIColor blackColor]];
    [ZIP_CODE setText:@""];
    ZIP_CODE.tag=100001;
    [ZIP_CODE setTextAlignment:NSTextAlignmentRight];
    [ZIP_CODE setKeyboardType:UIKeyboardTypeNumberPad];
    [ZIP_CODE setReturnKeyType:UIReturnKeyDone];
    [ZIP_CODE.layer setCornerRadius:3.0];
    [zipcodeIcon addSubview:ZIP_CODE];
    [currentFields setObject:zipcodeIcon forKey:@"ZIP_CODE"];
    keyArray=[[NSMutableArray alloc]initWithObjects:@"BANK_NAME",@"BANK_SITE",@"ACCOUNT_NAME",@"ACCOUNT_NO",@"PHONE_NUM",@"EMAIL",@"ADDRESS",@"ZIP_CODE",nil];
    //按钮下一步
    nextButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-270)/2.0, zipcodeIcon.frame.size.height+zipcodeIcon.frame.origin.y+20, 270, 49)];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(nextButtonClick)
         forControlEvents:UIControlEventTouchUpInside];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [contentView addSubview:nextButton];
    
    contentView.contentSize=CGSizeMake(self.view.frame.size.width,nextButton.frame.origin.y+nextButton.frame.size.height+20 );
    
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
        //        if(![currentCaseInfo.REPT_ID isEqualToString:@""])
        //        {
        [self initDataWithModel:currentCaseInfo];
        //        }
    }
    
    //RegisterBankNotification
    //观察者观察
    /*为弹出框返回做准备 注册一个通知事件  这是一个观察者模式*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerBankCompletion:)
                                                 name:@"RegisterBankNotification"
                                               object:nil];
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
            
            position+= 40;
            [fieldContainer setHidden:YES];
        }
        
    }
    CGRect frame= nextButton.frame;
    frame.origin.y=nextBtnPosition;
    nextButton.frame=frame;
    contentView.contentSize=CGSizeMake(self.view.frame.size.width,nextButton.frame.origin.y+nextButton.frame.size.height+20 );
}

/**
 * 这是一个通知事件方法 当弹出页面返回的时候 接收到此参数
 */
-(void)registerBankCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    TReptBankInfo * bankinfo = [theData objectForKey:@"popitemname"];
    
    NSLog(@"username = %@",currentCaseInfo.BANK_NAME);
    /*获取返回值 刷新本页列表*/
    currentCaseInfo.BANK_CODE=bankinfo.BANK_CODE;
    currentCaseInfo.BANK_NAME=bankinfo.BANK_NAME;
    [self.BANK_NAME setText:currentCaseInfo.BANK_NAME];
    [self.BANK_NAME_Code setText:currentCaseInfo.BANK_CODE];
}


-(void)initDataWithModel:(TReptCaseInfo *)model
{
    if([operType isEqualToString:@"read"])
    {
        //银行
        [BANK_NAME setUserInteractionEnabled:NO];
        [banknameButton setUserInteractionEnabled:NO];
        [ACCOUNT_NO setUserInteractionEnabled:NO];
        [ACCOUNT_NAME setUserInteractionEnabled:NO];
        [PHONE_NUM setUserInteractionEnabled:NO];
        [ADDRESS setUserInteractionEnabled:NO];
        [ZIP_CODE setUserInteractionEnabled:NO];
        [BANK_SITE setUserInteractionEnabled:NO];
        [EMAIL setUserInteractionEnabled:NO];
    }
    currentCaseInfo.MEME_KY=model.MEME_KY;
    currentCaseInfo.MEME_NAME=model.MEME_NAME;
    currentCaseInfo.MEME_CERT_ID=model.MEME_CERT_ID;
    currentCaseInfo.BANK_CODE=model.BANK_CODE;
    currentCaseInfo.BANK_NAME=model.BANK_NAME;
    self.BANK_NAME.text=model.BANK_NAME;
    self.BANK_NAME_Code.text=model.BANK_CODE;
    self.ACCOUNT_NAME.text=model.ACCOUNT_NAME;
    self.ACCOUNT_NO.text=model.ACCOUNT_NO;
    self.ADDRESS.text=model.ADDRESS;
    self.PHONE_NUM.text=model.PHONE_NUM;
    self.ZIP_CODE.text=model.ZIP_CODE;
    self.BANK_SITE.text=model.BANK_SITE;
    self.EMAIL.text=model.EMAIL;
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)banknameButtonClick
{
    BankListViewController *policyViewController = [[BankListViewController alloc] init];
    [self.navigationController pushViewController:policyViewController animated:YES];
    //先获取返回结果 加载到对象中 传递到下一个也没
    
    NSLog(@"banknameButtonClick");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



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
        
        currentCaseInfo.BANK_NAME=self.BANK_NAME.text;
        currentCaseInfo.BANK_CODE=self.BANK_NAME_Code.text;
        currentCaseInfo.ACCOUNT_NO=self.ACCOUNT_NO.text;
        currentCaseInfo.ACCOUNT_NAME=self.ACCOUNT_NAME.text;
        currentCaseInfo.PHONE_NUM=self.PHONE_NUM.text;
        currentCaseInfo.ADDRESS=self.ADDRESS.text;
        currentCaseInfo.ZIP_CODE=self.ZIP_CODE.text;
        currentCaseInfo.EMAIL=self.EMAIL.text;
        currentCaseInfo.BANK_SITE=self.BANK_SITE.text;
        
        //采用ASIHttp框架来实现
        NSURL *url =[NSURL URLWithString:api_case_save];
        
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: currentCaseInfo.BANK_NAME forKey: @"BANK_NAME"];
        [request setPostValue: currentCaseInfo.BANK_CODE forKey: @"BANK_CODE"];
        [request setPostValue: currentCaseInfo.ACCOUNT_NAME forKey: @"ACCOUNT_NAME"];
        [request setPostValue: currentCaseInfo.ACCOUNT_NO forKey: @"ACCOUNT_NO"];
        [request setPostValue: currentCaseInfo.PHONE_NUM forKey: @"PHONE_NUM"];
        [request setPostValue: currentCaseInfo.ADDRESS forKey: @"ADDRESS"];
        [request setPostValue: currentCaseInfo.ZIP_CODE forKey: @"ZIP_CODE"];
        [request setPostValue: currentCaseInfo.APPL_AMT forKey: @"APPL_AMT"];
        [request setPostValue: currentCaseInfo.BANK_SITE forKey: @"BANK_SITE"];
        [request setPostValue: currentCaseInfo.EMAIL forKey: @"EMAIL"];
        [request setPostValue: [NSString stringWithFormat:@"%d",currentCaseInfo.REPT_KY]  forKey: @"REPT_KY"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
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
        UploadViewController *vc=[[UploadViewController alloc] init];
        [vc setOperType:operType];
        [vc setCurrentCaseInfo:currentCaseInfo ];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

/*ASIHttp异步请求处理*/

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"网络异常！"];
    [SVProgressHUD dismiss];
    
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        //[SVProgressHUD dismiss];
        // 3.跳转窗口
        UploadViewController *vc=[[UploadViewController alloc] init];
        [vc setOperType:operType];
        [vc setCurrentCaseInfo:currentCaseInfo ];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        [self.navigationController.view makeToast:model.ResultDesc];
        [SVProgressHUD dismiss];
    }
}
/*ASIHttp异步请求 结束*/



#pragma mark --
#pragma mark --UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    if (textField == self.PHONE_NUM) {
        viewFrame.origin.y = -40;
    }else if(textField==self.ADDRESS){
        viewFrame.origin.y=-80;
    }
    else if(textField==self.ZIP_CODE){
        viewFrame.origin.y=-120;
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
    [self.BANK_NAME resignFirstResponder];
    [self.ACCOUNT_NAME resignFirstResponder];
    [self.ACCOUNT_NO resignFirstResponder];
    [self.PHONE_NUM resignFirstResponder];
    [self.ADDRESS resignFirstResponder];
    [self.ZIP_CODE resignFirstResponder];
    [self.EMAIL resignFirstResponder];
    [self.BANK_SITE resignFirstResponder];
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


#pragma mark--点击更改收款银行信息
-(void)bankBtnClick{
    BankCashierAlterViewController *bankAlter=[[BankCashierAlterViewController alloc]init];

    [self presentViewController:bankAlter animated:YES completion:nil];
}

@end
