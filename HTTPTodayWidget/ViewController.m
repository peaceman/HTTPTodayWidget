//
//  ViewController.m
//  HTTPTodayWidget
//
//  Created by Nico Nägele on 19/11/15.
//  Copyright © 2015 n2305. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *currentApiEndpointUrl;
@property (weak, nonatomic) IBOutlet UITextField *inputApiEndPointUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults* defaults = [self getDefaults];
    
    self.inputApiEndPointUrl.text = [defaults stringForKey:kApiEndPointUrl];
    self.currentApiEndpointUrl.text = [defaults stringForKey:kApiEndPointUrl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultsChanged:(NSNotification *)notification {
    self.currentApiEndpointUrl.text = [[self getDefaults] stringForKey:kApiEndPointUrl];
}

- (IBAction)saveButtonAction:(UIButton *)sender {
    NSString* input = self.inputApiEndPointUrl.text;
    if (input.length == 0) {
        return;
    }
    
    [[self getDefaults] setValue:input forKey:kApiEndPointUrl];
    [[self getDefaults] synchronize];
}

- (NSUserDefaults*)getDefaults {
    return [[NSUserDefaults alloc] initWithSuiteName:kAppGroupName];
}

@end
