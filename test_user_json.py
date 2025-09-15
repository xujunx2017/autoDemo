#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试用户提供的特殊JSON格式
"""
import json

def test_user_json():
    # 用户提供的JSON数据
    test_data = '''{ 
	 "flag": "S", 
	 "msg": "", 
	 "results": "{\\"data\\":[{\\"applNo\\":\\"JT2021082500001655\\",\\"contractNo\\":\\"6139960132789870593\\",\\"crApplNo\\":\\"AP6139925215271981056\\",\\"custName\\":\\"周测试呀\\",\\"custNameEncryptx\\":\\"4|NGCsu2KZKKH1JVO/iDSyuA==\\",\\"custNo\\":\\"CT6139925213371961344\\",\\"dateCreated\\":1629873870000,\\"dateDraw\\":1629874069000,\\"dateFinished\\":1629874492000,\\"drawAmt\\":2000.00,\\"drawChannel\\":\\"APK_CH_001_IOS\\",\\"drawTerm\\":\\"1\\",\\"idNo\\":\\"420901198408041229\\",\\"idNoEncryptx\\":\\"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=\\",\\"idType\\":\\"1\\",\\"mobileNo\\":\\"17880490556\\",\\"mobileNoEncryptx\\":\\"4|U6uZzD23Howks93CqDNOwA==\\",\\"origState\\":\\"PS\\",\\"partnerCode\\":\\"360LOAN\\",\\"productCode\\":\\"360JIETIAO\\",\\"refApplNo\\":\\"LP6149343723110039552\\",\\"rejectReasonCode1\\":\\"\\",\\"rejectReasonCode2\\":\\"\\",\\"rejectReasonCode3\\":\\"\\",\\"requestNo\\":\\"LP6149343723110039552\\",\\"riskLevel\\":\\"\\",\\"state\\":\\"PS\\",\\"userNo\\":\\"UR6139925138080010241\\"},{\\"applNo\\":\\"JT2021082500004503\\",\\"contractNo\\":\\"6139960132789870593\\",\\"crApplNo\\":\\"AP6139925215271981056\\",\\"custName\\":\\"周测试呀\\",\\"custNameEncryptx\\":\\"4|NGCsu2KZKKH1JVO/iDSyuA==\\",\\"custNo\\":\\"CT6139925213371961344\\",\\"dateCreated\\":1629875215000,\\"dateDraw\\":1629875410000,\\"dateFinished\\":1629875436000,\\"drawAmt\\":2000.00,\\"drawChannel\\":\\"APK_CH_001_IOS\\",\\"drawTerm\\":\\"1\\",\\"idNo\\":\\"420901198408041229\\",\\"idNoEncryptx\\":\\"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=\\",\\"idType\\":\\"1\\",\\"mobileNo\\":\\"17880490556\\",\\"mobileNoEncryptx\\":\\"4|U6uZzD23Howks93CqDNOwA==\\",\\"origState\\":\\"PS\\",\\"partnerCode\\":\\"360LOAN\\",\\"productCode\\":\\"360JIETIAO\\",\\"refApplNo\\":\\"LP6149349324254916609\\",\\"rejectReasonCode1\\":\\"\\",\\"rejectReasonCode2\\":\\"\\",\\"rejectReasonCode3\\":\\"\\",\\"requestNo\\":\\"LP6149349324254916609\\",\\"riskLevel\\":\\"\\",\\"state\\":\\"PS\\",\\"userNo\\":\\"UR6139925138080010241\\"}],\\"flag\\":\\"S\\"}" 
 }'''

    try:
        print("🚀 开始处理用户提供的JSON数据...")
        
        # 步骤1: 解析第一层JSON
        parsed = json.loads(test_data)
        print("✅ 第一层JSON解析成功")
        print(f"flag: {parsed['flag']}")
        print(f"msg: {parsed['msg']}")
        
        # 步骤2: 解析嵌套的results
        nested = json.loads(parsed['results'])
        print("✅ 嵌套JSON解析成功")
        print(f"data数组长度: {len(nested['data'])}")
        print(f"嵌套flag: {nested['flag']}")
        
        # 步骤3: 重建完整结构
        final_result = {
            'flag': parsed['flag'],
            'msg': parsed['msg'], 
            'results': nested
        }
        
        # 步骤4: 验证数据
        first_record = final_result['results']['data'][0]
        print(f"\n📋 第一条记录验证:")
        print(f"applNo: {first_record['applNo']}")
        print(f"contractNo: {first_record['contractNo']}")
        print(f"custName: {first_record['custName']}")
        print(f"drawAmt: {first_record['drawAmt']}")
        
        # 步骤5: 输出最终格式化的JSON
        print("\n🎉 最终格式化结果:")
        print(json.dumps(final_result, indent=2, ensure_ascii=False))
        
        return True
        
    except Exception as e:
        print(f"❌ 处理失败: {e}")
        return False

if __name__ == "__main__":
    success = test_user_json()
    if success:
        print("\n✅ 用户JSON数据修复测试通过!")
    else:
        print("\n❌ 测试失败!")