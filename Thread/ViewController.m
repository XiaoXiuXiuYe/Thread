//
//  ViewController.m
//  Thread
//
//  Created by Summer on 2018/12/25.
//  Copyright © 2018 Summer. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "TicketManager.h"
#import "XXOperation.h"

@interface ViewController ()
@property (nonatomic , strong)  NSOperationQueue *operationQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 100, 50)];
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"pThread " forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickPthread) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 120, 100, 50)];
    button1.backgroundColor = [UIColor cyanColor];
    [button1 setTitle:@"NSThread " forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickNSthread) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 190, 100, 50)];
    button2.backgroundColor = [UIColor cyanColor];
    [button2 setTitle:@"加锁 " forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickClock) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button2];
    
  
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(100, 260, 150, 50)];
    button3.backgroundColor = [UIColor cyanColor];
    [button3 setTitle:@"syncSerial " forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(syncSerial) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(100, 330, 150, 50)];
    button4.backgroundColor = [UIColor cyanColor];
    [button4 setTitle:@"asyncSerial " forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(asyncSerial) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button4];
    
    UIButton *button5 = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 150, 50)];
    button5.backgroundColor = [UIColor cyanColor];
    [button5 setTitle:@"syncConcurrent " forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(syncConcurrent) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button5];
    
    UIButton *button6 = [[UIButton alloc]initWithFrame:CGRectMake(100, 470, 150, 50)];
    button6.backgroundColor = [UIColor cyanColor];
    [button6 setTitle:@"asyncConcurrent " forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(asyncConcurrent) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button6];
    
    UIButton *button7 = [[UIButton alloc]initWithFrame:CGRectMake(100, 540, 150, 50)];
    button7.backgroundColor = [UIColor cyanColor];
    [button7 setTitle:@"syncMain " forState:UIControlStateNormal];
    [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button7 addTarget:self action:@selector(syncMain) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button7];
    
    UIButton *button8 = [[UIButton alloc]initWithFrame:CGRectMake(100, 610, 150, 50)];
    button8.backgroundColor = [UIColor cyanColor];
    [button8 setTitle:@"asyncMain " forState:UIControlStateNormal];
    [button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button8 addTarget:self action:@selector(asyncMain) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:button8];
    
    #pragma mark --  test
//    [self clickNSOperation];
}

#pragma mark -- pThread
- (void)clickPthread{
    NSLog(@"我在主线程执行");
    pthread_t thread;
    NSString *param = @"i am pthread param";
    pthread_create(&thread, NULL, run, (__bridge void *)(param));
    
}

void *run (void *param){
    NSString *str = (__bridge NSString *)(param);
    for (int i = 0; i < 3; i ++) {
        NSLog(@"i = %d,str = %@",i,str);
        sleep(1);
    }
    return NULL;
}

#pragma mark -- NSThread

- (void)clickNSthread{
    NSLog(@"我在主线程执行-----NSthread");
    //1、通过alloc initc创建并执行线程，可以拿到thread对象
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(runNSthread) object:nil];
    //设置名字
    [thread setName:@"thread"];
    //设置优先级，优先级在0 - 1之间
    [thread setThreadPriority:0.2];
    [thread start];
   
    
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(runNSthread) object:nil];
    [thread2 setName:@"thread2"];
    [thread2 setThreadPriority:0.5];
    [thread2 start];
//    //2、通过detachNewThreadSelector 创建并执行线程，不能拿到thread对象
//    [NSThread detachNewThreadSelector:@selector(runNSthread) toTarget:self withObject:nil];
//    //3、通过performSelectorInBackground 创建并执行线程，不能拿到thread对象
//    [self performSelectorInBackground:@selector(runNSthread) withObject:nil];
    
}

