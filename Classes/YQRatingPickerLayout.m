//
//  YQRatingPickerLayout.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "YQRatingPickerLayout.h"

static NSInteger const KVisibleCount = 5;
static CGFloat const kMiddleItemWidthPercent = 0.3;
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
    self.collectionView.contentInset = UIEdgeInsetsMake(0, floor(width / 2 - _itemWidth/ 2), 0, floor(width / 2 - _itemWidth / 2));
    self.minimumLineSpacing = 0;
}

- (CGSize)collectionViewContentSize {
    const CGSize size = CGSizeMake(_count * _itemWidth, CGRectGetHeight(self.collectionView.frame));
    return size;
}

//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    CGFloat centerX = CGRectGetMidX(self.collectionView.bounds);
//    NSMutableArray *array = [NSMutableArray array];
//    NSLog(@"bounds :%@, offset :%lf", NSStringFromCGRect(self.collectionView.bounds), self.collectionView.contentOffset.x);
//        //从0开始，不是从offset开始，所以
//    super layou
//    return array;
//}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}

@end
