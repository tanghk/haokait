

#import "ViewController.h"
#import "FyCalendarView.h"
#import "rilitable.h"
#import "AFNetworking.h"
#import "UICommons.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()
{ MBProgressHUD *HUD;
    NSArray *monayhuan;
    NSString *datatimes;
    UILabel *This_month;
    UILabel *huan;
    NSMutableArray *Mar;
    UILabel *_titleLabel;
    PickerDateViewController * pickerView;
    UIButton * button;
    UIView *delciview;
    NSString* string;
}
@property (strong, nonatomic) FyCalendarView *calendarView;
@property (nonatomic, strong) NSDate *date;
@property (strong, nonatomic)  rilitable *table;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    [self request12];
    self.data = [NSMutableArray array];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navigationgView = [[UIView alloc]init];
    navigationgView.frame = CGRectMake(0, 0, __kScreenWidth__, 64);
    navigationgView.backgroundColor = kColorNavi;
    [self.view addSubview:navigationgView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 68/2, __kScreenWidth__, 32/2);
    _titleLabel.text = @"还款日历";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    // titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [navigationgView addSubview:_titleLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]init];
    UIImage *chehui = [UIImage imageNamed:@"redPacketReturn"];
    [backBtn setBackgroundImage:chehui forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:@selector(aqlb:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [navigationgView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navigationgView.mas_left);
        make.top.equalTo(navigationgView.mas_top).offset(20);
        make.width.mas_equalTo(133/2);
        make.height.mas_equalTo(44);
        
    }];
    
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth__, 0.5)];
    xian.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:xian];
    
    
    
    
    
    _table = [[rilitable alloc]init];
    _table.frame = CGRectMake(0, 64.5,self.view.frame.size.width , self.view.frame.size.height-64.5);
    _table.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:_table];
    
    
    delciview = [[UIView alloc]init];
    delciview.frame = CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height*0.82);
    delciview.backgroundColor = [UIColor whiteColor];
    _table.tableHeaderView = delciview;
    
    
    UIImageView *shuju = [[UIImageView alloc]init];
    [delciview addSubview:shuju];
    [shuju mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (__kScreenHeight__ == 568) {
            make.top.mas_equalTo(0.653*__kScreenHeight__+2);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(0.19*__kScreenHeight__);
        }else if(__kScreenHeight__ == 667){
            make.top.mas_equalTo(0.634*__kScreenHeight__+2);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(0.195 *__kScreenHeight__);
        }else{
            make.top.mas_equalTo(0.636*__kScreenHeight__+2);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(__kScreenWidth__);
            make.height.mas_equalTo(0.195 *__kScreenHeight__);
        }
        
        
    }];
    
    [shuju setImage:[UIImage imageNamed:@"rili_shuzi.png"]];

    
    
    
    self.date = [NSDate date];
    [self setupCalendarView];
    
    
    
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li年%li-%li", (long)year,(long)month,(long)day);
    };
    
}

- (void)setupCalendarView {
        [self request12];
}

- (void)bottonClick {
    
    __weak __typeof(self) weakself = self;
    pickerView =[[PickerDateViewController alloc]init];
    [self.view addSubview:pickerView.view];
    pickerView.selectedBlock = ^(NSString * selectedDate){
        
//        [weakself buttonTitle:selectedDate];
        
        
        NSArray *arraynainde = [selectedDate componentsSeparatedByString:@"年"];
        
        NSString *susud = arraynainde[1];
        NSArray *yue1 = [susud componentsSeparatedByString:@"月"];
        NSLog(@"%@",yue1);
        
        int isios = [yue1[0] intValue];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:self.date];

        int isis = [comps day];
        
        if (isios >=10 && isis >= 10) {
            string = [NSString stringWithFormat:@"%@%@%d134106",arraynainde[0],yue1[0],isis];
        }else if(isis<10 && isios<10){
            string = [NSString stringWithFormat:@"%@0%@0%d134106",arraynainde[0],yue1[0],isis];
        }else if (isis< 10 && isios >=10)
        {
             string = [NSString stringWithFormat:@"%@%@0%d134106",arraynainde[0],yue1[0],isis];
        }else if (isis>=10 && isios<10)
        {
            string = [NSString stringWithFormat:@"%@0%@%d134106",arraynainde[0],yue1[0],isis];
        }

        NSLog(@"%@",string);
        
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
        [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate* inputDate = [inputFormatter dateFromString:string];
        NSLog(@"%@", inputDate);
        
        
        self.date = inputDate;
        
        
        [self.calendarView removeFromSuperview];
        [self setupCalendarView];

        [self request12];
    };
    
}

