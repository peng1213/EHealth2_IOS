//
//  PicAddViewController.m
//  EhealthClient
//
//  Created by jiaojunkang on 14-4-26.
//  Copyright (c) 2014年 primetpa. All rights reserved.
//

#import "PicAddViewController.h"
#import "CommonUtil.h"
#import "Pub.h"
@interface PicAddViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_images;//联系人模型
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}

- (void)backToPreViewController;
@end

@implementation PicAddViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	targetURL = [[NSURL alloc] init];
	isCamera = FALSE;
    
    // 设置滚动自适应
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view setBackgroundColor:[CommonUtil getColor:@"F0F0F0" withAlpha:1.0]];
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.view.frame.size.width, 64.0f)];
    [navigationBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_head_bar_bg.png"]]];
    [self.view addSubview:navigationBarView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27.0, 30.0, 30.0)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"common_navigationbar_back_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backToPreViewController)
         forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:backButton];
    //设置标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f,self.view.frame.size.width,64.0f)];
    [titleLable setText:@"影像上传"];
    [titleLable setFont:[UIFont systemFontOfSize:21]];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [navigationBarView addSubview:titleLable];

    UIButton *responsibilityButton = [[UIButton alloc] initWithFrame:CGRectMake(5.0f, 69.0f, 120, 49)];
    [responsibilityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [responsibilityButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [responsibilityButton setTitle:@"拍照" forState:UIControlStateNormal];
    [responsibilityButton addTarget:self
                             action:@selector(startCamera)
                   forControlEvents:UIControlEventTouchUpInside];
    [responsibilityButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:responsibilityButton];

    
    UIButton *xiangceButton = [[UIButton alloc] initWithFrame:CGRectMake(155.0f, 69.0f, 150, 49)];
    [xiangceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xiangceButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [xiangceButton setTitle:@"从相册中选择" forState:UIControlStateNormal];
    [xiangceButton addTarget:self
                             action:@selector(selectFile)
                   forControlEvents:UIControlEventTouchUpInside];
    [xiangceButton setBackgroundImage:[UIImage imageNamed:@"login_ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:xiangceButton];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 118, self.view.frame.size.width, self.view.frame.size.height-118) style:UITableViewStylePlain];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}
#pragma mark - 数据源方法
#pragma mark 返回分组数


#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _images.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个对象，记录了组和行信息
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.imageView.image=(UIImage*)_images[indexPath.row];
    return cell;
}


#pragma mark - 代理方法
#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath=indexPath;
}


//02.返回事件
- (void)backToPreViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_images addObject:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    [_tableView reloadData];
}



-(void)startCamera
{
	UIImagePickerController *camera = [[UIImagePickerController alloc] init];
	camera.delegate = self;
	camera.allowsEditing = YES;
	isCamera = TRUE;
	
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
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;
	
	picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
        //混合类型 photo + movie
		picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
	[self presentModalViewController:picker animated:YES];
 
}


@end
