//
//  ZTPickerView.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/2.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#define ZTTOOLBARHEIGHT 40

#import "ZTPickerView.h"
#import "CommonUtil.h"


@interface ZTPickerView()
@property(nonatomic, strong) NSString *plistName;
@property(nonatomic, strong) NSArray  *plistArray;
@property(nonatomic, assign) BOOL isLevelArray;
@property(nonatomic, assign) BOOL isLevelString;
@property(nonatomic, assign) BOOL isLevelDic;
@property(nonatomic, strong) NSDictionary *levelTwoDic;
@property(nonatomic, strong) UIToolbar *toolbar;
@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, assign) NSDate *defaulDate;
@property(nonatomic, assign) BOOL isHaveNavControler;
@property(nonatomic, assign) NSInteger pickeviewHeight;
@property(nonatomic, strong) NSString *resultString;
@property(nonatomic, strong) NSMutableArray *componentArray;
@property(nonatomic, strong) NSMutableArray *dicKeyArray;
@property(nonatomic, copy)   NSMutableArray *state;
@property(nonatomic, copy)   NSMutableArray *city;


@end
@implementation ZTPickerView

@synthesize plistName;
@synthesize plistArray;
@synthesize isLevelArray;
@synthesize isLevelString;
@synthesize isLevelDic;
@synthesize levelTwoDic;
@synthesize toolbar;
@synthesize pickerView;
@synthesize datePicker;
@synthesize defaulDate;
@synthesize isHaveNavControler;
@synthesize pickeviewHeight;
@synthesize resultString;
@synthesize componentArray;
@synthesize dicKeyArray;
@synthesize state;
@synthesize city;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.plistArray == nil) {
            plistArray = [[NSArray alloc] init];
        }
        
        if (self.componentArray == nil) {
            componentArray = [[NSMutableArray alloc] init];
        }
        
        if (self.dicKeyArray == nil) {
            dicKeyArray = [[NSMutableArray alloc] init];
        }
        
        [self setUpToolBar];
        
        
    }
    return self;
}

-(void)setArrayClass:(NSArray *)array
{
    for (id levelTwo in array) {
        if ([levelTwo isKindOfClass:[NSArray class]]) {
            self.isLevelArray = YES;
            self.isLevelString = NO;
            self.isLevelDic = NO;
        }else if ([levelTwo isKindOfClass:[NSString class]]){
            
            self.isLevelString = YES;
            self.isLevelArray = NO;
            self.isLevelDic = NO;
            
        }else if ([levelTwo isKindOfClass:[NSDictionary class]]) {
            self.isLevelDic = YES;
            self.isLevelString = NO;
            self.isLevelArray = NO;
            self.levelTwoDic = levelTwo;
            [self.dicKeyArray addObject:[self.levelTwoDic allKeys]];
        }
    }
}

- (NSArray *)getPlistArrayByplistName:(NSString *)curPlistName
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:curPlistName ofType:@"plist"];
    NSArray * array = [[NSArray alloc] initWithContentsOfFile:path];
    [self setArrayClass:array];
    return array;
}

- (instancetype)initPickviewWithPlistName:(NSString *)curPlistName isHaveNavControler:(BOOL)bHaveNavControler
{
    
    self = [super init];
    if (self) {
        self.plistName = curPlistName;
        self.plistArray = [self getPlistArrayByplistName:curPlistName];
        [self setUpPickView];
        [self setFrameWith:bHaveNavControler];
        
    }
    return self;
}

- (instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)bHaveNavControler
{
    self = [super init];
    if (self) {
        self.plistArray = array;
        [self setArrayClass:array];
        [self setUpPickView];
        [self setFrameWith:bHaveNavControler];
    }
    return self;
}

- (instancetype)initDatePickWithDate:(NSDate *)curDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)bHaveNavControler
{
    self = [super init];
    if (self) {
        self.defaulDate = curDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:bHaveNavControler];
    }
    return self;
}

