//
//  YQRatingPickerLayout.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "YQRatingPickerLayout.h"

static NSInteger const KVisibleCount = 9;
static CGFloat const KScaleMin = 0.7;
//static CGFloat const kMiddleItemWidthPercent = 0.3;
@interface YQRatingPickerLayout ()

@property (assign, nonatomic) NSInteger count;
/**
 占位的cell的个数，只算一边的，其实真实占位数是placeholderCount * 2
 */
//@property (assign, nonatomic) NSInteger placeholderCount;
@property (assign, nonatomic) CGFloat itemWidth;

@end

@implementation YQRatingPickerLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    _itemWidth = floor(width / KVisibleCount);
    self.itemSize = CGSizeMake(_itemWidth, CGRectGetHeight(self.collectionView.frame));
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, floor(width / 2 - _itemWidth/ 2), 0, floor(width / 2 - _itemWidth / 2));
    self.minimumLineSpacing = 0;
//    self.minimumInteritemSpacing = 0;
}

- (CGSize)collectionViewContentSize {
    const CGSize size = CGSizeMake(_count * _itemWidth, CGRectGetHeight(self.collectionView.frame));
    return size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat centerX = CGRectGetMidX(self.collectionView.bounds);
    NSMutableArray *array = [NSMutableArray array];
    [[super layoutAttributesForElementsInRect:rect] enumerateObjectsUsingBlock:^(__kindof UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = obj.center.x - centerX;
        CATransform3D transform = CATransform3DIdentity;
//        if (ABS(distance) > _itemWidth / 2) {
            if (ABS(distance) < CGRectGetMidX(self.collectionView.frame) - 1) {
                CGFloat delta = distance / CGRectGetMidX(self.collectionView.frame);
                transform = CATransform3DRotate(transform, M_PI_2 * distance / CGRectGetMidX(self.collectionView.frame), 0, 1, 0);
//                CGFloat scale = (1 - ABS(delta)) * (1 - KScaleMin) + KScaleMin;
//                transform = CATransform3DScale(transform, scale, scale, 1);
                transform = CATransform3DTranslate(transform, _itemWidth * delta, 0, 0);
                obj.transform3D = transform;
                obj.hidden = NO;
            } else {
                obj.hidden = YES;
            }
//        }
        
        [array addObject:obj];
    }];
    return array;
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
