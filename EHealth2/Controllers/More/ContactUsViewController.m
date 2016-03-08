//
//  ContactUsViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/12/3.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import "ContactUsViewController.h"
#import "CommonUtil.h"
@interface ContactUsViewController ()

@end

@implementation ContactUsViewController
@synthesize mainTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    UIImageView *back=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    back.image=[UIImage imageNamed:@"common_cell_bg.png"];
    cell.backgroundView=back;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.textColor=[CommonUtil getColor:@"228B22" withAlpha:1];
    if(rowNum==0)
    {
        cell.textLabel.text=@"客服电话";
        cell.detailTextLabel.text=@"0755-83830392";
    }
    else if(rowNum==1)
    {
        cell.textLabel.text=@"客服邮箱";
        cell.detailTextLabel.text=@"szcs@picchealth.com";
    }
    else if(rowNum==2)
    {
        cell.textLabel.text=@"地址";
        cell.detailTextLabel.text=@"深圳市南山区科苑路11号金融科技大厦A座14层CD单元";
    }
    else if(rowNum==3)
    {
        cell.textLabel.text=@"邮编";
        cell.detailTextLabel.text=@"518057";
    }
    //将当前行的显示的label设为已定义数组中的一个。
    //indexPath.row代表当前行
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0)
    {
        UIAlertView* confirm=[[UIAlertView alloc]initWithTitle:@"" message:@"0755-83830392" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [confirm show];
    }
    else if(indexPath.row==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://szcs@picchealth.com"]];
    }
    else if(indexPath.row==2)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"深圳市南山区科苑路11号金融科技大厦A座14层CD单元";
        [self.navigationController.view makeToast:@"地址已经复制！"];
    }
    else if(indexPath.row==3)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"518057";
        [self.navigationController.view makeToast:@"邮编已经复制！"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0755-83830392"]];
    }
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
