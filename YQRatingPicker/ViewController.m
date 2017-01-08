//
//  ViewController.m
//  YQRatingPicker
//
//  Created by Wang on 2017/1/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "YQRatingPicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet YQRatingPicker *ratingPicker;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1 / 500.0;
    self.redView.layer.transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
}

- (IBAction)showValueAction:(id)sender {
    NSLog(@"value: %ld",self.ratingPicker.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
