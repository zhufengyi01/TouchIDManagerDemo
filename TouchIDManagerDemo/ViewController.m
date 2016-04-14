//
//  ViewController.m
//  TouchIDManagerDemo
//
//  Created by 朱封毅 on 14/04/16.
//  Copyright © 2016年 taihe. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BOOL b =  [TouchIDManager sharedManager].canUseTouchId;
    
    if (b) {
        
        [[TouchIDManager sharedManager] touchIDWithlocalizedFallbackTitle:@"123" localizedReason:@"456" success:^(BOOL success, NSError *error) {
            
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
