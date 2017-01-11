//
//  YQRatingMagnifying.h
//  YQRatingPicker
//
//  Created by Wang on 2017/1/10.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat const kMiddleOffsetAdjust = 5.0f;

@interface YQRatingMagnifying : UIView

@property (assign, nonatomic) CGFloat offsetX;
@property (weak, nonatomic) UIView *drawingView;

@end
