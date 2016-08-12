//
//  HLSampleViewController.m
//  HLWeakTimer
//
//  Created by 刘豪亮 on 13/1/22.
//  Copyright © 2013年 LHL. All rights reserved.
//

#import "HLSampleViewController.h"

#import "HLWeakTimer.h"

static const char *HLSampleViewControllerTimerQueueContext = "HLSampleViewControllerTimerQueueContext";

@interface HLSampleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) HLWeakTimer *timer;

@property (strong, nonatomic) HLWeakTimer *backgroundTimer;

@property (strong, nonatomic) dispatch_queue_t privateQueue;

@end

@implementation HLSampleViewController

- (id)init
{
    if ((self = [super init]))
    {
        self.privateQueue = dispatch_queue_create("com.mruncle.private_queue", DISPATCH_QUEUE_CONCURRENT);
        
        self.backgroundTimer = [HLWeakTimer scheduledTimerWithTimeInterval:0.2
                                                                    target:self
                                                                  selector:@selector(backgroundTimerDidFire)
                                                                  userInfo:nil
                                                                   repeats:YES
                                                             dispatchQueue:self.privateQueue];
        
        dispatch_queue_set_specific(self.privateQueue, (__bridge const void *)(self), (void *)HLSampleViewControllerTimerQueueContext, NULL);
    }

    return self;
}

- (void)dealloc
{
    [_timer invalidate];
    [_backgroundTimer invalidate];
}

#pragma mark -

- (IBAction)toggleTimer:(UIButton *)sender
{
    static NSString *kStopTimerText = @"Stop";
    static NSString *kStartTimerText = @"Start";

    NSString *currentTitle = [sender titleForState:UIControlStateNormal];

    if ([currentTitle isEqualToString:kStopTimerText])
    {
        [sender setTitle:kStartTimerText forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    else
    {
        [sender setTitle:kStopTimerText forState:UIControlStateNormal];
        self.timer = [HLWeakTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(mainThreadTimerDidFire:)
                                                        userInfo:nil
                                                         repeats:YES
                                                   dispatchQueue:dispatch_get_main_queue()];
    }
}

- (IBAction)fireTimer
{
    [self.timer fire];
}

#pragma mark - HLWeakTimerDelegate

- (void)mainThreadTimerDidFire:(HLWeakTimer *)timer
{
    NSAssert([NSThread isMainThread], @"This should be called from the main thread");

    self.label.text = [NSString stringWithFormat:@"%ld", [self.label.text integerValue] + 1];
}

#pragma mark -

- (void)backgroundTimerDidFire
{
    NSAssert(![NSThread isMainThread], @"This shouldn't be called from the main thread");

    const BOOL calledInPrivateQueue = dispatch_queue_get_specific(self.privateQueue, (__bridge const void *)(self)) == HLSampleViewControllerTimerQueueContext;
    NSAssert(calledInPrivateQueue, @"This should be called on the provided queue");
}

@end
