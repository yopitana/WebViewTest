//
//  ViewController.m
//  WebviewTest
//
//  Created by yopi on 2013/02/21.
//  Copyright (c) 2013年 yopi. All rights reserved.
//

#import "ViewController.h"

@interface OverlayView : UIView

@property (nonatomic,retain) UIView* hitDelegateView;
@end

@implementation OverlayView

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  UIView *view = [super hitTest:point withEvent:event];
  NSLog(@"view=%@",view);
  if (self.hitDelegateView) {
    return self.hitDelegateView;
  } else {
    return [super hitTest:point withEvent:event];
  }
}

@end

@interface ViewController () <UIWebViewDelegate,UIScrollViewDelegate>
-(void)enableUserInteractionWebviewLinkTap;
-(void)disenableUserInteractionWebviewLinkTap;
-(void)tapEnableButton;
-(void)tapDisnableButton;
-(void)tapScrollView:(UITapGestureRecognizer*)sender;

@property (nonatomic,retain) UIWebView* webview;
@property (nonatomic,retain) UIScrollView* scrollView;
@property (nonatomic,retain) OverlayView* overlayView;
@property (nonatomic,retain) UIButton* enableButton;
@property (nonatomic,retain) UIButton* disenableButton;
@property (nonatomic,retain) UITapGestureRecognizer *scrollViewTapRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.webview = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
  
  [self.view addSubview:self.webview];
  self.webview.delegate = self;
  
  self.enableButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  self.enableButton.frame = CGRectMake(10, 410, 80, 44);
  [self.enableButton setTitle:@"enable" forState:UIControlStateNormal];
  [self.enableButton addTarget:self action:@selector(tapEnableButton) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.enableButton];

  self.disenableButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  self.disenableButton.frame = CGRectMake(160, 410, 80, 44);
  [self.disenableButton setTitle:@"disenable" forState:UIControlStateNormal];
  [self.disenableButton addTarget:self action:@selector(tapDisnableButton) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:self.disenableButton];
  
 // self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectZero] autorelease];
 // [self.view addSubview:self.scrollView];
 // self.scrollView.delegate = self;
  
  NSURL* url = [NSURL URLWithString:@"http://labo.tv/2chnews/"];
  NSURLRequest* req = [[[NSURLRequest alloc] initWithURL:url] autorelease];
  [self.webview loadRequest:req];
}

-(void)dealloc
{
  self.webview = nil;
  self.scrollView = nil;
  self.overlayView = nil;
  self.enableButton = nil;
  self.disenableButton = nil;
  [super dealloc];
}

-(void)enableUserInteractionWebviewLinkTap
{
  [self.overlayView removeFromSuperview];
  self.overlayView = nil; 
}

-(void)disenableUserInteractionWebviewLinkTap
{
  self.overlayView = [[[OverlayView alloc] initWithFrame:self.view.bounds] autorelease];
  self.overlayView.backgroundColor = [UIColor clearColor];
  self.overlayView.hitDelegateView = self.webview.scrollView;
  [self.webview addSubview:self.overlayView];
  self.scrollViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
  [self.webview.scrollView addGestureRecognizer:self.scrollViewTapRecognizer];

}

-(void)tapEnableButton
{
  [self.webview.scrollView removeGestureRecognizer:self.scrollViewTapRecognizer];
  [self enableUserInteractionWebviewLinkTap];
}

-(void)tapDisnableButton
{
  [self disenableUserInteractionWebviewLinkTap];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
  NSLog(@"url is loaded");
}

-(void)tapScrollView:(UITapGestureRecognizer*)sender
{
  NSLog(@"tapped");  
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  NSLog(@"scrollView did scroll");
 // self.webview.scrollView.contentOffset = scrollView.contentOffset;
}
@end
