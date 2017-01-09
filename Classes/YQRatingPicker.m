//
//  YQRatingPicker.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "YQRatingPicker.h"
#import "YQRatingPickerLayout.h"
#import "YQRatingPickerCell.h"

static CGFloat const kMiddleLineOffsetAdjust = 5.0f;

@interface YQRatingPicker () <UICollectionViewDelegate, UICollectionViewDataSource, YQRatingPickerLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) YQRatingPickerLayout *layout;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) NSArray<UIView *> *lines;

@end

@implementation YQRatingPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.currentIndex = -1;
    self.layout = ({
        YQRatingPickerLayout *layout = [[YQRatingPickerLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.delegate = self;
        layout;
    });
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YQRatingPickerCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YQRatingPickerCell class])];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    /*
     let gradientLayer = CAGradientLayer()
     gradientLayer.colors = [UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor, UIColor.blackColor().CGColor]
     gradientLayer.frame = maskView.bounds;
     gradientLayer.locations = [0, 0.2, 1]
     */
    self.gradientLayer = ({
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor, (__bridge id)[[UIColor grayColor] colorWithAlphaComponent:1].CGColor,(__bridge id)[[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        gradientLayer.locations = @[@(0), @(0.5), @(1)];
        self.layer.mask = gradientLayer;
        gradientLayer;
    });
    
    NSMutableArray *lines = @[].mutableCopy;
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        [lines addObject:line];
    }
    self.lines = lines;

}

#pragma mark - override
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.layer.bounds;
    NSInteger v = self.value;
    NSInteger m = self.minimumValue;
    NSInteger s = self.stepValue;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger targetIndex = (v - m) / s;
        [self.collectionView setContentOffset:CGPointMake(targetIndex * self.layout.itemWidth - self.collectionView.contentInset.left, 0)];
    });
}

#pragma mark - delete yqratingpicker

- (void)yq_didPrepareLayout:(YQRatingPickerLayout *)layout {
    CGFloat offset = layout.itemWidth / 2 + kMiddleLineOffsetAdjust;
    [self.lines enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(floor(CGRectGetWidth(self.frame) / 2) + (idx % 2 ? -offset : offset) , 0, 1, CGRectGetHeight(self.frame));
    }];
}

#pragma mark - delete collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSAssert(!((self.maximumValue - self.minimumValue) % self.stepValue), @"您设定的stepValue没法整除");
    return (self.maximumValue - self.minimumValue) / self.stepValue + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQRatingPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YQRatingPickerCell class]) forIndexPath:indexPath];
    cell.value = self.stepValue * indexPath.row + self.minimumValue;
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger count = round((*targetContentOffset).x / self.layout.itemWidth);
    (*targetContentOffset).x = count * self.layout.itemWidth;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setIndexWithScrollView:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setIndexWithScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self setIndexWithScrollView:scrollView];
    }
}

- (void)setIndexWithScrollView:(UIScrollView *)scrollView {
    self.currentIndex = (scrollView.contentOffset.x + scrollView.contentInset.left + self.layout.itemSize.width / 2) / self.layout.itemSize.width;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        YQRatingPickerCell *cell = (YQRatingPickerCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]];
        if (cell) {
            _value = cell.value;
        } else {
            _value = self.minimumValue;
        }
    }
}


@end
