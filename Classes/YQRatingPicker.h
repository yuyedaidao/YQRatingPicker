//
//  YQRatingPicker.h
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQRatingPicker : UIView

@property(nonatomic) IBInspectable NSInteger value;                        // default is 0. sends UIControlEventValueChanged. clamped to min/max
@property(nonatomic)IBInspectable NSInteger minimumValue;                 // default 0. must be less than maximumValue
@property(nonatomic) IBInspectable NSInteger maximumValue;                 // default 100. must be greater than minimumValue
@property(nonatomic) IBInspectable NSInteger stepValue;

@end

NS_ASSUME_NONNULL_END
