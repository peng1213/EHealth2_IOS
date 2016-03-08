//
//  WeatherViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/28.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "WeatherViewController.h"
#import "CommonUtil.h"
#import "Pub.h"
#import "SVProgressHUD.h"
#import "MarqueeLabel.h"
#import "CityViewController.h"
#import "ConfigTool.h"

@interface WeatherViewController ()
{
    
    UILabel *titleLable;
    
    UIImageView *icon1;
    UILabel *temp1;
    UILabel *weather1;
    UILabel *air;
    UILabel *wind1;
    MarqueeLabel *suggest;
    
    UIImageView *icon2;
    UILabel *temp2;
    UILabel *weather2;
    UILabel *wind2;
    
    UIImageView *icon3;
    UILabel *temp3;
    UILabel *weather3;
    UILabel *wind3;
    NSString *cityCode;
}
@end

@implementation WeatherViewController
-(void)viewWillAppear:(BOOL)animated
{
    //避免过多刷新
    //if(![ cityCode isEqualToString:[[ConfigTool Instance]getWeatherCode]])
         [self loadWeather:[[ConfigTool Instance]getWeatherCode]];
    [self loadWeather];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cityCode=[[ConfigTool Instance]getWeatherCode];
    UIImage *image= [UIImage imageNamed:@"app_bg02.png"];
    self.view.layer.contents = (id) image.CGImage;
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    //[navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 27.0, 30.0, 30.0)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_add_icon"] forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(loadCity)
          forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:rightButton];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40.0f,10.0f,self.view.frame.size.width-80,64.0f)];
    [titleLable setText:@"北京"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    UIImageView *top=[[UIImageView alloc] initWithFrame:CGRectMake(2.0f,70.0f,self.view.frame.size.width-5, 200.0f)];
    [top setImage:[UIImage imageNamed:@"item_bg"]];
    [top setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:top];
    
    icon1=[[UIImageView alloc] initWithFrame:CGRectMake(2.0f,70.0f,160.0f, 160.0f)];
    [icon1 setImage:[UIImage imageNamed:@"weathericon_condition_01"]];
    [icon1 setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:icon1];
    
    temp1=[[UILabel alloc]initWithFrame:CGRectMake(160+2, 90, self.view.frame.size.width-5-160, 30)];
    [temp1 setFont:[UIFont boldSystemFontOfSize:24]];
    [temp1 setTextColor:[CommonUtil getColor:@"FFD700" withAlpha:1.0f]];
    [temp1 setText:@"13℃～10℃"];
    [temp1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:temp1];
    
    weather1=[[UILabel alloc]initWithFrame:CGRectMake(160+2, 90+40, self.view.frame.size.width-5-160, 30)];
    [weather1 setFont:[UIFont boldSystemFontOfSize:24]];
    [weather1 setTextColor:[UIColor whiteColor]];
    [weather1 setText:@"13℃～10℃"];
    [weather1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:weather1];
    
    air=[[UILabel alloc]initWithFrame:CGRectMake(160+2, 90+40*2, self.view.frame.size.width-5-160, 30)];
    [air setFont:[UIFont boldSystemFontOfSize:24]];
    [air setTextColor:[UIColor whiteColor]];
    [air setText:@"13℃～10℃"];
    [air setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:air];
    
    wind1=[[UILabel alloc]initWithFrame:CGRectMake(160+2, 90+40*3, self.view.frame.size.width-5-160, 30)];
    [wind1 setFont:[UIFont boldSystemFontOfSize:24]];
    [wind1 setTextColor:[UIColor whiteColor]];
    [wind1 setText:@"13℃～10℃"];
    [wind1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:wind1];
    
    
    suggest=[[MarqueeLabel alloc]initWithFrame:CGRectMake(6, 90+40*4, self.view.frame.size.width-14, 30)];
    [suggest setFont:[UIFont boldSystemFontOfSize:18]];
    [suggest setTextColor:[UIColor whiteColor]];
    [suggest setText:@"13℃～10℃"];
    [suggest setTextAlignment:NSTextAlignmentCenter];
    suggest.marqueeType = MLLeftRight;
    [self.view addSubview:suggest];
    
    UIImageView *mid=[[UIImageView alloc] initWithFrame:CGRectMake(2.0f,270.0f,self.view.frame.size.width-5, 50.0f)];
    [mid setImage:[UIImage imageNamed:@"item_mid"]];
    [mid setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:mid];
    
    UILabel *day1=[[UILabel alloc]initWithFrame:CGRectMake(0, 295, self.view.frame.size.width/2, 30)];
    [day1 setText:@"明天"];
    [day1 setTextAlignment:NSTextAlignmentCenter];
    [day1 setFont:[UIFont boldSystemFontOfSize:16]];
    [day1 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:day1];
    UILabel *day2=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 295, self.view.frame.size.width/2, 30)];
    [day2 setText:@"后天"];
    [day2 setTextAlignment:NSTextAlignmentCenter];
    [day2 setFont:[UIFont boldSystemFontOfSize:16]];
    [day2 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:day2];
    
    
    icon2=[[UIImageView alloc] initWithFrame:CGRectMake(2.0f,320.0f,self.view.frame.size.width/2-80, self.view.frame.size.width/2-80)];
    [icon2 setImage:[UIImage imageNamed:@"weathericon_condition_01"]];
    [icon2 setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:icon2];
    
    weather2=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-80+2, 320, 80, self.view.frame.size.width/2-80)];
    [weather2 setFont:[UIFont boldSystemFontOfSize:16]];
    [weather2 setTextColor:[UIColor whiteColor]];
    [weather2 setText:@"13℃～10℃"];
    [weather2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:weather2];
    
    temp2=[[UILabel alloc]initWithFrame:CGRectMake(0,320+self.view.frame.size.width/2-80, self.view.frame.size.width/2, 30)];
    [temp2 setFont:[UIFont boldSystemFontOfSize:16]];
    [temp2 setTextColor:[UIColor whiteColor]];
    [temp2 setText:@"13℃～10℃"];
    [temp2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:temp2];
    
    
    wind2=[[UILabel alloc]initWithFrame:CGRectMake(0, 320+self.view.frame.size.width/2-80+30, self.view.frame.size.width/2, 30)];
    [wind2 setFont:[UIFont boldSystemFontOfSize:16]];
    [wind2 setTextColor:[UIColor whiteColor]];
    [wind2 setText:@"13℃～10℃"];
    [wind2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:wind2];
    
    
    icon3=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,320.0f,self.view.frame.size.width/2-80, self.view.frame.size.width/2-80)];
    [icon3 setImage:[UIImage imageNamed:@"weathericon_condition_01"]];
    [icon3 setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:icon3];
    
    weather3=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 320, 80, self.view.frame.size.width/2-80)];
    [weather3 setFont:[UIFont boldSystemFontOfSize:16]];
    [weather3 setTextColor:[UIColor whiteColor]];
    [weather3 setText:@"13℃～10℃"];
    [weather3 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:weather3];
    
    temp3=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,320+self.view.frame.size.width/2-80, self.view.frame.size.width/2, 30)];
    [temp3 setFont:[UIFont boldSystemFontOfSize:16]];
    [temp3 setTextColor:[UIColor whiteColor]];
    [temp3 setText:@"13℃～10℃"];
    [temp3 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:temp3];
    
    
    wind3=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 320+self.view.frame.size.width/2-80+30, self.view.frame.size.width/2, 30)];
    [wind3 setFont:[UIFont boldSystemFontOfSize:16]];
    [wind3 setTextColor:[UIColor whiteColor]];
    [wind3 setText:@"13℃～10℃"];
    [wind3 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:wind3];
    
    UIImageView *bottom=[[UIImageView alloc] initWithFrame:CGRectMake(2.0f,320.0f,self.view.frame.size.width-5, 200.0f)];
    [bottom setImage:[UIImage imageNamed:@"item_bg"]];
    [bottom setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:bottom];
 
}