- (NSString *)buttonTitle:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    return title;
}


- (void)setupNextMonth {
    

         [self requestnext];
}

- (void)setupLastMonth {
         [self requestlast];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)request12{
    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDate* lastDate =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate* currentDate = [NSDate date];
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    
    if (timeExpire >= time) {
        //重新请求access_token
        
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        NSString *udid = [UIDevice currentDevice].model ;
        NSLog(@"************唯一标识符%@",uuid);
        
        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        
        NSString *path =
        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
        //读取文件
        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
        
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{@"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp": timeSp,
                        // @" backage_md5": @"1234678998765412374185296395175",
                        
                        @"app_session_token":sb}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults]setObject:objc[@"data"][@"expiresIn"] forKey:@"exptime"];
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    }
    else {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self.date];
    
    if ([comps month]<10) {
        datatimes = [NSString stringWithFormat:@"%ld-0%ld",[comps year],[comps month]];
    }
    else{
        datatimes = [NSString stringWithFormat:@"%ld-%ld",[comps year],[comps month]];
    }
    
    
    
    
    NSLog(@"%@",datatimes);
    [manager POST:@"http://debug.otouzi.com:8012/v2/user/calendar"
       parameters:@{ @"data":datatimes//月份
                     }
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {

              NSLog(@"rili  %@",responseObject);
              
              
              NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
              gerenzhongxin = responseObject;
              
              
              
              NSDictionary*maos = [gerenzhongxin objectForKey:@"data"];
              NSString *uie = [maos objectForKey:@"this_month_money"];
              
              
              
              
              
              NSDictionary *ysu = [gerenzhongxin objectForKey:@"data"];
              NSString *sjsjd = [ysu objectForKey:@"haveRepayMoney"];
              
              
              
              
              if (!This_month) {
                  
                  
                  This_month = [[UILabel alloc]init];
                  [delciview addSubview:This_month];
                  [This_month mas_makeConstraints:^(MASConstraintMaker *make) {
                      if(__kScreenHeight__ == 568){
                          make.top.mas_equalTo(0.727*__kScreenHeight__);
                          make.left.mas_equalTo(0);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }else{
                          make.top.mas_equalTo(0.697*__kScreenHeight__);
                          make.left.mas_equalTo(0);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }
                  }];
                  
                  This_month.textAlignment = UITextAlignmentCenter;
                  This_month.font = [UIFont systemFontOfSize:20];
                  This_month.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
              }
              This_month.text = [NSString stringWithFormat:@"%@",uie];
              if (!huan) {
                  
                  
                  huan = [[UILabel alloc]init];
                  [delciview addSubview:huan];
                  [huan mas_makeConstraints:^(MASConstraintMaker *make) {
                      if (__kScreenHeight__ == 568) {
                          make.top.mas_equalTo(0.727*__kScreenHeight__);
                          make.left.mas_equalTo(0.5*__kScreenWidth__);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }else
                      {
                          make.top.mas_equalTo(0.697*__kScreenHeight__);
                          make.left.mas_equalTo(0.5*__kScreenWidth__);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }
                      
                  }];
                  
                  
                  huan.textAlignment = UITextAlignmentCenter;
                  huan.font = [UIFont systemFontOfSize:20];
                  huan.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
                  
              }
              huan.text = [NSString stringWithFormat:@"%@",sjsjd];
              
              
              
              
              NSDictionary *yearsdaty = [gerenzhongxin objectForKey:@"data"];
              NSMutableArray *yesasrsh = [yearsdaty objectForKey:@"paydays"];
              monayhuan = yesasrsh;
              
              
               [self.calendarView removeFromSuperview];
              self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0,-50, self.view.frame.size.width , self.view.frame.size.width + 100)];
              //日期状态
                  self.calendarView.allDaysArr = monayhuan;
              //    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"12",@"15", @"19",nil];
              [delciview addSubview:self.calendarView];
              //    self.calendarView.isShowOnlyMonthDays = NO;
              self.calendarView.date = self.date;
              self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
                  NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
                  
                  
                  NSString* pco =[NSString stringWithFormat: @"%li",(long)day];
                  int psoso = [pco intValue];
                  NSLog(@"%d",psoso);
                  
                  
                  
                  
                  
                  if([monayhuan containsObject:pco])
                  {
                      
                  
    
                          NSLog(@"筛选成功");
                          [self.data removeAllObjects];
                          
                       
                          
                          [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
//                          for (int i = 0; i<yesasrsh.count ; i++) {
                      
//                              [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                      
                              
                              
//                              NSInteger a = i;
                              NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                              
                              NSDictionary *list = [yonghuming objectForKey:@"list"];
                      
                      
                      if (psoso<10) {
                          NSString *yye = [NSString stringWithFormat:@"%@-0%d",datatimes,psoso];
                          NSLog(@"%@",yye);
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                      }else{
                          NSString *yye = [NSString stringWithFormat:@"%@-%d",datatimes,psoso];
                          NSLog(@"%@",yye);
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                      }
                      
                      
                      
//                          }
                      
                      }else{
                          
                          
                          [self.data removeAllObjects];
                          
                          [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",yesasrsh.count] forKey:@"shuzusum"];
                          
                          [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                          for (int i = 0; i<yesasrsh.count ; i++) {
                              
                              [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                              
                              
                              
                              NSInteger a = i;
                              NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                              
                              NSDictionary *list = [yonghuming objectForKey:@"list"];
                              int osos = [yesasrsh[a] intValue];
                              if (osos<10) {
                                  NSString *yye = [NSString stringWithFormat:@"%@-0%@",datatimes,yesasrsh[a]];
                                  
                                  NSMutableArray *yonghuming2 = [list objectForKey:yye];
                                  
                                  for (NSDictionary *dataDic in yonghuming2) {
                                      
                                      
                                      rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                                      if (freshState33 == NO) {
                                          
                                          
                                          
                                          freshState33 = YES;
                                      }
                                      
                                      [self.data addObject:model1];
                                      self.table.data = self.data;
                                      
                                  }
                                  //刷新表视图，回到主线程
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      
                                      [self.table reloadData];
                                      
                                      
                                      
                                      
                                  });
                              }else{
                                  NSString *yye = [NSString stringWithFormat:@"%@-%@",datatimes,yesasrsh[a]];
                                  
                                  NSMutableArray *yonghuming2 = [list objectForKey:yye];
                                  
                                  for (NSDictionary *dataDic in yonghuming2) {
                                      
                                      
                                      rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                                      if (freshState33 == NO) {
                                          
                                          
                                          
                                          freshState33 = YES;
                                      }
                                      
                                      [self.data addObject:model1];
                                      self.table.data = self.data;
                                      
                                  }
                                  //刷新表视图，回到主线程
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      
                                      [self.table reloadData];
                                      
                                      
                                      
                                      
                                  });
                              }
                              
                              
                             
                              
                              
                          }
                          
                      }
                  

                  
                  
              };
              WS(weakSelf)
              self.calendarView.nextMonthBlock = ^(){
                  [weakSelf setupNextMonth];
              };
              self.calendarView.lastMonthBlock = ^(){
                  [weakSelf setupLastMonth];
              };
              
              
              
              button = [UIButton buttonWithType:UIButtonTypeCustom];
              button.backgroundColor =[UIColor clearColor];
              button.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width ,40);
              [button addTarget:self action:@selector(bottonClick) forControlEvents:UIControlEventTouchUpInside];
              [button setTitle:@"" forState:UIControlStateNormal];
              [delciview addSubview:button];

              if (yesasrsh.count == 0) {
                  
                  [self.data removeAllObjects];
                  NSMutableArray *yonghuming2 = nil;
                  for (NSDictionary *dataDic in yonghuming2) {
                      
                      
                      rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                      if (freshState33 == NO) {
                          
                          [self.data removeAllObjects];
                          
                          freshState33 = YES;
                      }
                      
                      [self.data addObject:model1];
                      self.table.data = self.data;
                      
                  }
                  //刷新表视图，回到主线程
                  dispatch_async(dispatch_get_main_queue(), ^{
                      
                      [self.table reloadData];
                      
                      
                      
                      
                  });
                  
                  
                  
                  
              }else{
                  
                  [self.data removeAllObjects];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",yesasrsh.count] forKey:@"shuzusum"];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                  for (int i = 0; i<yesasrsh.count ; i++) {
                      
                      [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                      
                      
                      
                      NSInteger a = i;
                      NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                      
                      NSDictionary *list = [yonghuming objectForKey:@"list"];
                      int osos = [yesasrsh[a] intValue];
                      
                      if (osos<10) {
                          NSString *yye = [NSString stringWithFormat:@"%@-0%@",datatimes,yesasrsh[a]];
                          
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                      }else{
                          NSString *yye = [NSString stringWithFormat:@"%@-%@",datatimes,yesasrsh[a]];
                          
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                      }
                      
                      
                      
                      
                      
                  }
                  
                  
              }
            
          }
          failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
              
          }];
}
-(void)aqlb:(id)sender
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)requestnext{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];

    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDate* lastDate =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate* currentDate = [NSDate date];
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    
    if (timeExpire >= time) {
        //重新请求access_token
        
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        NSString *udid = [UIDevice currentDevice].model ;
        NSLog(@"************唯一标识符%@",uuid);
        
        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        
        NSString *path =
        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
        //读取文件
        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
        
        
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{@"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp": timeSp,
                        // @" backage_md5": @"1234678998765412374185296395175",
                        
                        @"app_session_token":sb}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults]setObject:objc[@"data"][@"expiresIn"] forKey:@"exptime"];
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    }
    else {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self.date];
    
    if ([comps month]<10) {
        datatimes = [NSString stringWithFormat:@"%ld-0%ld",[comps year],[comps month]+1];
    }
    else{
        datatimes = [NSString stringWithFormat:@"%ld-%ld",[comps year],[comps month]+1];
    }
    
    
    
    
    NSLog(@"%@",datatimes);
    [manager POST:@"http://debug.otouzi.com:8012/v2/user/calendar"
       parameters:@{ @"data":datatimes//月份
                     }
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"rili  %@",responseObject);
              
              
              NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
              gerenzhongxin = responseObject;
              
              
              
              NSDictionary*maos = [gerenzhongxin objectForKey:@"data"];
              NSString *uie = [maos objectForKey:@"this_month_money"];
              
              
              
              
              
              NSDictionary *ysu = [gerenzhongxin objectForKey:@"data"];
              NSString *sjsjd = [ysu objectForKey:@"haveRepayMoney"];
              
              
              
              
              
              if (!This_month) {
                  
                  
                  This_month = [[UILabel alloc]init];
                  [delciview addSubview:This_month];
                  [This_month mas_makeConstraints:^(MASConstraintMaker *make) {
                      if(__kScreenHeight__ == 568){
                          make.top.mas_equalTo(0.727*__kScreenHeight__);
                          make.left.mas_equalTo(0);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }else{
                          make.top.mas_equalTo(0.697*__kScreenHeight__);
                          make.left.mas_equalTo(0);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }
                  }];
                  
                  This_month.textAlignment = UITextAlignmentCenter;
                  This_month.font = [UIFont systemFontOfSize:20];
                  This_month.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
              }
              This_month.text = [NSString stringWithFormat:@"%@",uie];
              if (!huan) {
                  
                  
                  huan = [[UILabel alloc]init];
                  [delciview addSubview:huan];
                  [huan mas_makeConstraints:^(MASConstraintMaker *make) {
                      if (__kScreenHeight__ == 568) {
                          make.top.mas_equalTo(0.727*__kScreenHeight__);
                          make.left.mas_equalTo(0.5*__kScreenWidth__);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }else
                      {
                          make.top.mas_equalTo(0.697*__kScreenHeight__);
                          make.left.mas_equalTo(0.5*__kScreenWidth__);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }
                      
                  }];
                  
                  
                  huan.textAlignment = UITextAlignmentCenter;
                  huan.font = [UIFont systemFontOfSize:20];
                  huan.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
                  
              }
              huan.text = [NSString stringWithFormat:@"%@",sjsjd];
              
              
              
              
              NSDictionary *yearsdaty = [gerenzhongxin objectForKey:@"data"];
              NSMutableArray *yesasrsh = [yearsdaty objectForKey:@"paydays"];
              monayhuan = yesasrsh;
              
              
              
              
              [self.calendarView removeFromSuperview];
              self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, -50, self.view.frame.size.width , self.view.frame.size.width +100)];
              [delciview addSubview:self.calendarView];
              self.calendarView.allDaysArr = monayhuan;
              NSLog(@"%@",monayhuan);
