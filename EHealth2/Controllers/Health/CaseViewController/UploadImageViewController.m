//
//  UploadImageViewController.m
//  EHealth2
//
//  Created by 刘祯 on 15/10/29.
//  Copyright © 2015年 PrimeTPA. All rights reserved.
//

#import "UploadImageViewController.h"
#import "CommonUtil.h"
#import "QuckClaimsOKViewController.h"
#import "ReportImage.h"
#import "TReptImgInfo.h"
#import "TImgtypeConInfo.h"
#import "MyCaseViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "Pub.h"
#import "SVProgressHUD.h"
#import "UploadImageTableViewCell.h"
#import "QBImagePickerController.h"
#import "ASINetworkQueue.h"
#import "ProgressView.h"
#import "ImageShowViewController.h"
#import "UIView+Toast.h"
@interface UploadImageViewController ()
{
    NSMutableArray * mlist;
    NSMutableArray * imageTypeList;
    UIActionSheet* sheet;
    NSString* _imageKey;
    NSInteger sectionIndex;
    ASINetworkQueue* networkQueue;
    UIProgressView* progress;
    UILabel* progressLabel;
    UIImageView *bottomProgressView;
    int uploadCount;
}

@property UITableView* mainTableView;
@end

@implementation UploadImageViewController
@synthesize operType;
@synthesize currentCaseInfo;
@synthesize mainTableView;
@synthesize imageDics;
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景F0F0F0
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    //设置导航条的View
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    //设置导航View上的返回按钮 定义事件为backToPreViewController
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置导航View上的标题 快速报案
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"影像列表"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];
    
    //设置一个流程导航的View 存放流程 基本信息－>收款信息->上传影像->确认信息
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64, self.view.frame.size.width,95)];
    [tableHeaderView setBackgroundColor:[UIColor whiteColor]];
    //基本信息
    UIImageView *baseInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [baseInfoImageView setImage:[UIImage imageNamed:@"reg_icon1"]];
    [tableHeaderView addSubview:baseInfoImageView];
    UILabel *baseInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 48+16, 64, 20)];
    [baseInfoLable setText:@"基本信息"];
    [baseInfoLable setTextAlignment:NSTextAlignmentCenter];
    [baseInfoLable setFont:[UIFont systemFontOfSize:13]];
    [baseInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [tableHeaderView addSubview:baseInfoLable];
    UIImageView *lineOImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [lineOImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:lineOImageView];
    //收款信息
    UIImageView *accountInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44+(self.view.frame.size.width-40-44*4)/3.0, 20, 44, 44)];
    [accountInfoImageView setImage:[UIImage imageNamed:@"reg_icon2.png"]];
    [tableHeaderView addSubview:accountInfoImageView];
    UILabel *accountInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44+(self.view.frame.size.width-40-44*4)/3.0, 48+16, 64, 20)];
    [accountInfoLable setText:@"收款信息"];
    [accountInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [accountInfoLable setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:accountInfoLable];
    UIImageView *line1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0, 25+16, (self.view.frame.size.width-40-44*4)/3.0,5)];
    [line1ImageView setImage:[UIImage imageNamed:@"claims_green_line_icon.png"]];
    [tableHeaderView addSubview:line1ImageView];
    
    //上传影像
    UIImageView *uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 20, 44, 44)];
    [uploadImageView setImage:[UIImage imageNamed:@"report_icon2_current.png"]];
    [tableHeaderView addSubview:uploadImageView];
    UILabel *uploadInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*2+(self.view.frame.size.width-40-44*4)/3.0*2, 48+16, 64, 20)];
    [uploadInfoLable setText:@"上传影像"];
    [uploadInfoLable setTextColor:[CommonUtil getColor:@"27AE60" withAlpha:1.0]];
    [uploadInfoLable setTextAlignment:NSTextAlignmentCenter];
    [uploadInfoLable setFont:[UIFont systemFontOfSize:13]];
    [tableHeaderView addSubview:uploadInfoLable];
    UIImageView *lineTImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*3+(self.view.frame.size.width-40-44*4)/3.0*2, 25+16, (self.view.frame.size.width-40-44*4)/3.0, 5)];
    [lineTImageView setImage:[UIImage imageNamed:@"claims_gray_line_icon.png"]];
    [tableHeaderView addSubview:lineTImageView];
    
    //确认信息
    UIImageView *comfirmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+44*3+(self.view.frame.size.width-40-44*4)/3.0*3, 20, 44, 44)];
    [comfirmImageView setImage:[UIImage imageNamed:@"report_icon3.png"]];
    [tableHeaderView addSubview:comfirmImageView];
    UILabel *comfirmInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(10+44*3+(self.view.frame.size.width-40-44*4)/3.0*3, 48+16, 64, 20)];
    [comfirmInfoLable setText:@"确认信息"];
    [comfirmInfoLable setTextAlignment:NSTextAlignmentCenter];
    [comfirmInfoLable setFont:[UIFont systemFontOfSize:13]];
    [comfirmInfoLable setTextColor:[UIColor lightGrayColor]];
    [tableHeaderView addSubview:comfirmInfoLable];
    [self.view addSubview:tableHeaderView];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(tableHeaderView.frame.origin.y+tableHeaderView.frame.size.height)-50) style:UITableViewStylePlain];
    
    [mainTableView setRowHeight:70];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    //[mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mainTableView setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    [self.view addSubview:mainTableView];
    
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,(self.view.frame.size.height - 50),self.view.frame.size.width,50)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[UIImage imageNamed:@"mycase_bottom_task_bg.png"]];
    [self.view addSubview:bottomView];
    
    UIButton *quckClaimsButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2.0-55, 7.5, 110, 35)];
    [quckClaimsButton setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [quckClaimsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quckClaimsButton setTitle:@"确认影像" forState:UIControlStateNormal];
    [quckClaimsButton addTarget:self
                         action:@selector(confirmButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:quckClaimsButton];
    
    UIButton *goNext = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2.0-55, 7.5, 110, 35)];
    [goNext setBackgroundImage:[UIImage imageNamed:@"mycase_report_button_icon.png"] forState:UIControlStateNormal];
    [goNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goNext setTitle:@"下一步" forState:UIControlStateNormal];
    [goNext addTarget:self
               action:@selector(goNext)
     forControlEvents:UIControlEventTouchUpInside];
    [goNext setHidden:YES];
    [bottomView addSubview:goNext];
    
    
    bottomProgressView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,(self.view.frame.size.height ),self.view.frame.size.width,50)];
    [bottomProgressView setUserInteractionEnabled:YES];
    [bottomProgressView setImage:[UIImage imageNamed:@"mycase_bottom_task_bg.png"]];
    [bottomProgressView setHidden:YES];
    [self.view addSubview:bottomProgressView];
    progressLabel= [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 20, 200, 30)];
    progressLabel.textAlignment=UITextAlignmentCenter;
    progressLabel.textColor=[CommonUtil getColor:@"4d9aed" withAlpha:1];
    progressLabel.font=[UIFont systemFontOfSize:12];
    [bottomProgressView addSubview:progressLabel];
    
    progress=[[UIProgressView alloc]initWithFrame:CGRectMake(20, 10, self.view.frame.size.width-40, 1)];
    [bottomProgressView addSubview:progress];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerUploadCompletion:)
                                                 name:@"RegisterUploadNotification"
                                               object:nil];
    if([operType isEqualToString:@"read"])
    {
        [quckClaimsButton setHidden:YES];
        [goNext setHidden:NO];
    }
    else
    {
        [quckClaimsButton setHidden:NO];
        [goNext setHidden:YES];
    }
    [self initData];
    sheet = [[UIActionSheet alloc] initWithTitle:@"添加方式"
                                        delegate:self
                               cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"拍照", @"从相册选择", nil];
    
    networkQueue = [[ASINetworkQueue alloc]init];
    networkQueue.delegate=self;
    networkQueue.requestDidFinishSelector = @selector(queueRequestFinished:);
    networkQueue.requestDidFailSelector=@selector(queueRequestFailed:);
    networkQueue.queueDidFinishSelector=@selector(queueFinished:);
    networkQueue.requestDidStartSelector=@selector(queueRequestStarted:);
    networkQueue.uploadProgressDelegate=self;
}

