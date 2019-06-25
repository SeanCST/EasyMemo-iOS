//
//  ChatListViewController.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/6/24.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "ChatListViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建新会话
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBtn addTarget:self action:@selector(createConversationBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
}

- (void)createConversationBtnClick{
    // clientId 是聊天对象 AUser 对象的 objectId。例如下面这个是用户「李四」的 objectId：
    NSString *clientId = @"5a5b995cac502e006e2e1391";

    AVIMClient *client = [[AVIMClient alloc] initWithClientId:clientId];
    
//    AVIMClient *client = [LCChatKit sharedInstance].client;
    
    [client createConversationWithName:@"创建第一个会话"
                             clientIds:@[clientId]
                            attributes:nil
                               options:AVIMConversationOptionUnique
                              callback:^(AVIMConversation * _Nullable conversation, NSError * _Nullable error) {
                                
                                  
                                  
                                 [conversation sendMessage:[AVIMTextMessage messageWithText:@"你好，小王" attributes:nil]
                                                  callback:^(BOOL succeeded, NSError *error) {
                                                      
//                                                      if (succeeded) {
                                                          //创建会话成功，跳转到聊天详情页
                                                          LCCKConversationViewController *conversationViewController = [[LCCKConversationViewController alloc] initWithConversationId:conversation.conversationId];
                                                          [self.navigationController pushViewController:conversationViewController animated:YES];
//                                                      }
                                                  }];
                             }];
     
}

@end
