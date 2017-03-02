//
//  ViewController.m
//  TGTestCookie
//
//  Created by lzq on 2017/2/24.
//  Copyright © 2017年 lzq. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    [mgr POST:@"http://59.111.101.18/api/v1/login" parameters:@{@"account":@"18610976395",@"password":@"12345678"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
//        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:@"http://59.111.101.18/api/v1/login"]];
//        for (NSHTTPCookie *cookie in cookies) {
//            NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
//        }
//        NSLog(@"\n======================================\n");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)login:(id)sender {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *seri = [AFHTTPRequestSerializer serializer];
    [seri setHTTPShouldHandleCookies:YES];
    //    seri set
    mgr.requestSerializer = seri;
    
    [mgr POST:@"http://59.111.101.18/api/v1/login" parameters:@{@"account":@"18610976395",@"password":@"12345678"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
//        NSDictionary *dic =
        
        //方法一：从返回的responseObject里面直接取出cookie 存入沙箱在appdelegate里使用
        
        NSUserDefaults *userCookies = [NSUserDefaults standardUserDefaults];
        [userCookies setObject:[[responseObject objectForKey:@"data"] objectForKey:@"session_id"] forKey:@"cookie"];
        [userCookies synchronize];
        //方法二：自己生成cookie然后保存
        /*
        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:@"http://59.111.101.18/api/v1/login"]];
                for (NSHTTPCookie *cookie in cookies) {
                    NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
                    [[NSUserDefaults standardUserDefaults] setValue:cookie.name forKey:@"cookie"];
                    
                }
        NSDictionary *request = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        NSUserDefaults *userCookies = [NSUserDefaults standardUserDefaults];
        [userCookies setObject:[[responseObject objectForKey:@"data"] objectForKey:@"session_id"] forKey:@"cookie"];
        [userCookies synchronize];
         */
        self.label.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
         

}

- (IBAction)requset:(id)sender {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

//    AFHTTPRequestSerializer *ser =   [AFHTTPRequestSerializer serializer];
//    [ser setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"cookie"]  forHTTPHeaderField:@"cookie"];
//    [ser setHTTPShouldHandleCookies:YES];
//    mgr.requestSerializer = ser;
    [mgr POST:@"http://59.111.101.18/api/v1/check" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       self.label.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding];
//        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (IBAction)logout:(id)sender {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    [mgr DELETE:@"http://59.111.101.18/api/v1/login" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       self.label.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (IBAction)put:(id)sender {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    AFHTTPRequestSerializer *ser =   [AFHTTPRequestSerializer serializer];
//    [ser setHTTPShouldHandleCookies:YES];
//    mgr.requestSerializer = ser;
//    参数名	类型	必需	描述	示例 e.g.
//    nickName	string	是	昵称
//    gender	string	是	性别 male男 /. female女
//    birthday	string	是	生日
//    province	string	是	省
//    city	string	是	市
//    area	string	是	区
//    statement	string	是	个人说明
//    avatar	string	是	头像
    [mgr PUT:@"http://59.111.101.18/api/v1/user_setting" parameters:@{
                                                                      @"nickName":@"zhangsan",
                                                                      @"gender":@"男",
                                                                      @"birthday":@"2331",
                                                                      @"province":@"dd",
                                                                      @"city":@"dd",
                                                                      @"statement":@"dfadsfas",
                                                                      @"avatar":@"dfddf"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                          self.label.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",[responseObject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (IBAction)userInfo:(id)sender {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    AFHTTPRequestSerializer *ser =   [AFHTTPRequestSerializer serializer];
//    [ser setValue:@"" forHTTPHeaderField:@"cookie"];
//    [ser setHTTPShouldHandleCookies:YES];
//    mgr.requestSerializer = ser;
    [mgr GET:@"http://59.111.101.18/api/v1/user_home/:id" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         self.label.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
//    [mgr GET:@"http://59.111.101.18/api/v1/user_home/:id" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        self.label.text = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    http://{{host}}/api/v1/user_home/:id
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
