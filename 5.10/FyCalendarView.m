

#import "FyCalendarView.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface FyCalendarView ()
{
    PickerDateViewController * pickerView;
    UIButton * button;

}
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *daysArray;
@end

@implementation FyCalendarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDate];
        [self setupNextAndLastMonthView];
    }
    return self;
}

- (void)setupDate {
    self.daysArray = [NSMutableArray arrayWithCapacity:42];
    for (int i = 0; i < 42; i++) {
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        [_daysArray addObject:button];
        [button addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupNextAndLastMonthView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UISwipeGestureRecognizer* swipeRight=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        swipeRight.numberOfTouchesRequired=1;
        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        UISwipeGestureRecognizer* swipeLeft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        swipeLeft.numberOfTouchesRequired=1;
        swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer* swipeDown=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        swipeDown.numberOfTouchesRequired=1;
        swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeRight];
        [self addGestureRecognizer:swipeLeft];
        [self addGestureRecognizer:swipeDown];
        swipeRight.delaysTouchesBegan=YES;
        swipeLeft.delaysTouchesBegan=YES;
        swipeDown.delaysTouchesBegan=YES;
        for(UIGestureRecognizer* ges in self.gestureRecognizers){
            if([ges isKindOfClass:[UIPanGestureRecognizer class]]){
                [ges requireGestureRecognizerToFail:swipeRight];
                [ges requireGestureRecognizerToFail:swipeLeft];
                [ges requireGestureRecognizerToFail:swipeDown];
            }
        }
    
        [self setNeedsLayout];
        [self layoutIfNeeded];
    });
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setImage:[UIImage imageNamed:@"brn_left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(nextAndLastMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    leftBtn.tag = 1;
    leftBtn.frame = CGRectMake(10, 10, 20, 20);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
    rightBtn.tag = 2;
    [rightBtn addTarget:self action:@selector(nextAndLastMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake(self.frame.size.width - 30, 10, 20, 20);
}

- (void)nextAndLastMonth:(UIButton *)button {
    if (button.tag == 1) {
        if (self.lastMonthBlock) {
            self.lastMonthBlock();
        }
    } else {
        if (self.nextMonthBlock) {
            self.nextMonthBlock();
        }
    }
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.width / 7 ;
    
    
    
    
    
    // 1.year month
    self.headlabel = [[UILabel alloc] init];
    self.headlabel.text= [NSString stringWithFormat:@"%li年%li月",(long)[self year:date],(long)[self month:date]];
    NSLog(@"%@", self.headlabel.text);
    self.headlabel.font     = [UIFont systemFontOfSize:18];
    self.headlabel.frame           = CGRectMake(0, 64, self.frame.size.width, itemH );
    self.headlabel.textAlignment   = NSTextAlignmentCenter;
    self.headlabel.textColor = self.headColor;
    [self addSubview: self.headlabel];
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.backgroundColor = [UIColor clearColor];
    headBtn.frame = self.headlabel.frame;
    [self addSubview:headBtn];
    [headBtn addTarget:self action:@selector(chooseMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.headlabel];
    
    
    
    //小三角
    if (__kScreenHeight__ == 568) {
        UIImageView *xiaobank = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.3, 81, 10, 12)];
        [self addSubview:xiaobank];
        [xiaobank setImage:[UIImage imageNamed:@"black_jiao"]];
        
        
        
        UIImageView *xiaobank1 = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.66, 81, 10, 12)];
        [self addSubview:xiaobank1];
        [xiaobank1 setImage:[UIImage imageNamed:@"black_xiao"]];

    }else if (__kScreenHeight__ == 667)
        
    {
        UIImageView *xiaobank = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.32, 85, 10, 12)];
        [self addSubview:xiaobank];
        [xiaobank setImage:[UIImage imageNamed:@"black_jiao"]];
        
        
        
        UIImageView *xiaobank1 = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.65, 85, 10, 12)];
        [self addSubview:xiaobank1];
        [xiaobank1 setImage:[UIImage imageNamed:@"black_xiao"]];

    }else{
        UIImageView *xiaobank = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.32, 87, 10, 12)];
        [self addSubview:xiaobank];
        [xiaobank setImage:[UIImage imageNamed:@"black_jiao"]];
        
        
        
        UIImageView *xiaobank1 = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth__*0.65, 87, 10, 12)];
        [self addSubview:xiaobank1];
        [xiaobank1 setImage:[UIImage imageNamed:@"black_xiao"]];

    }
    
    
    
    
    
    //头视图灰色背景
    if (__kScreenHeight__ == 568) {
        UIView *shangxian = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)-0.5, self.frame.size.width, 0.5)];
        [self addSubview:shangxian];
        shangxian.backgroundColor = [UIColor lightGrayColor];
        
        UIView *shangxian1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+itemH - 15+0.7, self.frame.size.width, 0.5)];
        [self addSubview:shangxian1];
        shangxian1.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *shshbei = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headlabel.frame), self.frame.size.width, itemH -15)];
        shshbei.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [self addSubview:shshbei];
    }else if(__kScreenHeight__ == 667){
        UIView *shangxian = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)-0.5, self.frame.size.width, 0.5)];
        [self addSubview:shangxian];
        shangxian.backgroundColor = [UIColor lightGrayColor];
        
        UIView *shangxian1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+itemH - 25+0.7, self.frame.size.width, 0.5)];
        [self addSubview:shangxian1];
        shangxian1.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *shshbei = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headlabel.frame), self.frame.size.width, itemH - 25 )];
        shshbei.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [self addSubview:shshbei];
        
    }else{
        UIView *shangxian = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)-0.5, self.frame.size.width, 0.5)];
        [self addSubview:shangxian];
        shangxian.backgroundColor = [UIColor lightGrayColor];
        
        UIView *shangxian1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+itemH - 30+0.7, self.frame.size.width, 0.5)];
        [self addSubview:shangxian1];
        shangxian1.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *shshbei = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headlabel.frame), self.frame.size.width, itemH - 30)];
        shshbei.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [self addSubview:shshbei];
    }
   
    
    //灰色线
    if(__kScreenHeight__ == 568)
    {
        UIView *huisedixian = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+84.5 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian];
        huisedixian.backgroundColor = [UIColor lightGrayColor];
        
        UIView *huisedixian1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+130 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian1];
        huisedixian1.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian2 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+175.5 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian2];
        huisedixian2.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian3 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+221 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian3];
        huisedixian3.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian4 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+267, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian4];
        huisedixian4.backgroundColor = [UIColor lightGrayColor];
        
        UIView *huisedixian5 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+313, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian5];
        huisedixian5.backgroundColor = [UIColor lightGrayColor];

        
    }else if (__kScreenHeight__ == 667)
    {
        UIView *huisedixian = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+90 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian];
        huisedixian.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+143.5, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian1];
        huisedixian1.backgroundColor = [UIColor lightGrayColor];

        
        UIView *huisedixian2 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+197, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian2];
        huisedixian2.backgroundColor = [UIColor lightGrayColor];

        
        UIView *huisedixian3 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+250.5, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian3];
        huisedixian3.backgroundColor = [UIColor lightGrayColor];

        
        UIView *huisedixian4 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+304 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian4];
        huisedixian4.backgroundColor = [UIColor lightGrayColor];

        UIView *huisedixian5 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+357.5, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian5];
        huisedixian5.backgroundColor = [UIColor lightGrayColor];
      
        
        
    }else{
        
        UIView *huisedixian = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+101.5 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian];
        huisedixian.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian1 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+160, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian1];
        huisedixian1.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian2 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+218.5, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian2];
        huisedixian2.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian3 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+277.5, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian3];
        huisedixian3.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *huisedixian4 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+337 , __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian4];
        huisedixian4.backgroundColor = [UIColor lightGrayColor];
        
        UIView *huisedixian5 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headlabel.frame)+397.5, __kScreenWidth__, 0.5)];
        [self addSubview:huisedixian5];
        huisedixian5.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    
    
    // 2.weekday
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    self.weekBg = [[UIView alloc] init];
//       self.weekBg.backgroundColor = [UIColor orangeColor];
    if (__kScreenHeight__ == 568) {
         self.weekBg.frame = CGRectMake(0, CGRectGetMaxY(self.headlabel.frame), self.frame.size.width, itemH+10);
    }else{
         self.weekBg.frame = CGRectMake(0, CGRectGetMaxY(self.headlabel.frame), self.frame.size.width, itemH);
    }
   
    [self addSubview:self.weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(itemW * i, 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = self.weekDaysColor;
        [self.weekBg addSubview:week];
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(self.weekBg.frame)-20;
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x+8, y+8, itemW-8, itemH-8);
        dayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = 5.0f;
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [self totaldaysInMonth:[self lastMonth:date]];
        NSInteger daysInThisMonth = [self totaldaysInMonth:date];
        NSInteger firstWeekday    = [self firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [dayButton setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
      
        if (self.frame.size.height >667) {
            dayButton.titleLabel.font = [UIFont systemFontOfSize:21];
        }else{
            dayButton.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        
        
        // this month
        if ([self month:date] == [self month:[NSDate date]]) {
            
            NSInteger todayIndex = [self day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                //                [self setStyle_BeforeToday:dayButton];
            }else if(i ==  todayIndex){
                [self setStyle_Today:dayButton];
            }
            
        }
    }
}

#pragma mark - chooseMonth
- (void)chooseMonth:(UIButton *)button {
    //下期版本
}


#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    self.selectBtn.selected = NO;
    [self.selectBtn setBackgroundColor:[UIColor whiteColor]];
    dayBtn.selected = YES;
    self.selectBtn = dayBtn;
    dayBtn.layer.cornerRadius = dayBtn.frame.size.height / 2;
    dayBtn.layer.masksToBounds = YES;
    [dayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [dayBtn setBackgroundColor:self.dateColor];
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
}

#pragma mark - date button style

- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    if (self.isShowOnlyMonthDays) {
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    } else {
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
}

//- (void)setStyle_BeforeToday:(UIButton *)btn
//{
//        btn.enabled = NO;
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    for (NSString *str in self.allDaysArr) {
//        if ([str isEqualToString:btn.titleLabel.text]) {
//            UIView *domView = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.size.width / 2 - 3, btn.frame.size.height - 6, 6, 6)];
//            domView.backgroundColor = [UIColor orangeColor];
//            domView.layer.cornerRadius = 3;
//            domView.layer.masksToBounds = YES;
//            [btn addSubview:domView];
//        }
//    }
//    for (NSString *str in self.allDaysArr) {
//        if ([str isEqualToString:btn.titleLabel.text]) {
//            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
//            stateView.layer.cornerRadius = btn.frame.size.height / 2;
//            stateView.layer.masksToBounds = YES;
//            stateView.backgroundColor = [UIColor blueColor];
//            stateView.alpha = 0.5;
//            [btn addSubview:stateView];
//        }
//    }
//}

- (void)setStyle_Today:(UIButton *)btn
{
    btn.layer.cornerRadius = btn.frame.size.height / 2;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    [btn setBackgroundColor:[UIColor redColor]];
    
    
            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
            stateView.layer.cornerRadius = btn.frame.size.height / 2;
            stateView.layer.masksToBounds = YES;
            stateView.backgroundColor = self.allDaysColor;
            stateView.image = [UIImage imageNamed:@"calendar1_circle.png"];
            stateView.alpha = 0.2;
            
            [btn addSubview:stateView];
    


    
    
    
}

- (void)setStyle_AfterToday:(UIButton *)btn
{;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    for (NSString *str in self.allDaysArr) {
        if ([str isEqualToString:btn.titleLabel.text]) {
            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
            stateView.layer.cornerRadius = btn.frame.size.height / 2;
            stateView.layer.masksToBounds = YES;
            stateView.backgroundColor = self.allDaysColor;
            stateView.image = self.allDaysImage;
            stateView.alpha = 1;

            [btn addSubview:stateView];
        }
    }
    for (NSString *str in self.partDaysArr) {
        if ([str isEqualToString:btn.titleLabel.text]) {
            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
            stateView.layer.cornerRadius = btn.frame.size.height / 2;
            stateView.layer.masksToBounds = YES;
            stateView.backgroundColor = self.partDaysColor;
            stateView.image = self.partDaysImage;
            stateView.alpha = 0.5;
            [btn addSubview:stateView];
        }
    }
}

#pragma mark - Lazy loading
- (NSArray *)allDaysArr {
    if (!_allDaysArr) {
        _allDaysArr = [NSArray array];
    }
    return _allDaysArr;
}
//全天可用的北京
-(UIImage *)allDaysImage
{
    if (!_allDaysImage) {
        _allDaysImage = [UIImage imageNamed:@"calen_des.png"];
    }
    return _allDaysImage;
}
- (NSArray *)partDaysArr {
    if (!_partDaysArr) {
        _partDaysArr = [NSArray array];
    }
    return _partDaysArr;
}
//日期颜色
- (UIColor *)headColor {
    if (!_headColor) {
        _headColor = [UIColor blackColor];
    }
    return _headColor;
}
//选中日期的颜色
- (UIColor *)dateColor {
    if (!_dateColor) {
        _dateColor = [UIColor redColor];
    }
    return _dateColor;
}
//全天可用颜色
- (UIColor *)allDaysColor {
    if (!_allDaysColor) {
        _allDaysColor = [UIColor clearColor];
    }
    return _allDaysColor;
}

- (UIColor *)partDaysColor {
    if (!_partDaysColor) {
        _partDaysColor = [UIColor clearColor];
    }
    return _partDaysColor;
}
//周几颜色（日。。。六）
- (UIColor *)weekDaysColor {
    if (!_weekDaysColor) {
        _weekDaysColor = [UIColor blackColor];
    }
    return _weekDaysColor;
}

//一个月第一个周末
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *component = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [component setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:component];
    NSUInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekDay - 1;
}

//总天数
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

#pragma mark - month +/-

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


#pragma mark - date get: day-month-year

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
-(void)swipeAction:(UISwipeGestureRecognizer*)swipe// 手势横扫
{
     if(swipe.direction == UISwipeGestureRecognizerDirectionRight){
         if (self.lastMonthBlock) {
             self.lastMonthBlock();
         }
     }
    
    if(swipe.direction ==  UISwipeGestureRecognizerDirectionLeft){
        
        if (self.nextMonthBlock) {
            self.nextMonthBlock();
        }

    }
}

@end
