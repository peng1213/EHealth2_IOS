//
//  DrugSearchViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/12/31.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import "DrugSearchViewController.h"

@interface DrugSearchViewController ()

@end

@implementation DrugSearchViewController

- (void)viewDidLoad {
    self.TITLE=@"药品查询";
    self.URL=@"http://consult.yaoshi360.com/drug/search?s=peihe";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
