//
//  ViewController.m
//  WebviewTest
//
//  Created by yopi on 2013/02/21.
//  Copyright (c) 2013年 yopi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,retain) UIWebView* webview;
@property (nonatomic,retain) UIScrollView* scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.webview = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
  [self.view addSubview:self.webview];
  self.webview.delegate = self;
  
  self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectZero] autorelease];
  [self.view addSubview:self.scrollView];
  self.scrollView.delegate = self;
  
  NSURL* url = [NSURL URLWithString:@""];
  NSURLRequest* req = [[[NSURLRequest alloc] initWithURL:url] autorelease];
  [self.webview loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
  NSLog(@"url is loaded");
  self.scrollView.frame = self.view.bounds;
  self.scrollView.contentSize = self.webview.scrollView.contentSize;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  NSLog(@"scrollView did scroll");
  self.webview.scrollView.contentOffset = scrollView.contentOffset;
}
@end