- (void)runNSthread{
    NSLog(@"name = %@,我在子线程执行-----NSthread",[NSThread currentThread].name);
    for (int i = 0; i <= 2; i ++) {
        if ([NSThread currentThread].isCancelled) {
            return;
        }
        NSLog(@"name = %@，i = %d",[NSThread currentThread].name,i);
        if (i == 1 && [[NSThread currentThread].name isEqualToString:@"thread"]) {
            [[NSThread currentThread] cancel];
        }
        if (i == 2) {
            //回到主线程
            [self performSelectorOnMainThread:@selector(runMianThread) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void)runMianThread{
    NSLog(@"回到主线程执行-----NSthread");
}


/*  加锁实现线程安全*/
- (void)clickClock{
    TicketManager *manager = [[TicketManager alloc]init];
    [manager startToSale];
}

#pragma mark -- GCD
/*
 同步执行 + 串行队列
 不会开启新线程，在当前线程中执行任务，一个任务执行完毕后，再执行下一个任务
 */
- (void)syncSerial{
    NSLog(@" syncSerial  start");
    dispatch_queue_t queue = dispatch_queue_create("com.xiuxiu.syncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    NSLog(@" syncSerial  end");
}

/*
 异步执行 + 串行队列
 会开启新线程，但是因为队列是串行的，一个任务执行完毕后，再执行下一个任务
 */

- (void)asyncSerial{
    NSLog(@" asyncSerial  start");
    dispatch_queue_t queue = dispatch_queue_create("com.xiuxiu.asyncSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    NSLog(@" asyncSerial  end");
}

/*
 同步执行 + 并行队列
 不会开启新线程，在当前线程中执行任务，一个任务执行完毕后，再执行下一个任务
 */

- (void)syncConcurrent{
    NSLog(@" syncConcurrent  start");
    dispatch_queue_t queue = dispatch_queue_create("com.xiuxiu.syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    NSLog(@" syncConcurrent  end");
}
/*
 异步执行 + 并行队列
 开启多个线程，任务交替执行
 */


- (void)asyncConcurrent{
    NSLog(@" asyncConcurrent  start");
    dispatch_queue_t queue = dispatch_queue_create("com.xiuxiu.asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    NSLog(@" asyncConcurrent  end");
}

/*
 同步执行 + 主队列
 在主线程中调用，出现死锁
 在其他线程中调用，不会开启线程，一个任务执行完毕后，再执行下一个任务
 */

- (void)syncMain{
    NSLog(@"主线程");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" syncMain  start");
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_sync(queue, ^{
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务一，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        });
        dispatch_sync(queue, ^{
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务二，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        });
        NSLog(@" syncMain  end");
    });
}

/*
 异步执行 + 主队列
 不会开启新线程，在主线程中执行，一个任务执行完毕后，再执行下一个任务
 */

- (void)asyncMain{
    NSLog(@" asyncMain  start");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    NSLog(@" asyncMain  end");
}

#pragma mark --  GCD通信
/*
 
  GCD 通信
 
 */
- (void)gcdCommunication{
    NSLog(@"我在主线程");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程");
        });
    });
}

#pragma mark -- dispatch_once
/*
   dispatch_once
 */
- (void)testGcdOnce{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            [self gcdOnce];
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            [self gcdOnce];
        }
    });
}

- (void)gcdOnce{
    NSLog(@"%s",__func__);
    static TicketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TicketManager alloc]init];
        NSLog(@"创建对象");
    });
}

#pragma mark -- dispatch_after

/*
 dispatch_after
 */
- (void)gcdAfter{
    NSLog(@"%s",__func__);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%s",__func__);
    });
}

#pragma mark -- dispatch_apply
/*
 dispatch_apply:快速迭代
 */
- (void)gcdApply{
    //1.在并串队列使用dispatch_apply
//    NSLog(@"主线程");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"apply begin");
//        dispatch_apply(6, dispatch_get_main_queue(), ^(size_t index) {
//            NSLog(@"index = %zu",index);
//        });
//
//        NSLog(@"apply end");
//    });
    
    //2.在并行队列使用dispatch_apply
        NSLog(@"apply begin");
        dispatch_apply(6, dispatch_get_global_queue(0, 0), ^(size_t index) {
            NSLog(@"index = %zu",index);
        });
        NSLog(@"apply end");

}

#pragma mark -- dispatch_barrier

/*
 
 需求：我们需要异步执行两个操作（一个操作可以是一个任务，也可以是多个任务，这里是两个任务），而且第一组操作结束后，才能开始第二组操作
 
 */

