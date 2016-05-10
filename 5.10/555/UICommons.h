//
//  UICommons.h
//  555
//
//  Created by mark on 15/10/20.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#ifndef UICommons_h
#define UICommons_h

#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)

#define __kScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __kScreenHeight__ ([[UIScreen mainScreen] bounds].size.height)
#define Font(R) [UIFont systemFontOfSize:R];
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )

#define kTabBarHeight 49
#define kNavigationBarHeight 64

#define iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define kFilterViewHeight ([UIScreen mainScreen].bounds.size.height)*2/3
#define kdeadlineButtonHeight 30 //筛选视图下 投资期限button的高



#define kScreenContentHeight (kScreenHeight-kTabBarHeight-kNavigationBarHeight)
#define kWidthScale ((([UIScreen mainScreen].bounds.size.width)/2)/375)
#define kHeightScale ((([UIScreen mainScreen].bounds.size.height)/2)/667)

#define kPlusScale (([UIScreen mainScreen].bounds.size.width)/1242)//1242
#define kPlusHeightScale (([UIScreen mainScreen].bounds.size.height)/2208)//2208

#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/1.0]//RGB色值
/*
 *整体红
 */
#define kColorRed [UIColor colorWithRed:211/255.0f green:74/255.0f blue:89/255.0f alpha:1/1.0]
/*
 *整体蓝
 */
#define kColorBlue [UIColor colorWithRed:212/255.0f green:218/255.0f blue:255/255.0f alpha:1/1.0]

/*
 *浅灰色
 */
#define kColorLightGray [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1/1.0]
/*
 *深灰色
 */

#define kColorGray [UIColor colorWithRed:150/255.0f green:150/255.0f blue:150/255.0f alpha:1/1.0]
/*
 *橙色
 */
#define kColorOrange [UIColor colorWithRed:255/255.0f green:81/255.0f blue:50/255.0f alpha:1/1.0]

/*
 *深蓝色
 */
#define kColorDeepBlue [UIColor colorWithRed:35/255.0f green:34/255.0f blue:57/255.0f alpha:1/1.0]

/*
 * 黄色
 */
#define kColorYellow [UIColor colorWithRed:246/255.0f green:216/255.0f blue:96/255.0f alpha:1/1.0]

/*
 *背景灰色
 */
#define kColorBackground [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1/1.0]



/*
 *主色调
 */
#define kColorMain [UIColor colorWithRed:233/255.0f green:76/255.0f blue:61/255.0f alpha:1/1.0]



/*
 *Naviline
 */

#define kColorNaviLine [UIColor colorWithRed:145/255.0f green:145/255.0f blue:145/255.0f alpha:1/1.0]



#define kColorNavi RGB(245, 245, 245, 1)


#define kColorWhite [UIColor whiteColor]


#define kcolorGrayNew RGB(235, 235, 235, 1)

#define kcolorFontGray RGB(145, 145, 145, 1)

#define kcolorGreen RGB(13, 163, 42, 1)

//ios系统版本
#define iso9x [[[UIDevice currentDevice] systemVersion] floatValue] >=9.0f
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f &&([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f)

#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f


#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.width==414.0f)


//#define  baseUrl =  @"http://debug.otouzi.com:8012";
//    UIColor *textColorB = RGB(212, 218, 255, 1);
//UIColor *textColorR = RGB(211, 74, 89, 1);

#endif /* UICommons_h */
