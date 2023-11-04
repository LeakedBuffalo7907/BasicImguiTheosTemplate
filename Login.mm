#import "System/FCUUID/UIDevice+FCUUID.h"
#include "Common/CommonCode.h"
#include "Common/Variables.h"
#include "Common/Obfuscate.h"

NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

bool MakeRequest(NSString* URL,NSString* Code, NSString* UUID) {
    __block BOOL ReturnValue = false;
    NSMutableURLRequest *s_url = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:NSENCRYPT("%@?data=%@,%@"), URL, UUID, Code]]];
    s_url.timeoutInterval = 10;
    s_url.HTTPMethod = NSENCRYPT("POST");
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:s_url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (!error && response) {
        NSString *loginstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([loginstring containsString:Code] && [loginstring containsString:UUID]) {
            if ([loginstring containsString:@"PP6fa52"]) {
                usingPaid = false;
            } else {
                usingPaid = true;
                if ([loginstring containsString:@"LL53q56s"]) { //plus
                    allowCustom = true;
                }
                if ([loginstring containsString:@"eElLaa553"]) { //ultra
                    allowExtraCustom = true;
                }
                if ([loginstring containsString:@"4DF5qS7d6f"]) {
                    shouldUsePrivate = true;
                }
            }
            [defaults setObject:CreateCypher(NSENCRYPT("yuTTsiPgDBF")) forKey:NSENCRYPT("StinkyAssFagFacePoop")];
            [defaults setObject:CreateCypher(NSENCRYPT("SAgGioSplsA")) forKey:NSENCRYPT("PoopFartNiggerAss")];
            ReturnValue = true;
        } else if (![loginstring containsString:Code] && [loginstring containsString:UUID]) { 
            Debug = "Banned";
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"You Have Been Banned" message:@"Contact Perky" preferredStyle:UIAlertControllerStyleAlert];
            [alert2 addAction:[UIAlertAction actionWithTitle:@"Discord" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://shouark.xyz/discord"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://shouark.xyz/discord"] options:@{} completionHandler:nil];
            }}]];
            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alert2 animated:YES completion:nil];
            [defaults setObject:CreateCypher(NSENCRYPT("SSsfoGGsdTs")) forKey:NSENCRYPT("StinkyAssFagFacePoop")];
            [defaults setObject:CreateCypher(NSENCRYPT("SSsfoGGsdTs")) forKey:NSENCRYPT("PoopFartNiggerAss")];
            ReturnValue = true;
        } else {
            Debug = "Bad Code";
            [defaults setObject:CreateCypher(NSENCRYPT("SShHDEhUdS")) forKey:NSENCRYPT("StinkyAssFagFacePoop")];
            [defaults setObject:CreateCypher(NSENCRYPT("SShHDEhUdS")) forKey:NSENCRYPT("PoopFartNiggerAss")];
            ReturnValue = true;
        }
    }
    if (error) { 
        Debug = "Server Problem"; 
        ReturnValue = false;
    }}];
    [dataTask resume];
    return ReturnValue;
}

void LoginInternal(NSString* Code) {
    NSString *UUID = [[UIDevice currentDevice] uuid];
    for (const std::string& CurrentServer : ServerList) {
        NSString* URL = [NSString stringWithCString:CurrentServer.c_str()];
        if (MakeRequest(URL,Code,UUID)) return;
    }
}

void Func_000035(NSString* Func0045){
    LoginInternal(Func0045);
}

