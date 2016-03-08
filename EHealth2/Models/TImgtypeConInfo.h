/// <summary>
/// author:fishpro
/// time:2015-0 4-03
/// filename:TImgtypeConInfo.h
/// </summary>
#import <Foundation/Foundation.h>
 
	@interface TImgtypeConInfo:NSObject<NSCopying>
     /// <summary>
	/// CON_KY
    /// </summary>		
	@property (strong,nonatomic)  NSString * CON_KY;
       
	/// <summary>
	/// COMP_ID
    /// </summary>		
	@property (strong,nonatomic)  NSString * COMP_ID;
       
	/// <summary>
	/// COMP_NAME
    /// </summary>		
	@property (strong,nonatomic)  NSString * COMP_NAME;
       
	/// <summary>
	/// CASE_TYPE
    /// </summary>		
	@property (strong,nonatomic)  NSString * CASE_TYPE;
       
	/// <summary>
	/// IMAGE_TYPE_CODE
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_TYPE_CODE;
       
	/// <summary>
	/// IMAGE_TYPE_DESC
    /// </summary>		
	@property (strong,nonatomic)  NSString * IMAGE_TYPE_DESC;
       
	/// <summary>
	/// REQUIRED_COUNT
    /// </summary>		
	@property (strong,nonatomic)  NSString * REQUIRED_COUNT;
       
	/// <summary>
	/// RCD_STS
    /// </summary>		
	@property (strong,nonatomic)  NSString * RCD_STS;
       
	/// <summary>
	/// RCD_DTSTMP
    /// </summary>		
	@property (strong,nonatomic)  NSString * RCD_DTSTMP;
       
	/// <summary>
	/// RCD_USERID
    /// </summary>		
	@property (strong,nonatomic)  NSString * RCD_USERID;

@property (strong,nonatomic)  NSMutableArray * IMAGE_LIST;

- (id)copyWithZone:(NSZone *)zone;

		@end
 

