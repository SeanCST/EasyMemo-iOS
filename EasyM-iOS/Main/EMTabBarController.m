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
#import "ChatListViewController.h"
//#import "EMMessageViewController.h"
#import "EMMeViewController.h"

#import "LCCKUser.h"
#import <ChatKit/LCChatKit.h>


@interface EMTabBarController ()

@end

@implementation EMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
    
    [self setupIM];
}


- (void)setupChildVc {
    EMHomeViewController *homeVc = [[EMHomeViewController alloc] init];
    [self addOneChildVc:homeVc title:@"首页" imageName:@"tab_home" selectedImageName:@"tab_home_selected"];
    
    EMDiscoveryViewController *localVc = [[EMDiscoveryViewController alloc] init];
    [self addOneChildVc:localVc title:@"发现" imageName:@"tab_discovery" selectedImageName:@"tab_discovery_selected"];
    
//    ChatListViewController *messageVc = [[ChatListViewController alloc] init];
//    [self addOneChildVc:messageVc title:@"消息" imageName:@"tab_message" selectedImageName:@"tab_message_selected"];
    
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



- (void)setupIM {
    // userIds 指的是 ClientId 的集合。示例代码中开启聊天服务使用 AVUser 的 ObjectId 作为 ClientId。
    [[LCChatKit sharedInstance] setFetchProfilesBlock:^(NSArray<NSString *> *userIds, LCCKFetchProfilesCompletionHandler completionHandler) {
        
        if (userIds.count == 0) {
            return;
        }
        NSMutableArray *users = [NSMutableArray arrayWithCapacity:userIds.count];
        for (NSString *clientId in userIds) {
            //查询 _User 表需开启 find 权限
            AVQuery *userQuery = [AVQuery queryWithClassName:@"_User"];
            AVObject *user = [userQuery getObjectWithId:clientId];
            if (user) {
                //"avatar" 是 _User 表的头像字段
                AVFile *file = [user objectForKey:@"avatar"];
                LCCKUser *user_ = [LCCKUser userWithUserId:user.objectId name:[user objectForKey:@"username"] avatarURL:[NSURL URLWithString:file.url] clientId:clientId];
                [users addObject:user_];
            }else{
                //注意：如果网络请求失败，请至少提供 ClientId！
                LCCKUser *user_ = [LCCKUser userWithClientId:clientId];
                [users addObject:user_];
            }
        }
        !completionHandler ?: completionHandler([users copy], nil);
        
    }];
    
    [self setupIMRegister];
}


- (void)setupIMRegister {
    // AVUser 注册新用户
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = @"张三";// 设置用户名
    user.password =  @"123";// 设置密码
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功，给用户设置头像
            AVFile *file = [AVFile fileWithRemoteURL:[NSURL URLWithString:@"http://pic37.nipic.com/20140113/8800276_184927469000_2.png"]];
            [user setObject:file forKey:@"avatar"];
            [user saveInBackground];
        }
    }];
    
    [self setupIMLoginIn];
}

- (void)setupIMLoginIn {
    // AVUser 登录
    [AVUser logInWithUsernameInBackground:@"张三" password:@"123" block:^(AVUser *user, NSError *error) {
        if (user!=nil) {
            //登录聊天服务
            [[LCChatKit sharedInstance] openWithClientId:user.objectId callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //登录成功，跳转到会话列表页面，ChatListViewController 继承于 LCCKConversationListViewController，详情见下面的会话列表介绍。
                    ChatListViewController *vc = [[ChatListViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
    }];
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
