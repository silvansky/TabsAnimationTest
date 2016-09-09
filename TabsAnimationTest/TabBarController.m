//
//  TabBarController.m
//  TabsAnimationTest
//
//  Created by Valentine on 08.09.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import "TabBarController.h"

#import "ColoredViewController.h"

#import "SRPanAnimationController.h"
#import "SRHorizontalSwipeInteractionController.h"

#import <CEHorizontalSwipeInteractionController.h>
#import <CEPanAnimationController.h>
#import <CECubeAnimationController.h>


@interface TabBarController () <UIViewControllerTransitioningDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) ColoredViewController *redTab;
@property (nonatomic, strong) ColoredViewController *greenTab;
@property (nonatomic, strong) ColoredViewController *blueTab;
@property (nonatomic, strong) ColoredViewController *blackTab;
@property (nonatomic, strong) ColoredViewController *whiteTab;

@property (nonatomic, strong) SRHorizontalSwipeInteractionController *swipeController;
@property (nonatomic, strong) CEReversibleAnimationController *animationController;

@end

@implementation TabBarController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.swipeController = [SRHorizontalSwipeInteractionController new];
	self.animationController = [SRPanAnimationController new];

	self.redTab = [ColoredViewController redViewController];
	self.greenTab = [ColoredViewController greenViewController];
	self.blueTab = [ColoredViewController blueViewController];
	self.blackTab = [ColoredViewController blackViewController];
	self.whiteTab = [ColoredViewController whiteViewController];

	self.viewControllers = @[ self.redTab, self.greenTab, self.blueTab, self.blackTab, self.whiteTab ];
	self.selectedIndex = 2;

	// add gesture recognizers to all view controllers
	for (UIViewController *vc in self.viewControllers) {
		[self.swipeController prepareGestureRecognizerInView:vc.view];
	}

	[self.swipeController wireToViewController:self.blueTab];

	self.delegate = self;
}

#pragma mark - UITabBarControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
			animationControllerForTransitionFromViewController:(UIViewController *)fromVC
											  toViewController:(UIViewController *)toVC
{

	NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
	NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];

	self.animationController.reverse = fromVCIndex > toVCIndex;
	return self.animationController;
}

- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
					  interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
	return self.swipeController.interactionInProgress ? self.swipeController : nil;
}

@end