//              self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"19",nil];
              self.date = [self.calendarView nextMonth:self.date];
              [self.calendarView createCalendarViewWith:self.date];
              self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
                  NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
                  
                  
                  NSString* pco =[NSString stringWithFormat: @"%li",(long)day];
                  int psoso = [pco intValue];
                  NSLog(@"%d",psoso);
                  
                  if([monayhuan containsObject:pco])
                  {
                      
                      
                      
                      NSLog(@"筛选成功");
                      [self.data removeAllObjects];
                      
                      
                      
                      [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                      //                          for (int i = 0; i<yesasrsh.count ; i++) {
                      
                      //                              [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                      
                      
                      
                      //                              NSInteger a = i;
                      NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                      
                      NSDictionary *list = [yonghuming objectForKey:@"list"];
                      
                      
                      if (psoso<10) {
                          NSString *yye = [NSString stringWithFormat:@"%@-0%d",datatimes,psoso];
                          NSLog(@"%@",yye);
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                          

                      }else{
                          NSString *yye = [NSString stringWithFormat:@"%@-%d",datatimes,psoso];
                          NSLog(@"%@",yye);
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                          

                      }
                      
                      //                          }
                      
                  }else{
                      
                      
                      [self.data removeAllObjects];
                      
                      [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",yesasrsh.count] forKey:@"shuzusum"];
                      
                      [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                      for (int i = 0; i<yesasrsh.count ; i++) {
                          
                          [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                          
                          
                          
                          NSInteger a = i;
                          NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                          
                          NSDictionary *list = [yonghuming objectForKey:@"list"];
                          
                          
                          int soso = [yesasrsh[a] intValue];
                          if (soso<10) {
                              NSString *yye = [NSString stringWithFormat:@"%@-0%@",datatimes,yesasrsh[a]];
                              
                              NSMutableArray *yonghuming2 = [list objectForKey:yye];
                              
                              for (NSDictionary *dataDic in yonghuming2) {
                                  
                                  
                                  rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                                  if (freshState33 == NO) {
                                      
                                      
                                      
                                      freshState33 = YES;
                                  }
                                  
                                  [self.data addObject:model1];
                                  self.table.data = self.data;
                                  
                              }
                              //刷新表视图，回到主线程
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  [self.table reloadData];
                                  
                                  
                                  
                                  
                              });

                          }else{
                              NSString *yye = [NSString stringWithFormat:@"%@-%@",datatimes,yesasrsh[a]];
                              
                              NSMutableArray *yonghuming2 = [list objectForKey:yye];
                              
                              for (NSDictionary *dataDic in yonghuming2) {
                                  
                                  
                                  rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                                  if (freshState33 == NO) {
                                      
                                      
                                      
                                      freshState33 = YES;
                                  }
                                  
                                  [self.data addObject:model1];
                                  self.table.data = self.data;
                                  
                              }
                              //刷新表视图，回到主线程
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  [self.table reloadData];
                                  
                                  
                                  
                                  
                              });

                          }
                          
                          
                      }
                      
                  }
                  
                  
                  

                  
              };
              WS(weakSelf)
              self.calendarView.nextMonthBlock = ^(){
                  [weakSelf setupNextMonth];
              };
              self.calendarView.lastMonthBlock = ^(){
                  [weakSelf setupLastMonth];
              };
              
              button = [UIButton buttonWithType:UIButtonTypeCustom];
              button.backgroundColor =[UIColor clearColor];
              button.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width , 40);
              [button addTarget:self action:@selector(bottonClick) forControlEvents:UIControlEventTouchUpInside];
              [button setTitle:@"" forState:UIControlStateNormal];
              [delciview addSubview:button];

              
              
              
              
              
              
              
              
              
              if (yesasrsh.count == 0) {
                  
                  [self.data removeAllObjects];
                  NSMutableArray *yonghuming2 = nil;
                  for (NSDictionary *dataDic in yonghuming2) {
                      
                      
                      rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                      if (freshState33 == NO) {
                          
                          [self.data removeAllObjects];
                          
                          freshState33 = YES;
                      }
                      
                      [self.data addObject:model1];
                      self.table.data = self.data;
                      
                  }
                  //刷新表视图，回到主线程
                  dispatch_async(dispatch_get_main_queue(), ^{
                      
                      [self.table reloadData];
                      
                      
                      
                      
                  });
                  
                  
                  
                  
              }else{
                  
                  [self.data removeAllObjects];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",yesasrsh.count] forKey:@"shuzusum"];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                  for (int i = 0; i<yesasrsh.count ; i++) {
                      
                      [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                      
                      
                      
                      NSInteger a = i;
                      NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                      
                      NSDictionary *list = [yonghuming objectForKey:@"list"];
                      
                      int aosos = [yesasrsh[a] intValue];
                      if (aosos<10) {
                          NSString *yye = [NSString stringWithFormat:@"%@-0%@",datatimes,yesasrsh[a]];
                          
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });

                      }else{
                          NSString *yye = [NSString stringWithFormat:@"%@-%@",datatimes,yesasrsh[a]];
                          
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });

                      }
                      
                      
                  }
                  
                  
              }
              
          }
          failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
              
          }];
    
    [HUD hide:YES afterDelay:0.5];
}
-(void)requestlast{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //    //常用的设置
    //    //小矩形的背景色
    //    HUD.color = [UIColor lightGrayColor]; //这儿表示无背景
    //    //显示的文字
    //    HUD.labelText = @"正在加载";
    [HUD show:YES];

    NSString *path =
    [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
    //读取文件
    NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *sb = [notFirstDic objectForKey:@"sb"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDate* lastDate =
    [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_date"];
    NSDate* currentDate = [NSDate date];
    float time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"exptime"] floatValue];
    
    //时间戳
    float timeExpire =
    [currentDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    
    if (timeExpire >= time) {
        //重新请求access_token
        
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        NSString *udid = [UIDevice currentDevice].model ;
        NSLog(@"************唯一标识符%@",uuid);
        
        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        
        NSString *path =
        [NSHomeDirectory() stringByAppendingString:@"/Documents/dic.plist"];
        //读取文件
        NSDictionary *notFirstDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *sb = [notFirstDic objectForKey:@"sb"];
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
        
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        
        [manager POST:@"http://debug.otouzi.com:8012/device/register"
         
           parameters:@{@"device_type": @"ios",
                        @"device_unique":uuid,
                        @"device_model": udid,
                        @"system_version": currentVersion,
                        @"request_timestamp": timeSp,
                        // @" backage_md5": @"1234678998765412374185296395175",
                        
                        @"app_session_token":sb}
         
              success:^(AFHTTPRequestOperation * operation, id  responseObject) {
                  
                  
                  NSLog(@"%@",responseObject);
                  
                  
                  NSMutableDictionary *objc = [[NSMutableDictionary alloc] init];
                  
                  objc = responseObject;
                  
                  [[NSUserDefaults standardUserDefaults] setObject:objc[@"data"][@"access_token"] forKey:@"token"];//存在本地沙盒
                  
                  [[NSUserDefaults standardUserDefaults]setObject:objc[@"data"][@"expiresIn"] forKey:@"exptime"];
                  
                  [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"expire_date"];
                  
                  
                  
                  [[NSUserDefaults standardUserDefaults] synchronize];
              } failure:^(AFHTTPRequestOperation * operation, NSError *  error) {
                  
                  // NSLog(@"%@",error);
                  
              }];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
    }
    else {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        
        
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Access-Token"]; //请求头
        [manager.requestSerializer setValue:sb forHTTPHeaderField:@"Application-Session"];
        
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self.date];
    
    if ([comps month]<10) {
        datatimes = [NSString stringWithFormat:@"%ld-0%ld",[comps year],[comps month]-1];
    }
    else{
        datatimes = [NSString stringWithFormat:@"%ld-%ld",[comps year],[comps month]-1];
    }
    
    
    
    
    NSLog(@"%@",datatimes);
    [manager POST:@"http://debug.otouzi.com:8012/v2/user/calendar"
       parameters:@{ @"data":datatimes//月份
                     }
          success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
              
              NSLog(@"rili  %@",responseObject);
              
              
              NSDictionary *gerenzhongxin = [[NSDictionary alloc]init];
              gerenzhongxin = responseObject;
              
              
              
              NSDictionary*maos = [gerenzhongxin objectForKey:@"data"];
              NSString *uie = [maos objectForKey:@"this_month_money"];
              
              
              
              
              
              NSDictionary *ysu = [gerenzhongxin objectForKey:@"data"];
              NSString *sjsjd = [ysu objectForKey:@"haveRepayMoney"];
              
              
              
              
              if (!This_month) {
                  
                  
                  This_month = [[UILabel alloc]init];
                  [delciview addSubview:This_month];
                  [This_month mas_makeConstraints:^(MASConstraintMaker *make) {
                      if(__kScreenHeight__ == 568){
                          make.top.mas_equalTo(0.727*__kScreenHeight__);
                          make.left.mas_equalTo(0);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }else{
                          make.top.mas_equalTo(0.697*__kScreenHeight__);
                          make.left.mas_equalTo(0);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }
                  }];
                  
                  This_month.textAlignment = UITextAlignmentCenter;
                  This_month.font = [UIFont systemFontOfSize:20];
                  This_month.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
              }
              This_month.text = [NSString stringWithFormat:@"%@",uie];
              if (!huan) {
                  
                  
                  huan = [[UILabel alloc]init];
                  [delciview addSubview:huan];
                  [huan mas_makeConstraints:^(MASConstraintMaker *make) {
                      if (__kScreenHeight__ == 568) {
                          make.top.mas_equalTo(0.727*__kScreenHeight__);
                          make.left.mas_equalTo(0.5*__kScreenWidth__);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }else
                      {
                          make.top.mas_equalTo(0.697*__kScreenHeight__);
                          make.left.mas_equalTo(0.5*__kScreenWidth__);
                          make.width.mas_equalTo(0.5*__kScreenWidth__);
                          make.height.mas_equalTo(0.055*__kScreenHeight__);
                      }
                      
                  }];
                  
                  
                  huan.textAlignment = UITextAlignmentCenter;
                  huan.font = [UIFont systemFontOfSize:20];
                  huan.textColor = [UIColor colorWithRed:240/255.0 green:84/255.0 blue:69/255.0 alpha:1];
                  
              }
              huan.text = [NSString stringWithFormat:@"%@",sjsjd];
              
              
              
              NSDictionary *yearsdaty = [gerenzhongxin objectForKey:@"data"];
              NSMutableArray *yesasrsh = [yearsdaty objectForKey:@"paydays"];
              monayhuan = yesasrsh;
              
              
              
              
              [self.calendarView removeFromSuperview];
              self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, -50, self.view.frame.size.width , self.view.frame.size.width +100)];
              [delciview addSubview:self.calendarView];
              self.calendarView.allDaysArr = monayhuan;
//              self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"29", @"12",@"15", @"18", @"19",nil];
              self.date = [self.calendarView lastMonth:self.date];
              [self.calendarView createCalendarViewWith:self.date];
              self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
                  NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
                  
                  NSString* pco =[NSString stringWithFormat: @"%li",(long)day];
                  int psoso = [pco intValue];
                  NSLog(@"%d",psoso);
                  
                  if([monayhuan containsObject:pco])
                  {
                      
                      
                      
                      NSLog(@"筛选成功");
                      [self.data removeAllObjects];
                      
                      
                      
                      [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                      //                          for (int i = 0; i<yesasrsh.count ; i++) {
                      
                      //                              [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                      
                      
                      
                      //                              NSInteger a = i;
                      NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                      
                      NSDictionary *list = [yonghuming objectForKey:@"list"];
                      
                      
                      if (psoso<10) {
                          NSString *yye = [NSString stringWithFormat:@"%@-0%d",datatimes,psoso];
                          NSLog(@"%@",yye);
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                      }else{
                          NSString *yye = [NSString stringWithFormat:@"%@-%d",datatimes,psoso];
                          NSLog(@"%@",yye);
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                      }
                
                      
                      
                      //                          }
                      
                  }else{
                      
                      
                      [self.data removeAllObjects];
                      
                      [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",yesasrsh.count] forKey:@"shuzusum"];
                      
                      [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                      for (int i = 0; i<yesasrsh.count ; i++) {
                          
                          [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                          
                          
                          
                          NSInteger a = i;
                          NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                          
                          NSDictionary *list = [yonghuming objectForKey:@"list"];
                          
                          
                          int aoso = [yesasrsh[a] intValue];
                          if (aoso<10) {
                              NSString *yye = [NSString stringWithFormat:@"%@-0%@",datatimes,yesasrsh[a]];
                              
                              NSMutableArray *yonghuming2 = [list objectForKey:yye];
                              
                              for (NSDictionary *dataDic in yonghuming2) {
                                  
                                  
                                  rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                                  if (freshState33 == NO) {
                                      
                                      
                                      
                                      freshState33 = YES;
                                  }
                                  
                                  [self.data addObject:model1];
                                  self.table.data = self.data;
                                  
                              }
                              //刷新表视图，回到主线程
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  [self.table reloadData];
                                  
                                  
                                  
                                  
                              });
                          }else{
                              NSString *yye = [NSString stringWithFormat:@"%@-%@",datatimes,yesasrsh[a]];
                              
                              NSMutableArray *yonghuming2 = [list objectForKey:yye];
                              
                              for (NSDictionary *dataDic in yonghuming2) {
                                  
                                  
                                  rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                                  if (freshState33 == NO) {
                                      
                                      
                                      
                                      freshState33 = YES;
                                  }
                                  
                                  [self.data addObject:model1];
                                  self.table.data = self.data;
                                  
                              }
                              //刷新表视图，回到主线程
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  [self.table reloadData];
                                  
                                  
                                  
                                  
                              });
                          }
                         
                          
                          
                      }
                      
                  }
                  
                  
                  
                  
                  
              };
              WS(weakSelf)
              self.calendarView.lastMonthBlock = ^(){
                  [weakSelf setupLastMonth];
              };
              self.calendarView.nextMonthBlock = ^(){
                  [weakSelf setupNextMonth];
              };
              
              button = [UIButton buttonWithType:UIButtonTypeCustom];
              button.backgroundColor =[UIColor clearColor];
              button.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width , 40);
              [button addTarget:self action:@selector(bottonClick) forControlEvents:UIControlEventTouchUpInside];
              [button setTitle:@"" forState:UIControlStateNormal];
              [delciview addSubview:button];
              
              
              
              
              
              
              
              
              
              
              if (yesasrsh.count == 0) {
                  
                  [self.data removeAllObjects];
                  NSMutableArray *yonghuming2 = nil;
                  for (NSDictionary *dataDic in yonghuming2) {
                      
                      
                      rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                      if (freshState33 == NO) {
                          
                          [self.data removeAllObjects];
                          
                          freshState33 = YES;
                      }
                      
                      [self.data addObject:model1];
                      self.table.data = self.data;
                      
                  }
                  //刷新表视图，回到主线程
                  dispatch_async(dispatch_get_main_queue(), ^{
                      
                      [self.table reloadData];
                      
                      
                      
                      
                  });
                  
                  
                  
                  
              }else{
                  
                  [self.data removeAllObjects];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",yesasrsh.count] forKey:@"shuzusum"];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:datatimes forKey:@"nianyueri"];
                  for (int i = 0; i<yesasrsh.count ; i++) {
                      
                      [[NSUserDefaults standardUserDefaults]setObject:yesasrsh[i] forKey:[NSString stringWithFormat:@"shuzhu%d",i]];
                      
                      
                      
                      NSInteger a = i;
                      NSDictionary *yonghuming = [gerenzhongxin objectForKey:@"data"];
                      
                      NSDictionary *list = [yonghuming objectForKey:@"list"];
                      
                      int osos = [yesasrsh[a] intValue];
                      if (osos<10) {
                          NSString *yye = [NSString stringWithFormat:@"%@-0%@",datatimes,yesasrsh[a]];
                          
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                          

                      }else{
                          NSString *yye = [NSString stringWithFormat:@"%@-%@",datatimes,yesasrsh[a]];
                          
                          NSMutableArray *yonghuming2 = [list objectForKey:yye];
                          
                          for (NSDictionary *dataDic in yonghuming2) {
                              
                              
                              rilimodel *model1 =[[rilimodel alloc]initWithDataDic:dataDic];
                              if (freshState33 == NO) {
                                  
                                  
                                  
                                  freshState33 = YES;
                              }
                              
                              [self.data addObject:model1];
                              self.table.data = self.data;
                              
                          }
                          //刷新表视图，回到主线程
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              [self.table reloadData];
                              
                              
                              
                              
                          });
                          

                      }
                      
                  }
                  
                  
              }
              
          }
          failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
              
          }];

     [HUD hide:YES afterDelay:0.5];
}
@end
