//
//  XXOperation.m
//  Thread
//
//  Created by Summer on 2018/12/25.
//  Copyright © 2018 Summer. All rights reserved.
//

#import "XXOperation.h"

@interface XXOperation ()
@property (nonatomic , copy) NSString *operName;
@property (nonatomic , assign) BOOL over;

@end

@implementation XXOperation

- (instancetype)initWithName:(NSString *)operName{
    if (self = [super init]) {
        self.operName = operName;
    }
    return self;
}

- (void)main{
    for (int index = 0; index < 3; index ++) {
        NSLog(@"index ==== %d,operName = %@",index,self.operName);
        [NSThread sleepForTimeInterval:1.0];
    }

    //mian 方式结束，依赖消失
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [NSThread sleepForTimeInterval:1.0];
//        if (self.cancelled) {
//            return ;
//        }
//        NSLog(@"operName = %@",self.operName);
//        self.over = YES;
//    });
//    //异步操作，为了让线程不要立马执行完，而是当任务执行完才释放资源
//    while (!self.over && !self.cancelled) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
    
}
@end
