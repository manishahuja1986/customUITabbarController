//
//  CustomTabBar.h
//
//  Created by Manish Ahuja on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CustomTabBarDelegate;

@interface CustomTabBar : UIView {
    id <CustomTabBarDelegate> delegate;
    NSMutableArray  *tabBarButtons;
    UIView  *customView;
    int selectedTab;
    int numberOfTabs;
    UIImageView  *backGroundView;

}

@property (nonatomic, assign) id<CustomTabBarDelegate> delegate;
@property (nonatomic, retain) UIView    *customView;


-(id) initWithFrame:(CGRect)frame andTabBarButtons: (NSMutableArray*)tabBarButtons;
-(void) setSelectedTabBarButtonAtIndex: (int)index;
-(void)setBackgroundImage: (UIImage*)aBackgroundImage;

@end


@protocol CustomTabBarDelegate <NSObject>

-(void)switchToTabAtIndex: (int)index;

@end
