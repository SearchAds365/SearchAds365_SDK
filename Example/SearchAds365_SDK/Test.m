//
//  Test.m
//  SearchAds365_SDK_Example
//
//  Created by apple on 2023/11/27.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

#import "Test.h"
@import SearchAds365_SDK;

@implementation Test

- (void)viewDidLoad {
    [super viewDidLoad];
    [SAMobileSDK activate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [SAMobileSDK trackWithEvent:@"eventName" extra:@"extra" user:@"user"];
    [SAMobileSDK trackWithEvent:@"eventName" extra:nil user:nil];
}
@end
