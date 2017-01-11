//
//  YQRatingMagnifying.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/10.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "YQRatingMagnifying.h"
#define YQ_RATE_SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define YQ_RATE_SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)
//static CGFloat const kMagnifyingScale = 1.2;

@implementation YQRatingMagnifying

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();//获取的是当前view的图形上下文
//    CGContextTranslateCTM(context,CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));//重新设置坐标系原点
//    CGContextTranslateCTM(context, -_offsetX + kMiddleOffsetAdjust, 0);
//    [self.drawingView.layer renderInContext:context];
//    CGContextTranslateCTM(context, _offsetX - kMiddleOffsetAdjust , 0);
    CGContextBeginPath(context);
    [[UIColor grayColor] set];
    CGContextSetLineWidth(context, YQ_RATE_SINGLE_LINE_WIDTH);
    CGContextMoveToPoint(context, YQ_RATE_SINGLE_LINE_ADJUST_OFFSET, 0);
    CGContextAddLineToPoint(context,YQ_RATE_SINGLE_LINE_ADJUST_OFFSET, CGRectGetHeight(rect));
    CGContextMoveToPoint(context, CGRectGetWidth(rect) - YQ_RATE_SINGLE_LINE_ADJUST_OFFSET, 0);
    CGContextAddLineToPoint(context,CGRectGetWidth(rect) - YQ_RATE_SINGLE_LINE_ADJUST_OFFSET, CGRectGetHeight(rect));
    CGContextStrokePath(context);
}


@end
