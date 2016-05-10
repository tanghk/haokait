//
//  TabbarViewController.m
//  555
//
//  Created by 李浩宇 on 15/11/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import "TabbarViewController.h"
#import "DengluViewController.h"
#import "MainViewController.h"
#import "ChanpinViewController.h"

#import "BaseNavigationController.h"
#import "OtherNavigationController.h"
#import "AppDelegate.h"
#import "maitViewController.h"
#import "DiscoverController.h"
#import "DataService.h"
#import "UITabBar+badge.h"
#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
@interface TabbarViewController ()
{
    NSInteger _selectedIndex;   //选中界面
    BOOL _isFirst;              //首次点击
    int _a;
    
 
    
}

@end

@implementation TabbarViewController
@synthesize lastSelectedIndex = _lastSelectedIndex;


- (void)dealloc {
    
    //4.移除通知的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ssss" object:nil];
    //4.移除通知的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backController" object:nil];


   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"backMoreVC" object:nil];
    
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"yincang" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xianshi" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fanhui" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"quzhaunqian" object:nil];
  
    


}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   }
- (void)loadInformation:(id)result{
    


    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
   // [self _customTabBarButton];
    [self _addSubviewControlls];
   // [self requestUserInformationData];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backMoreVC) name:@"backMoreVC" object:nil];
   
    self.tabBar.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0  blue:244/255.0  alpha:1];
   
    MainViewController *homeVC = [[MainViewController alloc] init];
    ChanpinViewController *cateVC = [[ChanpinViewController alloc] init];
    maitViewController *shopVC = [[maitViewController alloc] init];
    DiscoverController *discoverVC = [[DiscoverController alloc]init];
    
    NSArray *controlls = @[homeVC,cateVC,discoverVC,shopVC];
    
    NSString *value =[[NSUserDefaults standardUserDefaults]objectForKey:@"bgValue"];
    NSLog(@"存入沙河的值：%@",value);

    
        
        NSArray *nImageNames = @[@"main_btn.png",
                         @"monay_btn.png",
                         @"finder_btn.png",
                         @"my_btnto.png"];
        NSArray *pImageNames = @[@"main_cilck.png",
                         @"monay_cilck.png",
                         @"finder_cilck.png",
                         @"my_cilckto.png"];
   
    

    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i < controlls.count; i++) {
     
            BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:controlls[i]];
            [viewControllers addObject:navController];
    }
    
    self.viewControllers = viewControllers;

    
    for (int i = 0; i < controlls.count; i++) {
        
        UIImage *imageNormal = [[UIImage imageNamed:nImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imagePress = [[UIImage imageNamed:pImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIViewController *vc = controlls[i];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:imageNormal selectedImage:imagePress];
        
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    }
    
    
    }


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
     NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    
    _selectedIndex = tabIndex;
    if (_selectedIndex == 0) {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"witch"]) ;
    }
    if (_selectedIndex == 1) {
        [[NSUserDefaults standardUserDefaults]setObject:@"b" forKey:@"witch"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"witch"]) ;
    }
    if (_selectedIndex == 2)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"d" forKey:@"witch"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"witch"]) ;
    }
    
    if (_selectedIndex == 3 ) {
        [[NSUserDefaults standardUserDefaults]setObject:@"c" forKey:@"witch"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"witch"]);
        NSString *banduan1=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
        int panduan1 = [banduan1 intValue];
        if (panduan1 == 200) {
            
            NSLog(@"已经登录过了");
            
            //            [[NSUserDefaults standardUserDefaults] setObject:@"89" forKey:@"zhijietiao"];//存在本地沙盒
            
        }
        else if(panduan1 !=200 )
        {
            AppDelegate *delect = (AppDelegate *)[UIApplication sharedApplication].delegate;
            DengluViewController *com = [[DengluViewController alloc]init];
            delect.window.rootViewController = com;
            
        }
        
        
    }
    
    
    
    

    
    
    
    
   
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"--tabbaritem.title--%@",viewController.tabBarItem.title);
    
    //这里我判断的是当前点击的tabBarItem的标题
   // if ([viewController.tabBarItem.title isEqualToString:@"个人"]) {
        //如果用户ID存在的话，说明已登陆
       
    //}
    return YES;
}

/*
 添加子视图控制器
 */

- (void)_addSubviewControlls {
   }

#pragma mark - 自定义标签栏

/*
 移除系统标签栏按钮
 */

- (void)_removeSystemTabBarButton {
    for (UIView *view in self.tabBar.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }
}



/*
 定制标签栏按钮
 */

- (void)_customTabBarButton {
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"imga_set.png"];

   
    

    
    
}

#pragma mark - 用户事件

/*
 视图切换
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)init{
    self = [super init];
  
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivenotifi) name:@"ssss" object:nil];
        
    }
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(yincang) name:@"yincang" object:nil];
    }
    if(self)
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xianshi) name:@"xianshi" object:nil];
        
    }
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fanhui) name:@"fanhui" object:nil];
    }
    
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backVC) name:@"backController" object:nil];
        
    }
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(quzhuanqianba) name:@"quzhaunqian" object:nil];
    }
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tantiao) name:@"bengbeng" object:nil];
    }
    
    return self;
}


-(void)quzhuanqianba
{
    
    self.selectedIndex = 1;
    
    
        
}


- (void)fanhui{
    
      self.selectedIndex = 3;
    
       NSString *banduan1=  [[NSUserDefaults standardUserDefaults] objectForKey:@"code1"];
    int panduan1 = [banduan1 intValue];
    if (panduan1 == 200) {
        
        NSLog(@"已经登录过了");
        
        //            [[NSUserDefaults standardUserDefaults] setObject:@"89" forKey:@"zhijietiao"];//存在本地沙盒
        
    }
    else if(panduan1 !=200 )
    {
        AppDelegate *delect = (AppDelegate *)[UIApplication sharedApplication].delegate;
        DengluViewController *com = [[DengluViewController alloc]init];
       delect.window.rootViewController = com;
      

    }

    
   
    
}
-(void)tantiao
{
    self.selectedIndex = 0;
    
    
    
  
    
    
  }
-(void)yincang
{
    

    
    
   
}

-(void)xianshi
{
   }

- (void)receivenotifi{
    
    
    
    self.selectedIndex = 0;
   
  
    

}

-(void)backVC{
   
   
        
     self.selectedIndex = 1;
    
        
    
    
    
    
  
    
    
     }
- (void)backMoreVC{
    
   
    
    self.selectedIndex = 3;
    
    
    
    
    
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