-(void)registerUploadCompletion:(NSNotification*)notification
{
    NSArray *indexArray=[NSArray arrayWithObject:notification.object];
    [mainTableView beginUpdates];
    [mainTableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [mainTableView endUpdates];
    //添加上传影像
}

-(void)goNext
{
    QuckClaimsOKViewController *quckView =[[QuckClaimsOKViewController alloc] init];
    [quckView setCurrentCaseInfo:currentCaseInfo];
    [self.navigationController pushViewController:quckView animated:YES];
    
}


-(void)confirmButtonClick
{
    BOOL isValid=YES;
    for (id type in imageDics) {
        ReportImage *reptImage=(ReportImage*)type;
        
        TImgtypeConInfo *typeInfo=reptImage.typeInfo;
        NSMutableArray*array= reptImage.images;
        if([typeInfo.REQUIRED_COUNT isEqualToString:@"1"]&&array.count==0)
        {
            [self.navigationController.view makeToast:[NSString stringWithFormat: @"该报案未上传%@，请上传后再进行下一步！",typeInfo.IMAGE_TYPE_DESC]];
            isValid=NO;
            break;
        }
        else if([typeInfo.REQUIRED_COUNT isEqualToString:@"1"]&&array.count>1)
        {
            [self.navigationController.view makeToast:[NSString stringWithFormat: @"%@只能上传一张，请删除多余影像后后再进行下一步！",typeInfo.IMAGE_TYPE_DESC]];
            isValid=NO;
            break;
        }
        else if([typeInfo.REQUIRED_COUNT isEqualToString:@">=1"]&&array.count==0)
        {
            [self.navigationController.view makeToast:[NSString stringWithFormat: @"该报案未上传%@，请上传后再进行下一步！",typeInfo.IMAGE_TYPE_DESC]];
            isValid=NO;
            break;
        }
        for (TReptImgInfo* img in reptImage.images) {
            if(img.failed)
            {
                [self.navigationController.view makeToast:[NSString stringWithFormat: @"%@中有上传失败的图像，请删除或重新上传！",typeInfo.IMAGE_TYPE_DESC]];
                isValid=NO;
                break;
            }
        }
        if(!isValid)
            break;
    }
    
    if(isValid)
    {
        if([operType isEqualToString:@"read"])
        {
            NSDictionary *dataDict = [NSDictionary dictionaryWithObject:@"ok"
                                                                 forKey:@"popitemname"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"RegisterMyCaseNotification"
             object:nil
             userInfo:dataDict];
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MyCaseViewController class]]) {
                    [self.navigationController popToViewController:controller
                                                          animated:YES];
                }
            }
        }
        else
        {
            QuckClaimsOKViewController *quckView =[[QuckClaimsOKViewController alloc] init];
            [quckView setCurrentCaseInfo:currentCaseInfo];
            [self.navigationController pushViewController:quckView animated:YES];
        }
    }
    
}


