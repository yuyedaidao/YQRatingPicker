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
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1 / 500.0;
    self.redView.layer.transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.ratingPicker.value = 5;
//    });
//    self.ratingPicker.value = 7;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         UIGraphicsBeginImageContext(self.view.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();//获取的是当前view的图形上下文
        CGContextTranslateCTM(context,1*(self.view.frame.size.width*0.5),1*(self.view.frame.size.height*0.5));//重新设置坐标系原点
        CGContextScaleCTM(context, 1.2, 1.2);
        CGContextTranslateCTM(context, -100, -100);
        [self.ratingPicker.layer renderInContext:context];
        UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
        self.imgView.image = image;
        UIGraphicsEndImageContext();
    });
    
}

- (IBAction)showValueAction:(id)sender {
    NSLog(@"value: %ld",self.ratingPicker.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
