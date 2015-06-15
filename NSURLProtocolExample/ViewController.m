//
//  ViewController.m
//  NSURLProtocolExample
//
//  Created by lujb on 15/6/15.
//  Copyright (c) 2015年 lujb. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *go;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)go:(id)sender {
    if ([self.urlTextField isFirstResponder]) {
        [self.urlTextField resignFirstResponder];
    }
    
    [self sendRequest];

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self sendRequest];
    
    return YES;
}

#pragma mark - request

- (void) sendRequest {
    
    NSString *text = self.urlTextField.text;
    if (![text isEqualToString:@""]) {
        
        NSURL *url = [NSURL URLWithString:text];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
    }
    
}
- (IBAction)afnetworkingGo:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.douban.com/v2/book/isbn/9787505715660" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *bookInfo = (NSDictionary*)responseObject;
        NSLog(@"bookInfo:%@",bookInfo);
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request faile:%@",error.description);
    }];

}

@end
