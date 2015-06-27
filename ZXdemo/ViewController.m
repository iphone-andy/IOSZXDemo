//
//  ViewController.m
//  ZXdemo
//
//  Created by qiucanqing on 15/3/17.
//  Copyright (c) 2015年 renhe. All rights reserved.
//


#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, strong) UIView *scanRectView;
@property (nonatomic, strong) UILabel *decodedLabel;

@end

@implementation ViewController

#pragma mark - View Controller Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    
    self.scanRectView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 280, 400)];
    self.scanRectView.backgroundColor = [UIColor clearColor];
    self.scanRectView.layer.masksToBounds = YES;
    self.scanRectView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.scanRectView.layer.borderWidth = 1.0f;
    self.decodedLabel = [[UILabel alloc ]initWithFrame:CGRectMake(50, 70, 200, 30)];
    self.decodedLabel.text = @"take a photo";
    [self.view addSubview:self.scanRectView];
    [self.view addSubview:self.decodedLabel];
    [self.view bringSubviewToFront:self.scanRectView];
    [self.view bringSubviewToFront:self.decodedLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    
    // We got a result. Display information about the result onscreen.
    //NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
    //NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.decodedLabel.text = result.text;
    });
    
    // Vibrate--震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}




@end