- (void)backToPreViewController
{
    if([networkQueue requestsCount]>0)
        [self.navigationController.view makeToast:@"正在上传，请勿退出！"];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

/********************加载数据**************************/
-(void)initData
{
    [self initImageType];
}

-(void)initImageType
{
    AppDelegate *delegate=   (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url=[[NSURL alloc] initWithString:api_image_typelist];
    ASIFormDataRequest* request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:delegate.COMP_ID forKey:@"COMP_ID"];
    [request setPostValue:currentCaseInfo.CASE_TYPE forKey:@"CASE_TYPE"];
    [request setPostValue: delegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    request.tag=10000;
    [request setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request startAsynchronous];
    [SVProgressHUD show];
    
}

-(void)initImages
{
    NSURL *url=[[NSURL alloc] initWithString:api_case_image_list];
    ASIFormDataRequest* request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%d",currentCaseInfo.REPT_KY] forKey:@"REPT_KY"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [request setPostValue: appDelegate.token forKey: @"token"];
    [request setRequestMethod:@"POST"];
    [request buildPostBody];
    [request setDelegate:self];
    request.tag=10001;
    [request setTimeOutSeconds:60];
    //设定同步还是异步方式
    [request startAsynchronous];
    
}

#pragma mark ********************Table相关**************************
//
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return imageDics.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((ReportImage*)imageDics[section]).images.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    TImgtypeConInfo* type= ((ReportImage*)imageDics[section]).typeInfo;
    UIImageView *titleBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    [titleBg setImage:[UIImage imageNamed:@"mycase_topview_bg"]];
    [titleBg setContentMode:UIViewContentModeScaleToFill];
    [sectionView addSubview:titleBg];
    
    UILabel* title=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
    title.text=type.IMAGE_TYPE_DESC;
    [sectionView addSubview:title];
    
    UILabel* comment=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 100, 20)];
    comment.font=[UIFont systemFontOfSize:12];
    comment.textColor=[UIColor lightGrayColor];
    if([type.REQUIRED_COUNT isEqualToString:@"1"])
        comment.text=@"只能上传一张";
    else if([type.REQUIRED_COUNT isEqualToString:@"*"])
        comment.text=@"可上传任意张";
    else if([type.REQUIRED_COUNT isEqualToString:@">=1"])
        comment.text=@"至少上传一张";
    [sectionView addSubview:comment];
    
    if(![operType isEqualToString:@"read"])
    {
        UIButton* addBtn=[[UIButton alloc]initWithFrame:CGRectMake(320-70, 15, 60, 30)];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"common_blue_bg"] forState:UIControlStateNormal];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        addBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        addBtn.tag=section;
        [addBtn addTarget:self action:@selector(addImg:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:addBtn];
    }
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


