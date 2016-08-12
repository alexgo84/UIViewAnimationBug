//
//  ViewController.m
//  AnimationBug
//
//  Created by Alex Gordon on 12/08/16.
//  Copyright © 2016 Alex Gordon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reproduceBug];
}

- (void)reproduceBug
{
    CGRect initialFrame = CGRectMake(0, 0, 0, 0);
    CGRect frame2 = CGRectMake(100, 100, 100, 100);
    CGRect finalFrame = CGRectMake(200, 200, 200, 200);
    
    
    __block UIView *view = [[UIView alloc] initWithFrame:initialFrame];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    NSLog(@"Initial frame is: %@", NSStringFromCGRect(view.frame));
    NSLog(@"Final frame should be: %@", NSStringFromCGRect(finalFrame));

    [UIView animateWithDuration:0.00000001 delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         view.frame = frame2;
                     } completion:^(BOOL finished) {
                             NSLog(@"After first animation frame is: %@", NSStringFromCGRect(view.frame));

                             [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                 view.frame = finalFrame;
                             }completion:^(BOOL finished) {
                                 NSLog(@"After third animation frame is: %@", NSStringFromCGRect(view.frame));
                                 [self doFurtherAnimationOnView:view];
                             }];
                     }];
    
}

- (void)doFurtherAnimationOnView:(UIView *)view
{
    NSTimeInterval duration = 10.0;
    
    NSLog(@"Will try to animate again with duration %@", @(duration));
    NSLog(@"Before animation time is %@", [NSDate date]);

    [UIView animateWithDuration:duration animations:^{
        view.frame = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        NSLog(@"After animation time is %@", [NSDate date]);
    }];
}

@end
