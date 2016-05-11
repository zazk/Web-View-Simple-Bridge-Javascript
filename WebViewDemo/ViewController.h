//
//  ViewController.h
//  Novapet
//
//  Created by Biboo on 07/05/16.
//  Copyright (c) 2016 Novapet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic) NSString *savedEventId;

@end
