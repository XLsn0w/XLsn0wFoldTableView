//
//  XLsn0wSocketManager.h
//  XLsn0wKit_objc
//
//  Created by XLsn0w on 2017/6/24.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//
#define SocketHost @"地址"
#define SocketPort 端口

#import <Foundation/Foundation.h>

@class GCDAsyncSocket;

@interface XLsn0wSocketManager : NSObject

@property(nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic, copy)   NSString  *serviceHost;  //service IP Address
@property (nonatomic, assign) NSInteger  servicePort;//Service Port

//握手次数
@property(nonatomic,assign) NSInteger pushCount;

//断开重连定时器
@property(nonatomic,strong) NSTimer *timer;

//重连次数
@property(nonatomic,assign) NSInteger reconnectCount;

//单例
+ (instancetype)shared;

//连接
- (void)connectToServer;

//断开
- (void)cutOffSocket;

@end
