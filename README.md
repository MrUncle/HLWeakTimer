HLWeakTimer
===========

## Description

HLWeakTimer用法类似`NSTimer`，但是不会造成与target之间的循环引用。

## Usage
1.将文件`HLWeakTimer.h` 和 `HLWeakTimer.m`拖入你的工程
2.将头文件`HLWeakTimer.h`导入
3.使用类方法创建一个`HLWeakTimer`对象:
4.记得在`-dealloc`方法中调用`invalidate`来销毁timer

```objc
+ (HLWeakTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                         target:(id)target
                                       selector:(SEL)selector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats
                                  dispatchQueue:(dispatch_queue_t)dispatchQueue;
```


