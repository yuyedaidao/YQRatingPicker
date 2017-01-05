//
//  YQRatingPickerCell.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/3.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "YQRatingPickerCell.h"

@interface YQRatingPickerCell ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation YQRatingPickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
        // Initialization code
}


- (void)setValue:(double)value {
    _value = value;
    self.textLabel.text = [@(value) stringValue];
}
@end
