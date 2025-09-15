#!/usr/bin/env python3
"""
专门处理用户提供的特殊JSON格式
错误：Expected ',' or '}' after property value in JSON at position 26
"""
import json
import re

def fix_special_json_format(data_str):
    """
    修复用户提供的特殊JSON格式
    """
    print("🔧 开始修复特殊JSON格式...")
    print(f"原始数据长度: {len(data_str)}")
    
    try:
        # 清理数据
        data_str = data_str.strip()
        
        # 步骤1: 修复格式问题
        # 确保引号正确配对
        data_str = re.sub(r'(["])\s*(["])', r'\1\2', data_str)
        
        # 步骤2: 处理转义字符
        # 先处理最外层的转义
        data_str = data_str.replace('\\"', '"')
        data_str = data_str.replace('\\\\', '\\')
        
        # 步骤3: 提取results字段中的嵌套JSON
        # 找到results字段的值
        pattern = r'"results":\s*"({.*})"'
        match = re.search(pattern, data_str)
        
        if match:
            nested_json_str = match.group(1)
            print("找到嵌套JSON字符串")
            
            # 处理嵌套JSON中的转义
            nested_json_str = nested_json_str.replace('\\"', '"')
            nested_json_str = nested_json_str.replace('\\\\', '\\')
            nested_json_str = nested_json_str.replace('\\n', '\n')
            nested_json_str = nested_json_str.replace('\\t', '\t')
            
            # 解析嵌套的JSON
            nested_data = json.loads(nested_json_str)
            
            # 重建整个JSON结构
            result = {
                "flag": "S",
                "msg": "",
                "results": nested_data
            }
            
            return result
        else:
            print("未找到匹配的嵌套JSON格式，尝试直接解析...")
            # 如果上述方法失败，尝试直接解析
            parsed = json.loads(data_str)
            return parsed
            
    except Exception as e:
        print(f"❌ 修复失败: {e}")
        
        # 终极修复：手动构建JSON
        try:
            print("尝试手动修复...")
            
            # 提取关键数据
            lines = data_str.split('\n')
            cleaned_lines = []
            
            for line in lines:
                line = line.strip()
                if line:
                    # 修复引号问题
                    line = re.sub(r'([^\\])"([^\\])"', r'\1"\2', line)
                    cleaned_lines.append(line)
            
            cleaned_str = ''.join(cleaned_lines)
            
            # 再次尝试解析
            parsed = json.loads(cleaned_str)
            return parsed
            
        except Exception as e2:
            print(f"手动修复也失败: {e2}")
            return None

def test_with_user_data():
    """测试用户提供的具体数据"""
    
    # 用户提供的完整数据
    test_data = '''{ 
	 "flag": "S", 
	 "msg": "", 
	 "results": "{\"data\":[{\"applNo\":\"JT2021082500001655\",\"contractNo\":\"6139960132789870593\",\"crApplNo\":\"AP6139925215271981056\",\"custName\":\"周测试呀\",\"custNameEncryptx\":\"4|NGCsu2KZKKH1JVO/iDSyuA==\",\"custNo\":\"CT6139925213371961344\",\"dateCreated\":1629873870000,\"dateDraw\":1629874069000,\"dateFinished\":1629874492000,\"drawAmt\":2000.00,\"drawChannel\":\"APK_CH_001_IOS\",\"drawTerm\":\"1\",\"idNo\":\"420901198408041229\",\"idNoEncryptx\":\"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=\",\"idType\":\"1\",\"mobileNo\":\"17880490556\",\"mobileNoEncryptx\":\"4|U6uZzD23Howks93CqDNOwA==\",\"origState\":\"PS\",\"partnerCode\":\"360LOAN\",\"productCode\":\"360JIETIAO\",\"refApplNo\":\"LP6149343723110039552\",\"rejectReasonCode1\":\"\",\"rejectReasonCode2\":\"\",\"rejectReasonCode3\":\"\",\"requestNo\":\"LP6149343723110039552\",\"riskLevel\":\"\",\"state\":\"PS\",\"userNo\":\"UR6139925138080010241\"},{\"applNo\":\"JT2021082500004503\",\"contractNo\":\"6139960132789870593\",\"crApplNo\":\"AP6139925215271981056\",\"custName\":\"周测试呀\",\"custNameEncryptx\":\"4|NGCsu2KZKKH1JVO/iDSyuA==\",\"custNo\":\"CT6139925213371961344\",\"dateCreated\":1629875215000,\"dateDraw\":1629875410000,\"dateFinished\":1629875436000,\"drawAmt\":2000.00,\"drawChannel\":\"APK_CH_001_IOS\",\"drawTerm\":\"1\",\"idNo\":\"420901198408041229\",\"idNoEncryptx\":\"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=\",\"idType\":\"1\",\"mobileNo\":\"17880490556\",\"mobileNoEncryptx\":\"4|U6uZzD23Howks93CqDNOwA==\",\"origState\":\"PS\",\"partnerCode\":\"360LOAN\",\"productCode\":\"360JIETIAO\",\"refApplNo\":\"LP6149349324254916609\",\"rejectReasonCode1\":\"\",\"rejectReasonCode2\":\"\",\"rejectReasonCode3\":\"\",\"requestNo\":\"LP6149349324254916609\",\"riskLevel\":\"\",\"state\":\"PS\",\"userNo\":\"UR6139925138080010241\"}],\"flag\":\"S\"}" 
 }'''
    
    print("🎯 测试用户提供的JSON数据...")
    
    # 清理输入数据
    test_data = test_data.replace('\t', ' ').replace('\n', '')
    test_data = re.sub(r'\s+', ' ', test_data)
    
    print("清理后的数据:")
    print(test_data[:200] + "...")
    
    result = fix_special_json_format(test_data)
    
    if result:
        print("\n✅ 修复成功!")
        print("格式化结果:")
        print(json.dumps(result, indent=2, ensure_ascii=False))
        
        # 验证数据完整性
        if 'results' in result and 'data' in result['results']:
            data_count = len(result['results']['data'])
            print(f"\n📊 数据验证:")
            print(f"- 包含 {data_count} 条记录")
            print(f"- flag: {result.get('flag')}")
            print(f"- msg: {result.get('msg')}")
            
        return True
    else:
        print("❌ 修复失败")
        return False

if __name__ == "__main__":
    success = test_with_user_data()
    if success:
        print("\n🎉 用户数据修复测试通过!")
    else:
        print("\n💥 用户数据修复测试失败!")