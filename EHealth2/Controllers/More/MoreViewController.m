//
//  MoreViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/5/22.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "MoreViewController.h"
#import "Setting.h"
#import "ChangePwdViewController.h"
#import "CommonUtil.h"

@interface MoreViewController ()
{
    UITableView * _tableView;
    NSArray *myListArray;
}
@end

@implementation MoreViewController
//@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
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

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-48)];
    Setting *s1=[[Setting alloc]initWithParameters:@"修改密码" andSubTitle:@"" andImage:@"ic_change" andType:Redirect andName:@"" andController:@"ModifyPwdViewController"];
    Setting *s2=[[Setting alloc]initWithParameters:@"帮助中心" andSubTitle:@"" andImage:@"ic_help" andType:Redirect andName:@"" andController:@"HelpViewController"];
    Setting *s4=[[Setting alloc]initWithParameters:@"联系我们" andSubTitle:@"" andImage:@"ic_contact_us" andType:Redirect andName:@"" andController:@"ContactUsViewController"];
    Setting *s3=[[Setting alloc]initWithParameters:@"关于" andSubTitle:@"" andImage:@"ic_about" andType:Redirect andName:@"" andController:@"AboutAppViewController"];
    
    if([compID isEqualToString:@"C000016"])
    {
        myListArray=[[NSArray alloc]initWithObjects:s1,s2,s4,s3 , nil];
    }
    else
    {
        myListArray=[[NSArray alloc]initWithObjects:s1,s2,s3 , nil];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,10)];
    _tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,10)];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==myListArray.count)
        return 80;
    return 44;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myListArray count]+1;
    //只有一组，数组数即为行数。
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //这个方法返回的cell代表每一行显示的内容，每显示一行都会运行一次此方法。
    
    NSUInteger rowNum = [indexPath row];
    static NSString *NOTIFY = @"随便";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
    //寻找已经加上自定义标注的当前可重用的cell。
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NOTIFY];
        //找不到可重用的cell，就再生成一个，格式为默认，加上自定义标注；
        //if条件里面的是肯定先运行的，在第一次运行时都不可能找到可重用的加上标注的cell
        //只有列表滑动将已有行给挤出当前view时，挤出的那个cell才会变为可重用的
    }
    if(rowNum<myListArray.count)
    {
        Setting *setting=(Setting*)[myListArray objectAtIndex:indexPath.row];
        cell.textLabel.text=setting.title;
        cell.imageView.image=[UIImage imageNamed:setting.image];
        if(setting.type==Redirect)
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//跳转箭头
        }
        else if(setting.type==Switch)
        {
            UISwitch *sw=[[UISwitch alloc]init];
            cell.accessoryView=sw;
        }
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 18, self.view.frame.size.width-60, 44)];
        [button setBackgroundImage:[UIImage imageNamed:@"common_exit_bg.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"退 出 登 录" forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(exiteLoginButtonClick)
         forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
    }
    //将当前行的显示的label设为已定义数组中的一个。
    //indexPath.row代表当前行
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Setting *setting=(Setting*)[myListArray objectAtIndex:indexPath.row];
    //[self performSegueWithIdentifier:@"changePWD" sender:self];
    if(indexPath.row<myListArray.count)
    {
        Setting *setting=(Setting*)[myListArray objectAtIndex:indexPath.row];
        id viewController=[[NSClassFromString(setting.controller) alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

-(void)exiteLoginButtonClick
{
    NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    TLoginLogInfo *log=[[JsonTool defaultTool] getTLoginLogInfo:cacheString withKey:@"log"];
    
    NSURL *url =[NSURL URLWithString:api_user_loginout];
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
    [request setPostValue: log.SYSV_KY forKey: @"SYSV_KY"];
    AppDelegate *delegate=   (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [request setPostValue: delegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setValidatesSecureCertificate:NO];
    [request setDelegate:self];
    [request startAsynchronous];
    //显示进度滚动
    [SVProgressHUD show];

    
    }

//ASIHttp失败的处理方式
-(void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(request.error.description);
    [self.navigationController.view makeToast:[NSString stringWithFormat:@"网络异常！"]];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    if(model.ResultCode==0 ){
        NSLog(@"退出成功，跳转登录页面");
        LoginViewController *homeviewController = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:homeviewController animated:YES];
        
    }else{
        [SVProgressHUD dismiss];
        [self.navigationController.view makeToast:model.ResultDesc];
        NSLog(@"退出成功！");
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
