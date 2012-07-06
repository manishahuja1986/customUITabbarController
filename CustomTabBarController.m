//
//  CustomTabBarController.m
//
//  Created by Manish Ahuja on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()

@property (nonatomic, retain) CustomTabBar *tabBarView;

- (void)setViewControllers: (NSArray*)viewControllers andTabBarButtons:(NSArray*)buttons;

@end

@implementation CustomTabBarController

@synthesize tabBarView;
@synthesize tabBarHeight;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewControllers: (NSArray*)viewControllers andTabbarButtons:(NSArray*)buttons{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setViewControllers:viewControllers andTabBarButtons: buttons];
        
    }
    return self;
    
}

-(id)initWithViewControllers: (NSArray*)viewControllers andTabbarButtons:(NSArray*)buttons{
    
    return [self initWithNibName:nil bundle:nil viewControllers:viewControllers andTabbarButtons:buttons];
    
}

-(id)init{
    
    return [self initWithNibName:nil bundle:nil viewControllers:nil andTabbarButtons:nil];
    
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil viewControllers:nil andTabbarButtons:nil];

}

- (void)dealloc
{
    [tabBarView release];
    
    [super dealloc];
}

-(void) setViewControllers:(NSArray *)viewControllers andTabBarButtons:(NSArray*)buttons{

    NSMutableArray *tabVCArray = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *tabBarButtons = [NSMutableArray arrayWithObjects: nil];

    for (int i= 0; i < [viewControllers count]; i++) {
        if (i< [buttons count]) {
            [tabVCArray addObject:[viewControllers objectAtIndex:i]];
            [tabBarButtons addObject:[buttons objectAtIndex:i]];
        }
    }
    
    [super setViewControllers:tabVCArray];
    
    if ([tabBarButtons count] > 0) {
        
        [[tabBarButtons objectAtIndex:0] setSelected:YES];
        //assuming all the buttons to be of same height
        tabBarHeight = [[tabBarButtons objectAtIndex:0] frame].size.height;
        
    }
    
    CustomTabBar *customTabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, 480 - tabBarHeight, 320, tabBarHeight) andTabBarButtons:tabBarButtons];
    
    [self.tabBarView removeFromSuperview];
    
    self.tabBarView = customTabBar;
    
    [self.tabBarView setDelegate:self];
    [self.view addSubview:self.tabBarView];    
    self.tabBar.hidden = TRUE;

    [customTabBar release];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{    
    [super viewDidLoad];

}

-(void) switchToTabAtIndex:(int)index {
        
    [self setSelectedIndex:index];
    
}

-(void) setSelectedIndex:(NSUInteger)selectedIndex {

    [super setSelectedIndex:selectedIndex];
    [self.tabBarView setSelectedTabBarButtonAtIndex: selectedIndex];

}

- (void)viewDidUnload
{
    
    self.tabBarView = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)addCustomViewToTabBar:(UIView *)customView {

    [self.tabBarView setCustomView:customView];
    
}

-(void)hideBottomBarOnPush{
    
    CGRect  frame = CGRectMake(-320, self.tabBarView.frame.origin.y, self.tabBarView.frame.size.width, self.tabBarView.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35];
    tabBarView.frame = frame;
    [UIView commitAnimations];

}

-(void)showBottomBarOnPopAnimated: (BOOL)animated {
    
    self.tabBar.hidden = TRUE;
    
    CGRect  frame = CGRectMake(0, self.tabBarView.frame.origin.y, self.tabBarView.frame.size.width, self.tabBarView.frame.size.height);
    
    if (animated) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.35];
        tabBarView.frame = frame;
        [UIView commitAnimations];
        
    } else {
        
        tabBarView.frame = frame;
    }
    
}

-(void)setTabbarBackgroundImage: (UIImage*)aBackgroundImage {
    
    [self.tabBarView setBackgroundImage:aBackgroundImage];
    
}

@end
