//
//  QuckClaimsUpladTableViewCell.h
//  citic
//
//  Created by echoliu on 15-4-15.
//  Copyright (c) 2015年 primetpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReptImgInfo.h"
#import "GMGridView.h"
#import "TImgtypeConInfo.h"
#import "TReptImgInfo.h"
#import "QuckClaimsUploadViewController.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
@interface QuckClaimsUpladTableViewCell : UITableViewCell<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewTransformationDelegate, GMGridViewActionDelegate>
{
    QuckClaimsUploadViewController *viewController;
    NSInteger deleteIndex;
    UIActionSheet *sheet;
    BOOL isCamera;
    NSMutableArray *uploadList;
}

@property (atomic, strong) NSMutableArray* images;
@property (atomic, strong)    TImgtypeConInfo *type;
@property (nonatomic, strong) GMGridView* imagesView;
@property (nonatomic, strong) GMGridView* collectionView;
@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* comment;
@property (nonatomic, strong) UILabel* nodata;
@property (nonatomic, strong) UIButton* addBtn;
@property (nonatomic, strong) UIButton* editBtn;
@property (assign, nonatomic) id<GMGridViewActionDelegate> gmDelegate;
-(void)setCellValue:(NSMutableArray*) model type:(TImgtypeConInfo*)typeInfo viewController:(QuckClaimsUploadViewController*)vc;
@end