-(void)loadWeather:(NSString*) cityCode
{
    [SVProgressHUD show];
    //NSString * cacheString=[[ConfigTool Instance] getCacheWithKey:cache_user_login];
    NSString *u=[NSString stringWithFormat: @"%@%@",api_weather_get,cityCode];
    NSURL *url =[ NSURL URLWithString : u];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request setDelegate:self];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    [request startSynchronous];
    NSString *resultString=request.responseString;
    NSLog(@"%@",resultString);
    [[ConfigTool Instance]saveCacheWithKey:cache_weather_get andData:resultString];
    [SVProgressHUD dismiss];
}

-(void)loadWeather
{
    NSString *resultString=[[ConfigTool Instance]getCacheWithKey:cache_weather_get];
    NSData * jsonData=[resultString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error=nil;
    NSDictionary *resultDict =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    NSDictionary *dict1=[resultDict valueForKey:@"forecast"];
    NSDictionary *dict2=[[resultDict valueForKey:@"index"] objectAtIndex:1];
    NSDictionary *dict3=[resultDict valueForKey:@"aqi"];
    
    if([[dict1 allKeys] containsObject:@"city"])
        titleLable.text=[dict1 objectForKey:@"city"];
    if([[dict1 allKeys] containsObject:@"temp1"])
        temp1.text=[self convertTemp:[dict1 objectForKey:@"temp1"]] ;
    if([[dict1 allKeys] containsObject:@"weather1"])
    {
        weather1.text=[dict1 objectForKey:@"weather1"];
        icon1.image=[self getWeatherImage:[dict1 objectForKey:@"weather1"]];
    }
    if([[dict3 allKeys] containsObject:@"aqi"])
        air.text=[self getAir:[dict3 objectForKey:@"aqi"]];
    if([[dict1 allKeys] containsObject:@"wind1"])
        wind1.text=[dict1 objectForKey:@"wind1"];
    if([[dict2 allKeys] containsObject:@"details"])
        suggest.text=[dict2 objectForKey:@"details"];
    if([[dict1 allKeys] containsObject:@"weather2"])
    {
        weather2.text=[dict1 objectForKey:@"weather2"];
        icon2.image=[self getWeatherImage:[dict1 objectForKey:@"weather2"]];
    }
    if([[dict1 allKeys] containsObject:@"temp2"])
        temp2.text=[self convertTemp:[dict1 objectForKey:@"temp2"]] ;
    if([[dict1 allKeys] containsObject:@"wind2"])
        wind2.text=[dict1 objectForKey:@"wind2"];
    if([[dict1 allKeys] containsObject:@"weather3"])
    {
        weather3.text=[dict1 objectForKey:@"weather3"];
        icon3.image=[self getWeatherImage:[dict1 objectForKey:@"weather3"]];
    }
    if([[dict1 allKeys] containsObject:@"temp3"])
        temp3.text=[self convertTemp:[dict1 objectForKey:@"temp3"]] ;
    if([[dict1 allKeys] containsObject:@"wind3"])
        wind3.text=[dict1 objectForKey:@"wind3"];
    
}

-(UIImage *)getWeatherImage:(NSString*)weather
{
    if ([CommonUtil contains:weather conStr:@"晴"]) {
        return [UIImage imageNamed:@"weathericon_condition_01"];
    }
    else if([CommonUtil contains:weather conStr:@"多云"]) {
        return [UIImage imageNamed:@"weathericon_condition_02"];
    }
    else if([CommonUtil contains:weather conStr:@"阴"]) {
        return [UIImage imageNamed:@"weathericon_condition_04"];
    }
    else if([CommonUtil contains:weather conStr:@"雾"]) {
        return [UIImage imageNamed:@"weathericon_condition_05"];
    }
    else if([CommonUtil contains:weather conStr:@"沙尘暴"]) {
        return [UIImage imageNamed:@"weathericon_condition_06"];
    }
    else if([CommonUtil contains:weather conStr:@"阵雨"]) {
        return [UIImage imageNamed:@"weathericon_condition_07"];
    }
    else if([CommonUtil contains:weather conStr:@"小雨"]) {
        return [UIImage imageNamed:@"weathericon_condition_08"];
    }
    else if([CommonUtil contains:weather conStr:@"大雨"]) {
        return [UIImage imageNamed:@"weathericon_condition_09"];
    }
    else if([CommonUtil contains:weather conStr:@"雷阵雨"]) {
        return [UIImage imageNamed:@"weathericon_condition_10"];
    }
    else if([CommonUtil contains:weather conStr:@"小雪"]) {
        return [UIImage imageNamed:@"weathericon_condition_11"];
    }
    else if([CommonUtil contains:weather conStr:@"大雪"]) {
        return [UIImage imageNamed:@"weathericon_condition_12"];
    }
    else if([CommonUtil contains:weather conStr:@"雨夹雪"]) {
        return [UIImage imageNamed:@"weathericon_condition_13"];
    }
    else {
        return [UIImage imageNamed:@"weathericon_condition_17"];
    }
}
-(NSString *)convertTemp:(NSString *)tem
{
    NSArray  * array= [tem componentsSeparatedByString:@"~"];
    NSString *r=[NSString stringWithFormat:@"%@ ~ %@",array[1],array[0]];
    return r;
}

-(NSString *)getAir:(NSString*)airStr
{
    int Air=[airStr intValue];
    if (Air >= 0 && Air < 50) {
        return @"优";
    } else if (Air >= 50 && Air < 100) {
        return @"良";
    } else if (Air >= 101 && Air < 150) {
        return @"轻度";
    } else if (Air >= 201 && Air < 300) {
        return @"中度";
    } else {
        return @"重度";
    }}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error.description);
}

- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadCity
{
    CityViewController *vc=[[CityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

@end
