//
//  ViewController.m
//  analytics
//
//  Created by Alexander Desyatov on 05/04/16.
//  Copyright © 2016 desyatov. All rights reserved.
//

#import "ViewController.h"
#import "DAAnalytics.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, strong, readonly) DAAnalytics *analytics;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    DAAnalytics *analytics = [[DAAnalytics alloc] init];
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [analytics send];
    }];
    
    @weakify(self);
    [[command.executionSignals switchToLatest] subscribeNext:^(id x) {
        @strongify(self);
        [self presentAlertWithMessage:[x description]];
    }];
    [command.errors subscribeNext:^(id x) {
        
    }];
    _sendButton.rac_command = command;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)presentAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
