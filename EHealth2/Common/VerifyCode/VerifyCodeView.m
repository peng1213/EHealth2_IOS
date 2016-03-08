//
//  VerifyCodeView.m
//  PWManagement
//
//  Created by 泽涛 陈 on 15/3/31.
//  Copyright (c) 2015年 泽涛 陈. All rights reserved.
//

#import "VerifyCodeView.h"
@interface VerifyCodeView()
@property (nonatomic, strong) NSArray *codeArray;

@end
@implementation VerifyCodeView
@synthesize codeArray;
@synthesize codeStr;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        if (self.codeArray == nil) {
            codeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
        }
        [self getVerifyCodeString];
    }
    return self;
}

- (void)changeVerifyCode
{
    [self getVerifyCodeString];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self getVerifyCodeString];
    [self setNeedsDisplay];
}

- (void)getVerifyCodeString
{
    self.codeStr = @"";
    for (int i = 0; i < 4; i++) {
        int index = arc4random() % ([self.codeArray count] - 1);
        NSString *code = [self.codeArray objectAtIndex:index];
        self.codeStr = [code stringByAppendingString:self.codeStr];
    }
    NSLog(@"self.codeStr=%@",self.codeStr);
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSString *text = [NSString stringWithFormat:@"%@",self.codeStr];
    CGSize cSize = [@"S" sizeWithFont:[UIFont systemFontOfSize:20]];;
    int width = rect.size.width / text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    CGPoint point;
    
    float pX, pY;
    for (int i = 0; i < text.length; i++) {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withFont:[UIFont systemFontOfSize:20]];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    float red,green,blue;
    UIColor *color;
    for(int cout = 0; cout < 10; cout++) {
        
        red = arc4random() % 100 / 100.0;
        green = arc4random() % 100 / 100.0;
        blue = arc4random() % 100 / 100.0;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}

- (void)dealloc
{
    self.codeStr = nil;
    self.codeArray = nil;
}

@end
