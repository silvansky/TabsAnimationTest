//
//  SRHorizontalSwipeInteractionController.m
//  TabsAnimationTest
//
//  Created by Valentine on 07.09.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import "SRHorizontalSwipeInteractionController.h"
#import <objc/runtime.h>

const NSString *kSRHorizontalSwipeGestureKey = @"kSRHorizontalSwipeGestureKey";

@implementation SRHorizontalSwipeInteractionController
{
	BOOL _shouldCompleteTransition;
	UIViewController *_viewController;
	CGFloat _startingX;
}

- (void)wireToViewController:(UIViewController *)viewController
{
	self.popOnRightToLeft = YES;
	_viewController = viewController;
	[self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view
{
	UIPanGestureRecognizer *gesture = objc_getAssociatedObject(view, (__bridge const void *)(kSRHorizontalSwipeGestureKey));

	if (gesture) {
		return;
	}

	gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	[view addGestureRecognizer:gesture];

	objc_setAssociatedObject(view, (__bridge const void *)(kSRHorizontalSwipeGestureKey), gesture,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Private

- (CGFloat)completionSpeed
{
	return 1 - self.percentComplete;
	//return 1.f;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
	CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
	CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
	CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];

	switch (gestureRecognizer.state) {
		case UIGestureRecognizerStateBegan: {

			_startingX = touchPoint.x;

			BOOL rightToLeftSwipe = vel.x < 0;

			self.interactionInProgress = YES;

			// for tab controllers, we need to determine which direction to transition
			if (rightToLeftSwipe) {
				if (_viewController.tabBarController.selectedIndex < _viewController.tabBarController.viewControllers.count - 1) {
					_viewController.tabBarController.selectedIndex++;
				}
			} else {
				if (_viewController.tabBarController.selectedIndex > 0) {
					_viewController.tabBarController.selectedIndex--;
				}
			}
			break;
		}
		case UIGestureRecognizerStateChanged: {
			if (self.interactionInProgress) {
				// compute the current position
				CGFloat fraction = fabs(translation.x / gestureRecognizer.view.frame.size.width);
				fraction = fminf(fraction, 1.f);

				// 100 pt must be enough
				_shouldCompleteTransition = (fabs(translation.x) > 100.f);

				// if an interactive transitions is 100% completed via the user interaction, for some reason
				// the animation completion block is not called, and hence the transition is not completed.
				// This glorious hack makes sure that this doesn't happen.
				// see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
				if (fraction >= 1.0)
					fraction = 0.999;

				[self updateInteractiveTransition:fraction];
			}
			break;
		}
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled:
			if (self.interactionInProgress) {
				self.interactionInProgress = NO;
				if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
					[self cancelInteractiveTransition];
				}
				else {
					[self finishInteractiveTransition];
				}
			}
			break;
		default:
			break;
	}
}

@end
