//
//  TicketManager.m
//  Thread
//
//  Created by Summer on 2018/12/25.
//  Copyright © 2018 Summer. All rights reserved.
//

#import "TicketManager.h"


#define Total 50

@interface TicketManager ()

@property (nonatomic,assign) NSInteger tickets;//剩余票数
@property (nonatomic,assign) NSInteger saleCount;//卖出票数
//使用NSThread
@property (nonatomic,strong) NSThread *threadBJ;//北京票点
@property (nonatomic,strong) NSThread *threadSH;//上海票点

//使用NSInvocationOperation + NSOperationQueue
//@property (nonatomic , strong) NSInvocationOperation *operationBJ;
//@property (nonatomic , strong) NSInvocationOperation *operationSH;
//@property (nonatomic , strong)  NSOperationQueue *queue;

/*
 NSLock、NSConditionLock、NSRecursiveLock、NSCondition加锁方式都一样，都是实现NSLocking协议
 
 */
@property (nonatomic,strong) NSCondition *condition;
@property (nonatomic , strong) dispatch_semaphore_t semaphore;

@end

@implementation TicketManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _condition = [[NSCondition alloc]init];
        _semaphore = dispatch_semaphore_create(1);
        
        _tickets = Total;
        _threadBJ = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        _threadSH = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        
        [_threadBJ setName:@"北京"];
        [_threadSH setName:@"上海"];
        
        
//        _operationBJ = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sale) object:nil];
//        [_operationBJ setName:@"北京"];
//
//        _operationSH = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sale) object:nil];
//        [_operationSH setName:@"上海"];
    }
    return self;
}

- (void)sale{
    while (1) {
        //1、synchronized
//        @synchronized (self) {
            if (self.tickets > 0 ) {
                [NSThread sleepForTimeInterval:0.1];
                self.tickets --;
                self.saleCount = Total - self.tickets;
                NSLog(@"%@ , 卖出 = %ld，剩余= %ld",[NSThread currentThread].name,(long)self.saleCount,(long)self.tickets);
            }else{
                break;//一定要break，不然就会死循环
            }
//        }
//        2、NSCondition
//        [self.condition lock];
//        if (self.tickets > 0 ) {
//            [NSThread sleepForTimeInterval:0.1];
//            self.tickets --;
//            self.saleCount = Total - self.tickets;
//            NSLog(@"%@ , 卖出 = %d，剩余= %d",[NSThread currentThread].name,self.saleCount,self.tickets);
//        }else{
//            break;
//        }
//        [self.condition unlock];
//
        //3、dispatch_semaphore方式
//        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
//        if (self.tickets > 0 ) {
//            [NSThread sleepForTimeInterval:0.1];
//            self.tickets --;
//            self.saleCount = Total - self.tickets;
//            NSLog(@"%@ , 卖出 = %d，剩余= %d",[NSThread currentThread].name,self.saleCount,self.tickets);
//        }else{
//            dispatch_semaphore_signal(self.semaphore);
//            break;
//        }
//        dispatch_semaphore_signal(self.semaphore);
    }
}

- (void)startToSale{
    [_threadSH start];
    [_threadBJ start];
    
//    _queue = [[NSOperationQueue alloc]init];
//    [_queue addOperation:_operationBJ];
//    [_queue addOperation:_operationSH];
//
}


@end
