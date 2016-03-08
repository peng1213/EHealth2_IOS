//
//  BaseViewController.h
//  EHealth2
//
//  Created by 刘祯 on 15/8/4.
//  Copyright (c) 2015年 PrimeTPA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView *navigaterView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *nodataView;
@property (nonatomic, strong) UIView *errorView;
-(void)loadContentView;
-(void)loadNodataView;
-(void)loadErrorView:(NSString*)errorMsg;
@end
