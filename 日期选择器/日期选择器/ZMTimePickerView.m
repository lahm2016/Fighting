//
//  ZMTimePickerView.m
//  日期选择器
//
//  Created by zhouzhongmao on 16/10/24.
//  Copyright © 2016年 zhouzhongmao. All rights reserved.
//

#import "ZMTimePickerView.h"
@interface ZMTimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic, copy) NSMutableArray *years;
@property (nonatomic, copy) NSArray *year;

@property (nonatomic, copy) NSArray *months;
@property (nonatomic, copy) NSArray *month;

@property (nonatomic, copy) NSMutableArray *days;
@property (nonatomic, copy) NSArray *day;

@property (nonatomic, copy) NSString *dataY;
@property (nonatomic, copy) NSString *dataM;
@property (nonatomic, copy) NSString *dataD;
@property (nonatomic ,copy) BlockBack timeBack;

@end


@implementation ZMTimePickerView
- (instancetype)initWithFrame:(CGRect)frame withBackTimeStr:(void (^)(NSString *))block{
    self = [super  initWithFrame:frame];
    if (self) {
        _timeBack = block;
        [self loadData];
        [self createPickerView];
        [self selectRow];
        if (_timeBack) {
            self.timeBack([NSString stringWithFormat:@"%@-%@-%@",self.dataY,self.dataM,self.dataD]);
        }
    
    }
    return self;
}
//- (void)sss {
//
//    if (_timeBack) {
//        self.timeBack([NSString stringWithFormat:@"%@-%@-%@",self.dataY,self.dataM,self.dataD]);
//    }
//
//}
#pragma mark 加载数据
-(void)loadData{
    //需要展示的数据以数组的形式保存
    NSMutableArray *mArr1 = [[NSMutableArray  alloc]init];
    for (int i = 1900; i < 2100; i++) {
        NSString *num = [NSString stringWithFormat:@"%d",i];
        [mArr1 addObject:num];
    }
    self.years = mArr1;
    NSMutableArray *mArr2 = [[NSMutableArray  alloc]init];
    for (int i = 1; i < 13; i++) {
        NSString *num = @"";
        if (i < 10) {
            num = [NSString stringWithFormat:@"0%d",i];
        }else {
            num = [NSString stringWithFormat:@"%d",i];
        }
        
        [mArr2 addObject:num];
    }
    self.year = @[@"年"];
    self.months = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    self.month = @[@"月"];
    self.dataY = [[self getNowTime] substringWithRange:NSMakeRange(0, 4)];
    self.dataM = [[self getNowTime] substringWithRange:NSMakeRange(5, 2)];
    self.dataD = [[self getNowTime] substringWithRange:NSMakeRange(8, 2)];
    NSLog(@"%@ %@ %@",self.dataY,self.dataM,self.dataD);
    NSInteger num = [self theDaysOfTheTime:[self getNowTime]];
    NSMutableArray *mArr3 = [[NSMutableArray  alloc]init];
    for (int i = 1; i < num +1; i++) {
        NSString *numStr = @"";
        if (i < 10) {
            numStr = [NSString stringWithFormat:@"0%d",i];
        }else {
            numStr = [NSString stringWithFormat:@"%d",i];
        }
        [mArr3 addObject:numStr];
    }
    self.days = mArr3;
     self.day = [NSArray arrayWithObjects:@"日", nil];
}
//当年月改变时重新获取天数数组
- (void)getDaysSourceWithNum:(NSInteger)num {
//    NSLog(@"%@ ",self.dataD);
    NSMutableArray *mArr3 = [[NSMutableArray  alloc]init];
    for (int i = 1; i < num +1; i++) {
        NSString *numStr = @"";
        if (i < 10) {
            numStr = [NSString stringWithFormat:@"0%d",i];
        }else {
            numStr = [NSString stringWithFormat:@"%d",i];
        }
        [mArr3 addObject:numStr];
    }
    self.days = mArr3;
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:num inComponent:4 animated:NO];
    self.dataD = self.days[num-1];
    [self nssting];
    
}
- (void)selectRow {
    
    NSInteger y = 0,m = 0, d = 0;
    for (NSInteger i = 0; i < self.years.count; i++) {
        if ([self.years[i] isEqualToString:self.dataY]) {
            y = i;
        }
    }
    for (NSInteger i = 0; i < self.months.count; i++) {
        if ([self.months[i] isEqualToString:self.dataM]) {
            m = i;
        }
    }
    for (NSInteger i = 0; i < self.days.count; i++) {
        if ([self.days[i] isEqualToString:self.dataD]) {
            d = i;
        }
    }
    _pickerView.showsSelectionIndicator = YES;
    [_pickerView selectRow:y inComponent:0 animated:NO];
    [_pickerView selectRow:m inComponent:2 animated:NO];
    [_pickerView selectRow:d inComponent:4 animated:NO];


}
- (void)createPickerView {
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:_pickerView];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;


}
#pragma mark UIPickerView DataSource Method 数据源方法

//  一共有多少列
//返回列数（必须实现）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

// 第compo列一共有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)compo {
    if (compo == 1||compo == 3||compo == 5) {
        return 1;
    }else if (compo == 0){
        return self.years.count;
    }else if (compo == 2){
        return self.months.count;
    }else {
        return self.days.count;
    }
    
    
}
//每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 32;
}
//指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    // 宽度
    return -10+self.frame.size.width/6;
}

#pragma mark UIPickerView Delegate Method 代理方法

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *la = [UILabel new];
    if (component == 0) {
        la.text = self.years[row];
    }else if (component == 1) {
        la.text = self.year[row];
    }else if (component == 2) {
        la.text = self.months[row];
    }else if (component == 3) {
        la.text = self.month[row];
    }else if (component == 4) {
        la.text = self.days[row];
    }else  {
        la.text = self.day[row];
    }
    la.textAlignment = NSTextAlignmentCenter;
    return la;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component ==  0) {
        self.dataY = self.years[row];
        [pickerView selectedRowInComponent:0];
        [self getNewDaysArray:[NSString stringWithFormat:@"%@-%@-%@",self.dataY,self.dataM,@"28"]];

    }else if (component ==  2){
        self.dataM = self.months[row];
        [self getNewDaysArray:[NSString stringWithFormat:@"%@-%@-%@",self.dataY,self.dataM,@"28"]];
    }else if (component ==  4){
        self.dataD = self.days[row];
        [self nssting];
    }
    
}
- (void)nssting {
    NSInteger row=[_pickerView selectedRowInComponent:4];
    NSString *time = [NSString stringWithFormat:@"%@-%@-%@",self.dataY,self.dataM,self.days[row]];
    if (_timeBack) {
        self.timeBack(time);
    }
}

- (void)getNewDaysArray:(NSString*)str {
    NSMutableString *timeStr = [NSMutableString stringWithString:[self getNowTime]];
    [timeStr replaceCharactersInRange:NSMakeRange(0, 10) withString:str];
    NSString *mStr = [NSString stringWithFormat:@"%@",timeStr];
    [self getDaysSourceWithNum:[self theDaysOfTheTime:mStr]];

}
//获取现在时间的字符串
- (NSString*)getNowTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
            //hh是否显示12小时制与电脑中时间设置有关
    format.dateFormat =@"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [format stringFromDate:date];
//    NSLog(@"the date = %@",dateStr);
    return dateStr;

}
/**
 *  获取某年某月有多少天
 */
- (NSInteger)theDaysOfTheTime:(NSString*)dateStr {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 年-月-日 时:分:秒
    NSDate * date = [formatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
