//
//  BankCashierAlterViewController.m
//  EHealth2
//
//  Created by 翟鹏鹏 on 16/3/8.
//  Copyright © 2016年 PrimeTPA. All rights reserved.
//

#import "BankCashierAlterViewController.h"
#import "IncreaseBankViewController.h"
@interface BankCashierAlterViewController ()

@end

@implementation BankCashierAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addBtnClick:(id)sender {
    IncreaseBankViewController *Increase=[[IncreaseBankViewController alloc]init];
    [self presentViewController:Increase animated:YES completion:nil];
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
