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

@interface YQRatingPicker () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) YQRatingPickerLayout *layout;
@property (assign, nonatomic) NSInteger currentIndex;

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
        layout;
    });
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YQRatingPickerCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YQRatingPickerCell class])];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return floor((self.maximumValue - self.minimumValue) / self.stepValue);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQRatingPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YQRatingPickerCell class]) forIndexPath:indexPath];
    cell.value = self.stepValue * indexPath.row + self.minimumValue;
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat count = floor((*targetContentOffset).x / self.layout.itemSize.width);
    CGFloat distanceLeft = count * self.layout.itemSize.width - (*targetContentOffset).x;
    CGFloat distanceRight = (count + 1) * self.layout.itemSize.width - (*targetContentOffset).x;
    *targetContentOffset = CGPointMake((*targetContentOffset).x + (ABS(distanceLeft) > ABS(distanceRight) ? distanceRight : distanceLeft), 0);
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
