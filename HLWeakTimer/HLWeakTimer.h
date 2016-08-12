//
//  HLWeakTimer.h
//  HLWeakTimer
//
//  Created by 刘豪亮 on 13/1/20.
//  Copyright © 2013年 LHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLWeakTimer : NSObject

/**
*  通过实例方法创建一个timer对象，使用`-schedule`来调起计时
*
*  @param timeInterval  时间间隔
*  @param target        方法调用的对象
*  @param selector      调用的方法
*  @param userInfo      用户传递的参数，可为空
*  @param repeats       如果时YES，则一直重复调用方法，直到定时器销毁。若为NO，则仅执行一次
*  @param dispatchQueue 可以在当前线程或者时多线程
*
*  @return 返回的实例对象
*/
- (id)initWithTimeInterval:(NSTimeInterval)timeInterval
                    target:(id)target
                  selector:(SEL)selector
                  userInfo:(id)userInfo
                   repeats:(BOOL)repeats
             dispatchQueue:(dispatch_queue_t)dispatchQueue;

/**
 *  使用静态方法创建定时器并立即执行
 */
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                        target:(id)target
                                      selector:(SEL)selector
                                      userInfo:(id)userInfo
                                       repeats:(BOOL)repeats
                                 dispatchQueue:(dispatch_queue_t)dispatchQueue;

/**
 *  如果创建了定时器但还没有执行，可以调用此方法
 */
- (void)schedule;

/**
 *  定时器公差，默认值为0
 */
@property (atomic, assign) NSTimeInterval tolerance;

- (void)fire;

- (void)invalidate;

- (id)userInfo;

@end
