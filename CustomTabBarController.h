//
//  CustomTabBarController.h
//
//  Created by Manish Ahuja on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"

@protocol CustomTabBarControllerProtocol;


@interface CustomTabBarController : UITabBarController <CustomTabBarDelegate> {
    
    CustomTabBar *tabBarView;
    float tabBarHeight;
    NSMutableArray  *controllers;
    
}

@property (readonly) float tabBarHeight;

-(id)initWithViewControllers: (NSArray*)viewControllers andTabbarButtons:(NSArray*)buttons;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewControllers: (NSArray*)viewControllers andTabbarButtons:(NSArray*)buttons;

-(void)addCustomViewToTabBar: (UIView*)customView;
-(void)hideBottomBarOnPush;
-(void)showBottomBarOnPopAnimated: (BOOL)animated;
-(void)setTabbarBackgroundImage: (UIImage*)aBackgroundImage;

@end

@protocol CustomTabBarControllerProtocol <NSObject>

-(UIButton *)tabBarButtonForTabBar:(CustomTabBar *)tabBar;

@end
