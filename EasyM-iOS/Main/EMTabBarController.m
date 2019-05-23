//
//  EMTabBarController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/2/21.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "EMTabBarController.h"
#import "EMNavigationController.h"
#import "EMHomeViewController.h"
#import "EMDiscoveryViewController.h"
#import "EMMessageViewController.h"
#import "EMMeViewController.h"

@interface EMTabBarController ()

@end

@implementation EMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
}


- (void)setupChildVc {
    EMHomeViewController *homeVc = [[EMHomeViewController alloc] init];
    [self addOneChildVc:homeVc title:@"首页" imageName:@"tab_home" selectedImageName:@"tab_home_selected"];
    
    EMDiscoveryViewController *localVc = [[EMDiscoveryViewController alloc] init];
    [self addOneChildVc:localVc title:@"发现" imageName:@"tab_discovery" selectedImageName:@"tab_discovery_selected"];
    
    EMMessageViewController *messageVc = [[EMMessageViewController alloc] init];
    [self addOneChildVc:messageVc title:@"消息" imageName:@"tab_message" selectedImageName:@"tab_message_selected"];
    
    EMMeViewController *meVc = [[EMMeViewController alloc] init];
    [self addOneChildVc:meVc title:@"我" imageName:@"tab_me" selectedImageName:@"tab_me_selected"];
    
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    childVc.title = title;
    // 设置tabbarButton的文字颜色
    // 普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = EMTabBarTitleColor;
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = EMTabBarTitleSelectedColor;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置不必渲染图片，否则ios7中会自动给图片渲染
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = image;
    
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    EMNavigationController *navVc = [[EMNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:navVc];
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
