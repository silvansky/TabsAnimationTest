//
//  SRPanAnimationController.m
//  TabsAnimationTest
//
//  Created by Valentine on 09.08.16.
//  Copyright © 2016 Silvansky. All rights reserved.
//

#import "SRPanAnimationController.h"

@implementation SRPanAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
	CGFloat horizontalSize = fromView.frame.size.width;

	self.duration = .3f;

	// Add the toView to the container
	UIView *containerView = [transitionContext containerView];
	[containerView addSubview:toView];

	CGRect toViewFrame = toView.frame;
	toViewFrame.origin.x = (self.reverse ? -horizontalSize : horizontalSize);
	toView.frame = toViewFrame;

	CGRect toViewTargetFrame = toView.frame;
	toViewTargetFrame.origin.x = 0.f;

	CGRect toViewCancelledFrame = toView.frame;
	toViewCancelledFrame.origin.x = 0.f;

	CGRect fromViewTargetFrame = fromView.frame;
	fromViewTargetFrame.origin.x = (!self.reverse ? -horizontalSize : horizontalSize);

	CGRect fromViewCancelledFrame = fromView.frame;
	fromViewCancelledFrame.origin.x = 0.f;

	self.reverse ? [containerView sendSubviewToBack:toView] : [containerView bringSubviewToFront:toView];

	// animate
	NSTimeInterval duration = [self transitionDuration:transitionContext];

	[UIView animateWithDuration:duration animations:^{
		fromView.frame = fromViewTargetFrame;
		toView.frame = toViewTargetFrame;
	} completion:^(BOOL finished) {
		if ([transitionContext transitionWasCancelled]) {
			fromView.frame = fromViewCancelledFrame;
			toView.frame = toViewCancelledFrame;
		} else {
			// reset from- view to its original state
			[fromView removeFromSuperview];
			fromView.frame = fromViewTargetFrame;
			toView.frame = toViewTargetFrame;
		}
		[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
	}];
}

@end