- (void)setFrameWith:(BOOL)bHaveNavControler
{
    CGFloat toolViewX = 0;
    CGFloat toolViewH = self.pickeviewHeight+ZTTOOLBARHEIGHT;
    CGFloat toolViewY ;
    if (bHaveNavControler) {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH - 50;
    }else {
        toolViewY = [UIScreen mainScreen].bounds.size.height - toolViewH;
    }
    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
}
- (void)setUpPickView
{
    UIPickerView *pickView = [[UIPickerView alloc] init];
    pickView.backgroundColor = [UIColor whiteColor];
    self.pickerView = pickView;
    pickView.frame = CGRectMake(0, ZTTOOLBARHEIGHT, pickView.frame.size.width, pickView.frame.size.height);
    self.pickeviewHeight=pickView.frame.size.height;
    [self addSubview:pickView];
}

- (void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode
{
    UIDatePicker *curDatePicker=[[UIDatePicker alloc] init];
    curDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    curDatePicker.datePickerMode = datePickerMode;
    curDatePicker.backgroundColor = [UIColor whiteColor];
    if (self.defaulDate) {
        [curDatePicker setDate:self.defaulDate];
    }
    self.datePicker = curDatePicker;
    datePicker.frame = CGRectMake(0, ZTTOOLBARHEIGHT, datePicker.frame.size.width, datePicker.frame.size.height);
    self.pickeviewHeight = datePicker.frame.size.height;
    [self addSubview:datePicker];
}


- (void)setPickerViewColor:(UIColor *)color
{
    [self.pickerView setBackgroundColor:color];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [self.toolbar setTintColor:tintColor];
}

- (void)setToolBarTintColor:(UIColor *)barTintColor
{
    [self.toolbar setBarTintColor:barTintColor];
}

- (void)setUpToolBar
{
    if (self.toolbar == nil) {
        
        toolbar = [self setToolbarStyle];
    }
    [self setToolbarWithPickViewFrame];
    [self addSubview:self.toolbar];
}

- (UIToolbar *)setToolbarStyle
{
    UIToolbar *curToolbar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                 target:self
                                                                                 action:nil];
    
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"  取消"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(dismiss)];
    
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:self
                                                                                 action:nil];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定  "
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(doneClick)];
    
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
                                                                               action:nil];

    curToolbar.items = @[leftSpace,lefttem,centerSpace,right,rightSpace];
    return curToolbar;
}

- (void)setToolbarWithPickViewFrame
{
    if (self.toolbar) {
        toolbar.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, ZTTOOLBARHEIGHT);
    }
    
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)doneClick
{
    if (self.pickerView) {
        
        if (self.resultString) {
            
        }else{
            if (self.isLevelString) {
                self.resultString=[NSString stringWithFormat:@"%@",self.plistArray[0]];
            }else if (self.isLevelArray){
                self.resultString = @"";
                for (int i = 0; i < self.plistArray.count;i++) {
                    self.resultString=[NSString stringWithFormat:@"%@%@",self.resultString,self.plistArray[i][0]];
                }
            }else if (self.isLevelDic){
                
                if (self.state == nil) {
                    self.state = self.dicKeyArray[0][0];
                    NSDictionary *dicValueDic=self.plistArray[0];
                    self.city = [dicValueDic allValues][0][0];
                }
                if (self.city == nil){
                    NSInteger cIndex = [self.pickerView selectedRowInComponent:0];
                    NSDictionary *dicValueDic=self.plistArray[cIndex];
                    self.city = [dicValueDic allValues][0][0];
                    
                }
                self.resultString = [NSString stringWithFormat:@"%@%@",self.state,self.city];
            }
        }
    }else if (self.datePicker) {
        
        self.resultString = [NSString stringWithFormat:@"%@",[CommonUtil getDateStringByFormateString:@"yyyy-MM-dd" date:self.datePicker.date]];
    }
    if ([self.delegate respondsToSelector:@selector(pickerBarDoneClick:resultString:)]) {
        [self.delegate pickerBarDoneClick:self resultString:self.resultString];
    }
    [self dismiss];
}

@end
