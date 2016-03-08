//
//  ZTPickerView.h
//  PWManagement
//
//  Created by 泽涛 陈 on 15/4/2.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZTPickerView;
@protocol ZTPickerViewDelegate <NSObject>
@optional
- (void)pickerBarDoneClick:(ZTPickerView *)pickerView
              resultString:(NSString *)resultString;
@end
@interface ZTPickerView : UIView

@property (nonatomic, assign) id<ZTPickerViewDelegate> delegate;

/**
 *  通过plistName添加一个pickView
 *
 *  @param plistName
 *  @param bHaveNavControler
 *
 *  @return
 */
- (instancetype)initPickviewWithPlistName:(NSString *)curPlistName
                      isHaveNavControler:(BOOL)bHaveNavControler;

/**
 *  通过plistName添加一个pickView
 *
 *  @param array
 *  @param bHaveNavControler
 *
 *  @return
 */
- (instancetype)initPickviewWithArray:(NSArray *)array
                   isHaveNavControler:(BOOL)bHaveNavControler;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param defaulDate
 *  @param datePickerMode
 *  @param bHaveNavControler
 *
 *  @return
 */
- (instancetype)initDatePickWithDate:(NSDate *)curDate
                      datePickerMode:(UIDatePickerMode)datePickerMode
                  isHaveNavControler:(BOOL)bHaveNavControler;


- (void)setPickerViewColor:(UIColor *)color;

- (void)setTintColor:(UIColor *)tintColor;

- (void)setToolBarTintColor:(UIColor *)barTintColor;

- (void)show;
- (void)dismiss;


@end
