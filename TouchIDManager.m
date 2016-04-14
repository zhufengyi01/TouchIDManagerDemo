//
//  TouchIDManager.m
//  TouchIDManagerDemo
//
//  Created by 朱封毅 on 14/04/16.
//  Copyright © 2016年 taihe. All rights reserved.
//

#import "TouchIDManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDManager ()

/**
 *  手机是否可以使用TouchId
 */
@property(nonatomic,assign)BOOL canUseTouchId;

@end

@implementation TouchIDManager
+ (instancetype)sharedManager {
    
    static TouchIDManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[TouchIDManager alloc] init];
        
    });
    
    return _sharedManager;
}


#pragma mark 手机是否可以使用touchid
-(BOOL)validateCanUseTouchId
{
    
    LAContext  *locontext= [[LAContext alloc] init];
    NSError *err;
    self.canUseTouchId = [locontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err];
    
    return [locontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err];
    
}
#pragma mark Getter Method
#pragma mark 手机是否可以使用TouchId
-(BOOL)canUseTouchId
{
    
    return [self validateCanUseTouchId];
}

#pragma mark 指纹验证解锁的主要方法
-(void)touchIDWithlocalizedFallbackTitle:(NSString *)localizedFallbackTitle localizedReason:(NSString*)localizedReason success:(TouchIDManagerFinnishBlock) touchBlock;

{
    
    NSLog(@"指纹解锁预备");
    LAContext  *locontext= [[LAContext alloc] init];
    
    locontext.localizedFallbackTitle= localizedFallbackTitle;
    
    NSError *err;
    
    //3.判断设备是否支持指纹识别
    if ([locontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err]) {
        //是否支持
        NSLog(@"指纹解锁判断");
        [locontext  evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * error) {
            NSLog(@"开始指纹解锁");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                touchBlock(success,error);
                
            });
            
            
        }];
    }
    else{
        NSLog(@"设备不支持指纹解锁 %@", err);
        
    }
}


@end
