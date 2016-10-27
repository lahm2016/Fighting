//
//  ZMTimePickerView.h
//  日期选择器
//
//  Created by zhouzhongmao on 16/10/24.
//  Copyright © 2016年 zhouzhongmao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockBack)(NSString *time);
@interface ZMTimePickerView : UIView
- (instancetype)initWithFrame:(CGRect)frame withBackTimeStr:(void(^)(NSString *time))block;

@end
