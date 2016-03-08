//
//  CityViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/8/28.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import "CityViewController.h"
#import "City.h"
#import "AppDelegate.h"
#import "FMDB.h"
#import "CommonUtil.h"
#import "ConfigTool.h"

@interface CityViewController ()<UISearchBarDelegate>
{
    UITableView *table;
    UISearchBar *searchBar;
    NSMutableArray *list;
    NSMutableArray *list1;
    NSMutableArray *list2;
    int locationFlag;
}
@end

@implementation CityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    locationFlag=1;
    UIImage *image= [UIImage imageNamed:@"app_bg02.png"];
    self.view.layer.contents = (id) image.CGImage;
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-60, 40)];
    searchBar.backgroundColor=[UIColor clearColor];
    searchBar.delegate=self;
    searchBar.returnKeyType=UIReturnKeySearch;
    for (UIView *view in searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    [self.view addSubview:searchBar];
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 20, 60, 40)];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    table.delegate=self;
    table.dataSource=self;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [table setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:table];

    
    City *location=[[City alloc]init];
    
    location.cityName=[[ConfigTool Instance]getWeatherCity];
    location.cityCode=[[ConfigTool Instance]getWeatherCode];
    
    list1=[[NSMutableArray alloc]initWithObjects:location, nil];
    list=[[NSMutableArray alloc]initWithObjects:location, nil];
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    locationFlag=0;
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"数据库打开失败！");
    }

    NSString *sql=[NSString stringWithFormat:@"SELECT city,county,code  FROM china_city_code where city='%@' or province='%@' order by code",[searchBar text],[searchBar text]];
    FMResultSet *rs = [db executeQuery:sql];
    list=[[NSMutableArray alloc]init];
    while ([rs next]) {
        NSString *code = [rs stringForColumn:@"code"];
        NSString *county = [rs stringForColumn:@"county"];
        City *ct=[[City alloc]init];
        ct.cityName=county;
        ct.cityCode=code;
        [list addObject:ct];
    }
    
    [table reloadData];
    NSLog(@"searchBarTextDidEndEditing");
}


- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [CommonUtil getColor:@"49494a" withAlpha:0.5];
    NSUInteger row = [indexPath row];
    cell.backgroundColor=[UIColor clearColor];
    if([list count]>0)
    {
    City *city=  (City*) [list objectAtIndex:row];
    cell.textLabel.text = city.cityName;
    cell.textLabel.textColor=[UIColor whiteColor];
    if(locationFlag>0)
    {
        [cell.imageView setHidden:NO];
        [cell.imageView setContentMode:UIViewContentModeCenter];
        cell.imageView.image=[UIImage imageNamed:@"location.png"];
    }
    else
    {
        [cell.imageView setImage:nil];
    }
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [list count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<list.count)
    {
        City*ct=(City*)[list objectAtIndex:indexPath.row];
        [[ConfigTool Instance]saveWeaherCity:ct.cityName andCode:ct.cityCode];
        [self backToPreViewController];
    }
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
