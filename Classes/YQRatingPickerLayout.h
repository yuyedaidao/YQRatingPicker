//
//  YQRatingPickerLayout.h
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YQRatingPickerLayout;

@protocol YQRatingPickerLayoutDelegate <NSObject>

- (void)yq_didPrepareLayout:(YQRatingPickerLayout *)layout;

@end

@interface YQRatingPickerLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) CGFloat itemWidth;
@property (weak, nonatomic) id<YQRatingPickerLayoutDelegate> delegate;
@end
