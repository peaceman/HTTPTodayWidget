//
//  TodayViewController.m
//  HTTP Widget
//
//  Created by Nico Nägele on 19/11/15.
//  Copyright © 2015 n2305. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

NSString* const kApiEndPointUrl = @"ApiEndPointUrl";
NSString* const kAppGroupName = @"group.com.n2305.HTTPTodayWidget";

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)triggerAction:(UIButton*)sender {
    NSLog(@"triggerButton triggered: %@", [[self getDefaults] stringForKey:kApiEndPointUrl]);
    
    NSString * urlString = [[self getDefaults] stringForKey:kApiEndPointUrl];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionConfiguration* defaultUrlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* urlSession = [NSURLSession sessionWithConfiguration:defaultUrlSessionConfig];
    [[urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"response %@", response);

        if (error) {
            NSLog(@"error %@", error);
        }
    }] resume];
}

- (NSUserDefaults*)getDefaults {
    return [[NSUserDefaults alloc] initWithSuiteName:kAppGroupName];
}

@end
