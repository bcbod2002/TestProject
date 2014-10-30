//
//  RabbitMQViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/10/14.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "RabbitMQViewController.h"
#include <sys/time.h>

#define SUMMARY_EVERY_US 1000000

@interface RabbitMQViewController ()
{
    NSString *consumerString;
}
@end

@implementation RabbitMQViewController

char const *hostname = "172.16.40.65";
int port = 5672;
char const *userName = "guest";
char const *password = "guest";

char const *exchange = "fanot";

char const *bindingkey = "hello";
char const *routingkey = "hello";

char const *queue = "Goston";

int sockfd;
amqp_connection_state_t conn;
amqp_bytes_t queuename;

// Goston ADD Fail Because the cpu architecture with 32 bit are conflit with Facebook Pods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self binding];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - RabbitMQ Method
- (void)binding
{
    // Opening socket
//    conn = amqp_new_connection();
//    sockfd = amqp_open_socket(hostname, port);
    
//    // is the Service OK?
//    if (sockfd < 0) {
////        printf("connect is error!");
//        NSLog(@"Connect Service is Error!");
//        return;
//    }
//    
//    // Logging in
//    amqp_set_sockfd(conn, sockfd);
//    amqp_login(conn, "/", 0, 131072, 0, AMQP_SASL_METHOD_PLAIN, userName, password);
//    
//    // Opening channel
//    amqp_channel_open(conn, 1);
//    amqp_get_rpc_reply(conn);
//    
//    // declare Exchange
//    amqp_exchange_declare(conn, 1, amqp_cstring_bytes(exchange), amqp_cstring_bytes("fanout"),
//                          0, 0, amqp_empty_table);
//    
//    // declare Queue
//    amqp_queue_declare_ok_t *r = amqp_queue_declare(conn, 1, amqp_cstring_bytes(queue), 0, 0, 0, 1,amqp_empty_table);
//    
//    // Declaring queue
//    queuename = amqp_bytes_malloc_dup(r->queue);
//    if (queuename.bytes == NULL) {
//        fprintf(stderr, "Out of memory while copying queue name");
//        
//    }
//    
//    // binding queue
//    amqp_table_t amqp_empty_table;
//    amqp_queue_bind(conn, 1,
//                    queuename,
//                    amqp_cstring_bytes(exchange),
//                    amqp_cstring_bytes(bindingkey),
//                    amqp_empty_table);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
