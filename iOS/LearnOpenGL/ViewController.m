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
    self.glView = [[OpenGLView alloc] init];
    self.glView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width);
    [self.view addSubview:self.glView];
}


@end
