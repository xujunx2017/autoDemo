#!/usr/bin/env python3
"""
测试JSON格式化工具的转义处理功能
"""
import json
import requests

def test_json_formatter():
    # 测试数据 - 你提供的JSON格式
    test_data = {
        "flag": "S",
        "msg": "",
        "results": '{"data":[{"applNo":"JT2021082500001655","contractNo":"6139960132789870593","crApplNo":"AP6139925215271981056","custName":"周测试呀","custNameEncryptx":"4|NGCsu2KZKKH1JVO/iDSyuA==","custNo":"CT6139925213371961344","dateCreated":1629873870000,"dateDraw":1629874069000,"dateFinished":1629874492000,"drawAmt":2000.00,"drawChannel":"APK_CH_001_IOS","drawTerm":"1","idNo":"420901198408041229","idNoEncryptx":"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=","idType":"1","mobileNo":"17880490556","mobileNoEncryptx":"4|U6uZzD23Howks93CqDNOwA==","origState":"PS","partnerCode":"360LOAN","productCode":"360JIETIAO","refApplNo":"LP6149343723110039552","rejectReasonCode1":"","rejectReasonCode2":"","rejectReasonCode3":"","requestNo":"LP6149343723110039552","riskLevel":"","state":"PS","userNo":"UR6139925138080010241"},{"applNo":"JT2021082500004503","contractNo":"6139960132789870593","crApplNo":"AP6139925215271981056","custName":"周测试呀","custNameEncryptx":"4|NGCsu2KZKKH1JVO/iDSyuA==","custNo":"CT6139925213371961344","dateCreated":1629875215000,"dateDraw":1629875410000,"dateFinished":1629875436000,"drawAmt":2000.00,"drawChannel":"APK_CH_001_IOS","drawTerm":"1","idNo":"420901198408041229","idNoEncryptx":"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=","idType":"1","mobileNo":"17880490556","mobileNoEncryptx":"4|U6uZzD23Howks93CqDNOwA==","origState":"PS","partnerCode":"360LOAN","productCode":"360JIETIAO","refApplNo":"LP6149349324254916609","rejectReasonCode1":"","rejectReasonCode2":"","rejectReasonCode3":"","requestNo":"LP6149349324254916609","riskLevel":"","state":"PS","userNo":"UR6139925138080010241"}],"flag":"S"}'
    }
    
    print("原始测试数据:")
    print(json.dumps(test_data, indent=2, ensure_ascii=False))
    
    # 模拟自动去除转义的过程
    print("\n" + "="*50)
    print("开始自动去除转义处理...")
    
    try:
        # 处理results字段中的转义JSON
        if 'results' in test_data and isinstance(test_data['results'], str):
            # 第一步：处理转义字符
            escaped_str = test_data['results']
            print(f"\n1. 原始转义字符串长度: {len(escaped_str)}")
            
            # 处理转义字符
            unescaped = escaped_str
            unescaped = unescaped.replace('\\"', '"')
            unescaped = unescaped.replace('\\\\', '\\')
            unescaped = unescaped.replace('\\n', '\n')
            unescaped = unescaped.replace('\\t', '\t')
            unescaped = unescaped.replace('\\r', '\r')
            
            print(f"2. 转义处理完成，长度: {len(unescaped)}")
            
            # 解析JSON
            parsed = json.loads(unescaped)
            print(f"3. JSON解析成功，包含 {len(parsed.get('data', []))} 条数据")
            
            # 格式化输出
            formatted = json.dumps(parsed, indent=2, ensure_ascii=False)
            print("\n4. 最终格式化结果:")
            print(formatted)
            
            return True
            
    except Exception as e:
        print(f"处理失败: {e}")
        return False

if __name__ == "__main__":
    success = test_json_formatter()
    if success:
        print("\n✅ JSON转义处理测试成功！")
    else:
        print("\n❌ JSON转义处理测试失败！")