//获取cell的定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSUInteger rowNum = [indexPath row];
    //注意这里自定义了Cell
    UploadImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UploadImageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        @autoreleasepool {
            cell = [[UploadImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell setCellValue:((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row]];
    cell.viewController=self;
    cell.indexPath=indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了删除");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TReptImgInfo*img= ((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row];
        if(img.IMG_KY!=nil&&![img.IMG_KY isEqualToString:@""])
        {
            [self deleteImage:indexPath];
        }
        else
        {
            [self removeImage:indexPath];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![operType isEqualToString:@"read"])
    {
        
        TReptImgInfo*img= ((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row];
        if(!img.isUploading)
            return YES;
        else
            return NO;
    }
    else
        return NO;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TReptImgInfo * model=((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row];
    ImageShowViewController *cellView=[[ImageShowViewController alloc]init];
    if(model.IMAGE_URL_SYNC!=nil&&![model.IMAGE_URL_SYNC isEqualToString:@""])
        cellView.imageURL=[[NSURL alloc]initWithString:model.IMAGE_URL_SYNC];
    else if(model.IMAGE_PATH!=nil&&![model.IMAGE_PATH isEqualToString:@""])
        cellView.imageURL=[[NSURL alloc]initWithString:model.IMAGE_PATH];
    else if(model.IMAGE!=nil)
        cellView.image=[UIImage imageWithData:model.IMAGE];
    [self.navigationController pushViewController:cellView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ********************添加照片**************************

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //拍照
        [self startCamera];
    }
    else if(buttonIndex==1)
    {
        //从相册选择
        [self selectFile];
    }
}



-(void)addImg:(UIButton *)sender
{
    sectionIndex=sender.tag;
    [sheet showInView:self.view];
}


-(void)startCamera
{
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
    camera.delegate = self;
    //检查摄像头是否支持摄像机模式
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        NSLog(@"Camera not exist");
        return;
    }
    
    
    [self presentModalViewController:camera animated:YES];
    
}


-(void)selectFile
{
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.filterType=QBImagePickerControllerFilterTypePhotos;
    imagePickerController.allowsMultipleSelection = YES;
    if([((ReportImage*)imageDics[sectionIndex]).typeInfo.REQUIRED_COUNT isEqualToString:@"1"])
        imagePickerController.maximumNumberOfSelection=1;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

-(void)addUploadRequest:(NSArray *)assets
{
    int i=0;
    for (ALAsset* asset in assets) {
        UIImage* image=nil;
        NSData *imageData =nil;
        @autoreleasepool {
            image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage
                                      scale:asset.defaultRepresentation.scale
                                orientation:(UIImageOrientation)asset.defaultRepresentation.orientation];
            imageData= UIImageJPEGRepresentation(image, 0.1);
        }
        TReptImgInfo *img=[[TReptImgInfo alloc]init];
        img.UPLOAD_NAME=asset.defaultRepresentation.filename;
        img.IMAGE=imageData;
        img.IMAGE_TYPE_CODE=((ReportImage*)imageDics[sectionIndex]).typeInfo.IMAGE_TYPE_CODE;
        img.IMAGE_TYPE_DESC=((ReportImage*)imageDics[sectionIndex]).typeInfo.IMAGE_TYPE_DESC;
        NSInteger row=((ReportImage*)imageDics[sectionIndex]).images.count;
        img.indexPath=[NSIndexPath indexPathForRow:row inSection:sectionIndex];
        img.isUploading=YES;
        img.request=[self uploadImage:img];
        [((ReportImage*)imageDics[sectionIndex]).images addObject:img];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            [indexPaths addObject:img.indexPath];
            [mainTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [SVProgressHUD showProgress:(float)i/(float)(assets.count) status:@"正在添加上传任务"];
        });
        i++;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets {
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
    [NSThread detachNewThreadSelector:@selector(addUploadRequest:) toTarget:self withObject:assets];
    
    
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fileName = [[NSString alloc] init];
    
    if ([info objectForKey:UIImagePickerControllerReferenceURL]) {
        fileName = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
        //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
        fileName = [self getFileName:fileName];
    }
    else
    {
        fileName = [self timeStampAsString];
    }
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    
    [myDefault setValue:fileName forKey:@"fileName"];
    //保存到相册
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[image CGImage]
                              orientation:(ALAssetOrientation)[image imageOrientation]
                          completionBlock:nil];
    
    TReptImgInfo *img=[[TReptImgInfo alloc]init];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    img.IMAGE=imageData;
    img.IMAGE_TYPE_CODE=((ReportImage*)imageDics[sectionIndex]).typeInfo.IMAGE_TYPE_CODE;
    img.IMAGE_TYPE_DESC=((ReportImage*)imageDics[sectionIndex]).typeInfo.IMAGE_TYPE_DESC;
    NSInteger row=((ReportImage*)imageDics[sectionIndex]).images.count;
    img.indexPath=[NSIndexPath indexPathForRow:row inSection:sectionIndex];
    img.UPLOAD_NAME=fileName;
    img.isUploading=YES;
    img.request=[self uploadImage:img];
    [((ReportImage*)imageDics[sectionIndex]).images addObject:img];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [indexPaths addObject:img.indexPath];
    [mainTableView beginUpdates];
    [mainTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [mainTableView endUpdates];
    //    [[NSNotificationCenter defaultCenter]
    //     postNotificationName:@"RegisterUploadNotification"
    //     object:indexPath];
}

- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        UIGraphicsBeginImageContext(asize);
        
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}


-(NSString *)timeStampAsString
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HHmmssSSSn"];
    NSString *locationString = [df stringFromDate:nowDate];
    return [locationString stringByAppendingFormat:@".png"];
}

-(NSString *)getFileName:(NSString *)fileName
{
    NSArray *temp = [fileName componentsSeparatedByString:@"&ext="];
    NSString *suffix = [temp lastObject];
    
    temp = [[temp objectAtIndex:0] componentsSeparatedByString:@"?id="];
    
    NSString *name = [temp lastObject];
    
    name = [name stringByAppendingFormat:@".%@",suffix];
    return name;
}

#pragma mark ********************上传照片**************************
-(ASIFormDataRequest*)uploadImage:(TReptImgInfo*)imageInfo
{
    int len=imageInfo.IMAGE.length;
    if (len>100) {
        NSURL *url =[ NSURL URLWithString : api_image_add];
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: @"IOS" forKey: @"PLATFORM"];
        [request setPostValue: [NSString stringWithFormat:@"%d",len] forKey: @"IMAGE_SIZE"];
        [request setPostValue: [NSString stringWithFormat:@"%d",currentCaseInfo.REPT_KY]  forKey: @"REPT_KY"];
        [request setPostValue:imageInfo.IMAGE_TYPE_DESC forKey: @"IMAGE_TYPE_DESC"];
        [request setPostValue:imageInfo.IMAGE_TYPE_CODE forKey: @"IMAGE_TYPE_CODE"];
        [request setPostValue: imageInfo.UPLOAD_NAME forKey: @"UPLOAD_NAME"];
        [request setData:imageInfo.IMAGE withFileName:imageInfo.UPLOAD_NAME andContentType:@"image/jpg" forKey: @"PHOTO" ];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [request setPostValue: appDelegate.User.USUS_ID forKey: @"UPLOAD_USER"];
        [request setPostValue: appDelegate.token forKey: @"token"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        request.tag=40000;
        request.userInfo=[NSDictionary dictionaryWithObject:imageInfo.indexPath forKey:@"index"];
        request.showAccurateProgress=YES;
        [networkQueue addOperation:request];
        [networkQueue go];
        [request setTimeOutSeconds:600.0f];
        return  request;
    }
    return  nil;
}

-(void)deleteImage:(NSIndexPath*)index
{
    TReptImgInfo*img= ((ReportImage*)(imageDics[index.section])).images[index.row];
    if(img.IMG_KY!=nil&&![img.IMG_KY isEqualToString:@""])
    {
        NSURL *url=[[NSURL alloc] initWithString:api_case_image_delete];
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setPostValue: img.IMG_KY forKey:@"IMG_KY"];
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [request setPostValue: appDelegate.token forKey: @"token"];
        [request setRequestMethod:@"POST"];
        [request buildPostBody];
        [request setDelegate:self];
        request.tag=30000;
        request.userInfo=[NSDictionary dictionaryWithObject:index forKey:@"index"];
        [request setTimeOutSeconds:60];
        //设定同步还是异步方式
        [request startAsynchronous];
        [SVProgressHUD show];
    }
    
}

-(void)removeImage:(NSIndexPath*)index
{
    [((ReportImage*)(imageDics[index.section])).images removeObjectAtIndex:index.row];
    [mainTableView beginUpdates];
    [mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
    [mainTableView endUpdates];
    
}

#pragma mark ********************网络协议**************************

-(void)queueRequestStarted:(ASIHTTPRequest *)request{
    if(bottomProgressView.hidden)
    {
        bottomProgressView.hidden=NO;
        CGRect frame= bottomProgressView.frame;
        frame.origin.y=frame.origin.y-50;
        [UIView animateWithDuration:0.3
                         animations:^{
                             bottomProgressView.frame = frame;
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    NSLog(@"started");
    uploadCount++;
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"请求失败！");
    [self.navigationController.view makeToast:@"网络异常"];
}

//ASIHttp成功的处理方hi
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"login的请求返回的json结果%@", request.responseString);
    //获取返回结果 先判断返回result值
    TResult * model=[[TResult alloc]init];
    model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
    NSLog(@"mlist count:%@",request.responseString);
    //如果返回成功显示
    if(request.tag==30000)
    {
        
        NSIndexPath*index= [request.userInfo objectForKey:@"index"];
        TResult *result=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        if(result.ResultCode==0)
        {
            [((ReportImage*)(imageDics[index.section])).images removeObjectAtIndex:index.row];
            [mainTableView beginUpdates];
            [mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
            [mainTableView endUpdates];
        }
        else
        {
            NSLog(@"%@",result.ResultDesc);
            [self.navigationController.view makeToast:@"删除失败！"];
        }
        [SVProgressHUD dismiss];
        
        
    }
    else
    {
        if (model.ResultCode==0)
        {
            if(request.tag==10000)
            {
                imageTypeList = [[JsonTool defaultTool] getTImgtypeConInfoList:request.responseString withKey:@"model"];
                [self initImages];
            }
            else if(request.tag==10001)
            {
                imageDics=[[NSMutableArray alloc]init];
                mlist = [[JsonTool defaultTool] getTReptImgInfoList:request.responseString withKey:@"model"];
                for (id type in imageTypeList) {
                    TImgtypeConInfo *typeInfo=(TImgtypeConInfo*)type;
                    NSMutableArray *array=[[NSMutableArray alloc]init];
                    for (int i=0; i<mlist.count; i++) {
                        if([[(TReptImgInfo*)mlist[i] IMAGE_TYPE_DESC]isEqualToString:typeInfo.IMAGE_TYPE_DESC])
                        {
                            [array addObject:(TReptImgInfo*)mlist[i]];
                        }
                    }
                    ReportImage *reportImage=[[ReportImage alloc]init];
                    reportImage.typeInfo=typeInfo;
                    reportImage.images=array;
                    [imageDics addObject:reportImage];
                }
                
                [self.mainTableView reloadData];
                [SVProgressHUD dismiss];
            }
        }
        else
        {
            [self.navigationController.view makeToast:model.ResultDesc];
        }
    }
}


-(void)setProgress:(float)newProgress
{
    progressLabel.text=[NSString stringWithFormat:@"已上传 %0.f%%",newProgress*100];
    [progress setProgress:newProgress];
}
-(void)queueRequestFinished:(ASIHTTPRequest *)request{
    if(request.tag==40000)
    {
        NSLog(@"login的请求返回的json结果%@", request.responseString);
        //获取返回结果 先判断返回result值
        TResult * model=[[TResult alloc]init];
        model=[[JsonTool defaultTool] getTResultEntity:request.responseString];
        if(model.ResultCode==0)
        {
            NSIndexPath*indexPath= [request.userInfo objectForKey:@"index"];
            TReptImgInfo* img=[[JsonTool defaultTool]getTReptImgInfo:request.responseString withKey:@"model"];
            img.isUploading=NO;
            img.failed=NO;
            img.IMAGE=((TReptImgInfo*)(((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row])).IMAGE;
            ((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row]=img;
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            [indexPaths addObject:[request.userInfo objectForKey:@"index"]];
            [mainTableView beginUpdates];
            [mainTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [mainTableView endUpdates];
        }
    }
    
}

-(void)queueRequestFailed:(ASIHTTPRequest *)request{
    NSLog(request.responseString);
    NSIndexPath*indexPath= [request.userInfo objectForKey:@"index"];
    ((TReptImgInfo*)(((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row])).failed=YES;
    ((TReptImgInfo*)(((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row])).isUploading=NO;
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [indexPaths addObject:((TReptImgInfo*)(((ReportImage*)(imageDics[indexPath.section])).images[indexPath.row])).indexPath];
    [mainTableView beginUpdates];
    [mainTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [mainTableView endUpdates];
}

-(void)queueFinished:(ASINetworkQueue*)queue
{
    if (networkQueue.requestsCount == 0) {
        [networkQueue cancelAllOperations];
    }
    
    CGRect frame= bottomProgressView.frame;
    frame.origin.y=frame.origin.y+50;
    [UIView animateWithDuration:0.3
                     animations:^{
                         bottomProgressView.frame = frame;
                     } completion:^(BOOL finished) {
                         bottomProgressView.hidden=YES;
                     }];
    uploadCount=0;
    NSLog(@"queue finish");
}

@end
