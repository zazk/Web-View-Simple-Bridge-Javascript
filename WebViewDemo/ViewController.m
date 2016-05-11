//
//  ViewController.m
//  Novapet
//
//  Created by Biboo on 07/05/16.
//  Copyright (c) 2016 Novapet. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController 


- (void)viewDidLoad
{
    [super viewDidLoad];
   //Do any additional setup after loading the view, typically from a nib.
    NSString *urlString = @"https://novapet.cl/?appp=1";
    //NSString *urlString = @"http://htmlpreview.github.io/?https://github.com/nwcell/ics.js/blob/master/demo/demo.html";

    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    _webView.delegate = self;
 
    
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"addcal"]) {

        
        EKEventStore *store = [EKEventStore new];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = [URL pathComponents][3];
            NSNumber *startTime = [URL pathComponents][5];
            event.startDate = [NSDate dateWithTimeIntervalSinceNow: [startTime doubleValue] ]; //today
            event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
            event.calendar = [store defaultCalendarForNewEvents];
            NSError *err = nil;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
            
            NSInteger interval = [event.startDate timeIntervalSinceReferenceDate];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"calshow:%ld", interval]];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
