//
//  CustomTabBar.m
//
//  Created by Manish on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar()

@property (nonatomic, retain) NSMutableArray    *tabBarButtons;

-(void)layoutTabBarButtons;
-(void)tabBarButtonClicked:(UIButton*)sender;

@end

@implementation CustomTabBar

@synthesize customView;
@synthesize tabBarButtons;
@synthesize delegate;

-(id) initWithFrame:(CGRect)frame andTabBarButtons: (NSMutableArray*)_tabBarButtons{

    self = [super initWithFrame:frame];
    
    if(self) {
        self.tabBarButtons = [_tabBarButtons copy];
        selectedTab = 0;
        numberOfTabs = [self.tabBarButtons count];
        backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,  57)];
        [self addSubview:backGroundView];
        [self layoutTabBarButtons];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{

    return [self initWithFrame:frame andTabBarButtons:nil];
    
}

-(void) layoutTabBarButtons {

    //layout buttons one after another
    for (int i = 0; i < [self.tabBarButtons count]; i++) {
        
        double buttonX = 0;
        if (i > 0) {
            buttonX = [[self.tabBarButtons objectAtIndex:i-1] frame].origin.x + [[self.tabBarButtons objectAtIndex:i-1] frame].size.width;
        }
        
        [[self.tabBarButtons objectAtIndex:i] setFrame:CGRectMake(buttonX, 0, [[self.tabBarButtons objectAtIndex:i] frame].size.width, [[self.tabBarButtons objectAtIndex:i] frame].size.height)];
        [[self.tabBarButtons objectAtIndex:i] addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:[self.tabBarButtons objectAtIndex:i]];
    }
}

-(void) dealloc{
    
    [self.customView release]; self.customView = nil;
    [self.tabBarButtons release];  self.tabBarButtons = nil;
    [backGroundView release]; backGroundView = nil;
    [super dealloc];

}

-(void)tabBarButtonClicked: (UIButton*)sender{

    int buttonIndex = [self.tabBarButtons indexOfObject:sender];
    
//    if (selectedTab == buttonIndex) {
//        return;
//    }
        
    if (![delegate respondsToSelector:@selector(switchToTabAtIndex:)]) {
        return;
    }
    
    selectedTab = buttonIndex;
    
    [delegate switchToTabAtIndex:selectedTab];
    
    for (int i = 0; i < [self.tabBarButtons count]; i++) {
            
        if (i ==  selectedTab) {
                
            [[self.tabBarButtons objectAtIndex:i] setSelected:YES];
                
        } else {
                
            [[self.tabBarButtons objectAtIndex:i] setSelected:NO];
                
        }
    }

}

-(void) setSelectedTabBarButtonAtIndex: (int)index {
    
    if (selectedTab == index) {
        return;
    }
    
    selectedTab = index;
    
    for (int i = 0; i < [self.tabBarButtons count]; i++) {
        
        if (i ==  selectedTab) {
            
            [[self.tabBarButtons objectAtIndex:i] setSelected:YES];
            
        } else {
            
            [[self.tabBarButtons objectAtIndex:i] setSelected:NO];
            
        }
    }

}

-(void)setBackgroundImage:(UIImage *)aBackgroundImage {

    [backGroundView setImage:aBackgroundImage];
}

@end