- (void)gcdBarrier{
    NSLog(@"主线程");
    dispatch_queue_t queue = dispatch_queue_create("com.xiuxiu.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    //1.dispatch_barrier_sync
//    dispatch_barrier_sync(queue, ^{
//        for (NSInteger i = 0; i < 3; i ++) {
//            NSLog(@" barrier1，i = %ld",(long)i);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//        for (NSInteger i = 0; i < 3; i ++) {
//            NSLog(@" barrier2，i = %ld",(long)i);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//    });
    
    //2.dispatch_barrier_async
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@" barrier1，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@" barrier2，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    NSLog(@"---------barrier代码后面----------------");
    
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务三，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务四，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
}

- (void)requirementGroupAsync{
    NSLog(@"主线程");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务一，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        
    });
    dispatch_group_async(group, queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    
    //1.dispatch_group_notify
    dispatch_group_notify(group, queue, ^{
        NSLog(@"------dispatch_group_notify------");
        dispatch_async(queue, ^{
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务三，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        });
        dispatch_async(queue, ^{
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务四，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        });

    });
    //2.dispatch_group_wait
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"-----dispatch_group_wait----");
//    dispatch_async(queue, ^{
//        for (NSInteger  i = 0; i < 3; i ++) {
//            NSLog(@" 任务三，i = %ld",(long)i);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//    });
//    dispatch_async(queue, ^{
//        for (NSInteger  i = 0; i < 3; i ++) {
//            NSLog(@" 任务四，i = %ld",(long)i);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//    });
    
}


- (void)requirementGroupEnter{
    NSLog(@"主线程");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务二，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
        dispatch_group_leave(group);
    });

    //1.dispatch_group_notify
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"------dispatch_group_notify------");
//        dispatch_async(queue, ^{
//            for (NSInteger  i = 0; i < 3; i ++) {
//                NSLog(@" 任务三，i = %ld",(long)i);
//                [NSThread sleepForTimeInterval:1.0];
//            }
//        });
//        dispatch_async(queue, ^{
//            for (NSInteger  i = 0; i < 3; i ++) {
//                NSLog(@" 任务四，i = %ld",(long)i);
//                [NSThread sleepForTimeInterval:1.0];
//            }
//        });
//
//    });
//    2.dispatch_group_wait
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        NSLog(@"-----dispatch_group_wait----");
        dispatch_async(queue, ^{
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务三，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        });
        dispatch_async(queue, ^{
            for (NSInteger  i = 0; i < 3; i ++) {
                NSLog(@" 任务四，i = %ld",(long)i);
                [NSThread sleepForTimeInterval:1.0];
            }
        });
    
}


#pragma mark -- dispatch_group

/*
 dispatch_group_async 和 dispatch_group_enter + dispatch_group_leave的区别，用异步代码区分
 
  */

- (void)gcdGroupAsync{
    NSLog(@"主线程");
//    dispatch_group_async 里面，应该放同步代码，而不是异步代码
        dispatch_queue_t queue = dispatch_queue_create("com.gcd.group", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
    
            [self sendRequest:^{
                NSLog(@"sendRequest done");
            }];
        });
    
        dispatch_group_async(group, queue, ^{
            [self sendRequest2:^{
                NSLog(@"sendRequest2 done");
            }];
        });
        dispatch_group_notify(group, queue, ^{
            NSLog(@"all task over");
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"回到主线程刷新UI");
            });
        });
}

- (void)gcdGroupEnter{
    NSLog(@"主线程");
  
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self sendRequest:^{
        NSLog(@"sendRequest done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self sendRequest2:^{
        NSLog(@"sendRequest2 done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"all task over");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程刷新UI");
        });
    });
}


- (void)sendRequest:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 1");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}

- (void)sendRequest2:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 2");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}


#pragma mark -- dispatch_semaphore
/*
   dispatch_semaphore 使用计数来完成这个问题，计数为0 ，不可以通过，计数大于等于1，可以通过
   dispatch_semaphore_create ：创建semaphore并初始化信号量
   dispatch_semaphore_signal ：信号量加1
   dispatch_semaphore_wait ： 判断当前信号量的值，如果当前信号量大于0，信号量减1，往下执行，如果当前信号量等于0，就会阻塞在当前线程，一直等待
 */


