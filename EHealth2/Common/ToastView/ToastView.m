//
//  ToastView.m
//  woplus
//
//  Created by 泽涛 陈 on 14-4-22.
//  Copyright (c) 2014年 泽涛 陈. All rights reserved.
//

#import "ToastView.h"
#import "CommonUtil.h"

@interface ToastView()

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIImageView *bgImageView;

@end
@implementation ToastView
@synthesize tipsLabel;
@synthesize bgImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(([[UIScreen mainScreen] applicationFrame].size.width-280)/2.0,[[UIScreen mainScreen] applicationFrame].size.height+84,280.0f,30.0f)];
        if (bgImageView == nil) {
            bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,280.0f,30.0f)];
        }
        [bgImageView setImage:[UIImage imageNamed:@"toast_background_icon.png"]];
        //[bgImageView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:bgImageView];
        
        if (tipsLabel == nil) {
            tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(1.0f,1.0f,278.0f,28.0f)];
        }
        [tipsLabel setBackgroundColor:[UIColor clearColor]];
        [tipsLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [tipsLabel setNumberOfLines:0];
        [tipsLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [tipsLabel setTextColor:[UIColor whiteColor]]; 
        [self addSubview:tipsLabel];
        
    }
    return self;
}

- (void)toastTipsWithTips:(NSString *)tips
{
    [self setAlpha:0.0];
    CGSize tipsSize = [CommonUtil caluteSize:tips font:[UIFont systemFontOfSize:13] sizewidth:280.0];
    float tipsHeight = tipsSize.height;
    if (tipsHeight < 16 ) {
        [self setFrame:CGRectMake(([[UIScreen mainScreen] applicationFrame].size.width-280)/2.0,[[UIScreen mainScreen] applicationFrame].size.height-80,280.0f,30.0f)];
        [bgImageView setFrame:CGRectMake(0.0f,0.0f,280.0f,30)];
        [tipsLabel setFrame:CGRectMake(1.0f,1.0f,278.0f,28.0f)];
    }else {
        [self setFrame:CGRectMake(([[UIScreen mainScreen] applicationFrame].size.width-280)/2.0,[[UIScreen mainScreen] applicationFrame].size.height-120,280.0f,60)];
        [bgImageView setFrame:CGRectMake(0.0f,0.0f,280.0f,60	)];
        [tipsLabel setFrame:CGRectMake(1.0f,1.0f,278.0f,58)];
    }
    [self.tipsLabel setText:tips];
    [UIView animateWithDuration:0.1
                     animations:^{
                     [self setAlpha:1.0];
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [UIView animateWithDuration:3.0
                                              animations:^{
                                                  [self setAlpha:0.0];
                                              }];
                         }
                     }];
    
}

- (void)toastViewAnimationWithTips:(NSString *)tips
{
    [self.tipsLabel setText:tips];
    [self setAlpha:1.0];
    CGSize tipsSize = [CommonUtil caluteSize:tips font:[UIFont systemFontOfSize:13] sizewidth:280.0];
    float tipsHeight = tipsSize.height;
    if (tipsHeight < 16 ) {
        [self setFrame:CGRectMake(([[UIScreen mainScreen] applicationFrame].size.width-280)/2.0,[[UIScreen mainScreen] applicationFrame].size.height+20,280.0f,30.0f)];
        [bgImageView setFrame:CGRectMake(0.0f,0.0f,280.0f,30.0f)];
        [tipsLabel setFrame:CGRectMake(1.0f,1.0f,278.0f,28.0f)];
    }else {
        [self setFrame:CGRectMake(20.0,[[UIScreen mainScreen] applicationFrame].size.height+20,280.0f,60.0f)];
        [bgImageView setFrame:CGRectMake(0.0f,0.0f,280.0f,60)];
        [tipsLabel setFrame:CGRectMake(1.0f,1.0f,278.0f,58)];
    }
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [self setFrame:CGRectMake(([[UIScreen mainScreen] applicationFrame].size.width-280)/2.0,[[UIScreen mainScreen] applicationFrame].size.height-120,280.0f,30.0f)];
                     } completion:^(BOOL bFinish){
                         if (bFinish) {
                             [UIView animateWithDuration:2.5
                                              animations:^{
                                                  [self setAlpha:0.0];
                                              }];
                         }
                     }];
}

- (void)dealloc
{
    self.tipsLabel = nil;
}

@end
