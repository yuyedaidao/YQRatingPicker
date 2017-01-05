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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showValueAction:(id)sender {
    NSLog(@"value: %lf",self.ratingPicker.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