- (void)gcdSemaphore{
    NSLog(@"主线程");
    dispatch_queue_t queue = dispatch_queue_create("com.xiuxiu.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务一，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
        long x = dispatch_semaphore_signal(semaphore);
        NSLog(@"signal后的信号量 = %ld",x);
    });
   
    long x = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"wait后的信号量 = %ld",x);
    NSLog(@"---dispatch_semaphore_wait-----");
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务三，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger  i = 0; i < 3; i ++) {
            NSLog(@" 任务四，i = %ld",(long)i);
            [NSThread sleepForTimeInterval:1.0];
        }
    });
    
}


- (void)test{
    NSLog(@"主线程");
    dispatch_semaphore_t signal;
    signal = dispatch_semaphore_create(1);
    __block long x = 0;
    NSLog(@"0_x:%ld",x);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"waiting");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"1_x:%ld",x);
        
        sleep(2);
        NSLog(@"waking");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"2_x:%ld",x);
    });
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"3_x:%ld",x);
    
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"wait 2");
    NSLog(@"4_x:%ld",x);
    
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"wait 3");
    NSLog(@"5_x:%ld",x);
    
}

#pragma mark -- NSOperation

- (void)clickNSOperation{
    NSLog(@"主线程");
    //使用start方式执行任务，三种方式，无论在哪个线程调用，都是同步执行

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //    1、NSInvocationOperation
//        NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationAction) object:nil];
//        [invocationOperation start];
//        NSLog(@"end----");
//    });

    
//     2、blockOperation
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        for (NSInteger index = 0; index < 3; index ++) {
//            NSLog(@"1 ==== %ld",(long)index);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//    }];
//    [blockOperation addExecutionBlock:^{
//        for (NSInteger index = 0; index < 3; index ++) {
//            NSLog(@"2 ==== %ld",(long)index);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//    }];
//
//    [blockOperation start];
//    NSLog(@"end----");
//
//
    
      //3、自定义类继承自NSOperation
//      XXOperation *operationA = [[XXOperation alloc]initWithName:@"operationA"];
//      [operationA start];
//      NSLog(@"end---");
//
//    NSOperation + NSOperationQueue 实现异步执行
//    获取主队列
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];

    XXOperation *operationA = [[XXOperation alloc]initWithName:@"operationA"];
    XXOperation *operationB = [[XXOperation alloc]initWithName:@"operationB"];
    XXOperation *operationC = [[XXOperation alloc]initWithName:@"operationC"];
    XXOperation *operationD = [[XXOperation alloc]initWithName:@"operationD"];
    if (!self.operationQueue) {
        self.operationQueue = [[NSOperationQueue alloc]init];
    }
//    self.operationQueue.maxConcurrentOperationCount = 1;//值 = 1，串行队列
    self.operationQueue.maxConcurrentOperationCount = 4;//值 = 4，并行队列

//     设置D依赖于A ，A 依赖于C，C 依赖于B
    [operationD addDependency:operationA];
    [operationA addDependency:operationC];
    [operationC addDependency:operationB];
     //设置优先级
    operationA.queuePriority = NSOperationQueuePriorityVeryHigh;
    operationB.queuePriority = NSOperationQueuePriorityVeryHigh;
    operationC.queuePriority = NSOperationQueuePriorityHigh;
    operationD.queuePriority = NSOperationQueuePriorityVeryHigh;

    [self.operationQueue addOperation:operationA];
    [self.operationQueue addOperation:operationB];
    [self.operationQueue addOperation:operationC];
    [self.operationQueue addOperation:operationD];
    NSLog(@"end---");
    
//    线程间通信
//    self.operationQueue = [[NSOperationQueue alloc]init];
//    [self.operationQueue addOperationWithBlock:^{
//        for (NSInteger index = 0; index < 3; index ++) {
//            NSLog(@"invocation ==== %ld",(long)index);
//            [NSThread sleepForTimeInterval:1.0];
//        }
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            NSLog(@"回到主线程");
//            NSLog(@"end---");
//        }];
//    }];
    
    
}

- (void)invocationAction{
    for (NSInteger index = 0; index < 3; index ++) {
        NSLog(@"invocation ==== %ld",(long)index);
        [NSThread sleepForTimeInterval:1.0];
    }
}

@end
