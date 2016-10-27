//
//  ViewController.m
//  日期选择器
//
//  Created by zhouzhongmao on 16/10/24.
//  Copyright © 2016年 zhouzhongmao. All rights reserved.
//

#import "ViewController.h"
#import "ZMTimePickerView.h"

@interface ViewController ()
@property(nonatomic,strong) UILabel *timeLa;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self createDateLabel];
     ZMTimePickerView *pc = [[ZMTimePickerView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 173) withBackTimeStr:^(NSString *time) {
         _timeLa.text = time;
         [_timeLa sizeToFit];
     }];
    [self.view addSubview:pc];
}
- (void)createDateLabel {
    _timeLa = [UILabel new];
    _timeLa.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 44);
    _timeLa.textColor = [UIColor blackColor];
    [self.view addSubview:_timeLa];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
