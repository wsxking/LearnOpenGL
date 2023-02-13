//
//  ViewController.m
//  LearnOpenGL
//
//  Created by TomWang on 2023/2/6.
//

#import "ViewController.h"
#import "OpenGLView.h"

@interface ViewController ()
@property (nonatomic, strong) OpenGLView *glView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.glView = [[OpenGLView alloc] initWithFrame:CGRectMake(0, 20, 375, 375)];
    [self.view addSubview:self.glView];
}


@end
