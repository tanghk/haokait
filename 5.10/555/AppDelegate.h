//
//  AppDelegate.h
//  555
//
//  Created by 李浩宇 on 15/9/22.
//  Copyright © 2015年 李浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"
#import "PageControl.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,PageControlDelegate,UIScrollViewDelegate>
{
    PageControl *thePGLeft;
    UIScrollView *scrVl;
    BOOL _notFisrtLauch;
    UIControl *maskView;
    UIVisualEffectView *effectView;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property float autoSizeScaleX;
@property float autoSizeScaleY;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

