/// <summary>
/// author:fishpro
/// time:2015-0 4-03
/// filename:TImgtypeConInfo.m
/// </summary>
#import "TImgtypeConInfo.h"
 
@implementation TImgtypeConInfo

- (id)copyWithZone:(NSZone *)zone {
    TImgtypeConInfo *imageType=[[[self class]allocWithZone:zone]init];
    imageType.CON_KY=self.CON_KY;
    imageType.IMAGE_TYPE_DESC=self.IMAGE_TYPE_DESC;
    imageType.IMAGE_TYPE_CODE=self.IMAGE_TYPE_CODE;
    imageType.REQUIRED_COUNT=self.REQUIRED_COUNT;
    return imageType;
}

@end
 

