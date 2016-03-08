/// <summary>
/// author:fishpro
/// time:2015-0 4-03
/// filename:TReptImgInfo.h
/// </summary>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "AFNetworking.h"

	@interface TReptImgInfo:NSObject
     /// <summary>
	/// IMG_KY
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMG_KY;
       
	/// <summary>
	/// REPT_KY
    /// </summary>		
	@property (strong,nonatomic)  NSString * REPT_KY;
       
	/// <summary>
	/// IMAGE_TYPE_DESC
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_TYPE_DESC;
       
	/// <summary>
	/// IMAGE_TYPE_CODE
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_TYPE_CODE;
       
	/// <summary>
	/// IMAGE_NAME
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_NAME;
       
	/// <summary>
	/// IMAGE_PATH
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_PATH;
       
	/// <summary>
	/// IMAGE_SIZE
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_SIZE;
       
	/// <summary>
	/// UPLOAD_DT
    /// </summary>		
	@property (strong,nonatomic)  NSString * UPLOAD_DT;
       
	/// <summary>
	/// UPLOAD_NAME
    /// </summary>		
	@property (strong,nonatomic)  NSString * UPLOAD_NAME;
       
	/// <summary>
	/// UPLOAD_USER
    /// </summary>		
	@property (strong,atomic)  NSString * UPLOAD_USER;
	@property (strong,atomic)  NSString * IMAGE_URL_SYNC;

    @property (strong,nonatomic) NSData * IMAGE;
    @property (nonatomic) float  PROGRESS;
    @property (nonatomic) long long SEND_BYTES;
    @property (nonatomic) NSIndexPath * indexPath;
    
    @property (nonatomic) BOOL * isUploading;
    @property (nonatomic) BOOL * willUpload;
    @property (nonatomic) BOOL * failed;
    @property (strong,nonatomic) ASIFormDataRequest *request;
		@end
 

