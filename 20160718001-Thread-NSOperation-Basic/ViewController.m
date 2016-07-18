//
//  ViewController.m
//  20160718001-Thread-NSOperation-Basic
//
//  Created by Rainer on 16/7/18.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self invocationOperationFuction];
    
    [self blockOperationFunction];
}

- (void)invocationOperationFuction {
    // 创建并初始化一个队列对象
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run:) object:@"test"];
    
    // 开启队列
    [invocationOperation start];
}

/**
 *  block方式执行队列
 */
- (void)blockOperationFunction {
    // block方式创建一个队列对象，这里是在主线程中
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"test run in %@", [NSThread currentThread]);
    }];
    
    // 以下addExecutionBlock均在不同的子线程中执行
    [blockOperation addExecutionBlock:^{
        NSLog(@"test2 run in %@", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"test3 run in %@", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"test4 run in %@", [NSThread currentThread]);
    }];
    
    [blockOperation start];
}

/**
 *  队列执行的方法
 */
- (void)run:(NSString *)param {
    NSLog(@"test run in %@", [NSThread currentThread]);
}

@end
