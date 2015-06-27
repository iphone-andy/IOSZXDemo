//
//  outputREViewController.m
//  ZXdemo
//
//  Created by qiucanqing on 15/3/17.
//  Copyright (c) 2015年 renhe. All rights reserved.
//

#import "outputREViewController.h"
#import "ZXingObjC/ZXingObjC.h"

@interface outputREViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reText;
@property (weak, nonatomic) IBOutlet UIImageView *reImageView;
@end

@implementation outputREViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)action:(UIButton *)sender {
    
    [self.reText resignFirstResponder];
    
    NSString *data = self.reText.text;
    if (data == 0) return;
    
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
    ZXBitMatrix *result = [writer encode:data
                                  format:kBarcodeFormatQRCode
                                   width:self.reImageView.frame.size.width
                                  height:self.reImageView.frame.size.width
                                   error:nil];
    
    if (result) {
        ZXImage *image = [ZXImage imageWithMatrix:result];
        self.reImageView.image = [UIImage imageWithCGImage:image.cgimage];
    } else {
        self.reImageView.image = nil;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
