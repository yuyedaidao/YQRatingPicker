//
//  YQRatingPickerLayout.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "YQRatingPickerLayout.h"

static NSInteger const KVisibleCount = 9;
static CGFloat const kAngle = M_PI_2;

@interface YQRatingPickerLayout ()

@end

@implementation YQRatingPickerLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    _itemWidth = width / KVisibleCount;
    self.itemSize = CGSizeMake(_itemWidth, CGRectGetHeight(self.collectionView.frame));
    CGFloat insetLR = (width - _itemWidth) / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, insetLR, 0, insetLR);
    self.minimumLineSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(yq_didPrepareLayout:)]) {
        [self.delegate yq_didPrepareLayout:self];
    }
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
        CGFloat radius = CGRectGetMidX(self.collectionView.frame);
        if (ABS(distance) < radius - 1) {
            CGFloat delta = distance / radius;
            transform = CATransform3DRotate(transform, kAngle * distance / CGRectGetMidX(self.collectionView.frame), 0, 1, 0);
            CGFloat translate = radius * cos(kAngle * (1 - delta)) - distance;
            transform = CATransform3DTranslate(transform, translate, 0, 0);
            obj.transform3D = transform;
            obj.hidden = NO;
        } else {
            obj.hidden = YES;
        }
        
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
