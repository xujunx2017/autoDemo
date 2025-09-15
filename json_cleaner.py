#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JSON数据清洗工具
解决JSON格式化中的转义字符处理问题
"""

import json
import re
import sys
from typing import Any, Dict, List, Union

class JSONCleaner:
    """JSON数据清洗工具类"""
    
    def __init__(self):
        self.cleaning_stats = {
            'removed_escapes': 0,
            'fixed_quotes': 0,
            'cleaned_strings': 0
        }
    
    def clean_string_value(self, value: str) -> str:
        """清洗字符串值中的转义字符"""
        if not isinstance(value, str):
            return value
        
        # 记录原始长度
        original_len = len(value)
        
        # 1. 处理双反斜杠
        value = re.sub(r'\\\\', r'\\', value)
        
        # 2. 处理转义的双引号
        value = re.sub(r'\\"', '"', value)
        
        # 3. 处理转义的单引号
        value = re.sub(r"\\'", "'", value)
        
        # 4. 处理Unicode转义
        value = re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), value)
        
        # 5. 处理换行符
        value = re.sub(r'\\n', '\n', value)
        value = re.sub(r'\\r', '\r', value)
        value = re.sub(r'\\t', '\t', value)
        
        # 更新统计
        if len(value) != original_len:
            self.cleaning_stats['removed_escapes'] += 1
            self.cleaning_stats['cleaned_strings'] += 1
        
        return value
    
    def clean_json_object(self, obj: Any) -> Any:
        """递归清洗JSON对象"""
        if isinstance(obj, dict):
            return {key: self.clean_json_object(value) for key, value in obj.items()}
        elif isinstance(obj, list):
            return [self.clean_json_object(item) for item in obj]
        elif isinstance(obj, str):
            return self.clean_string_value(obj)
        else:
            return obj
    
    def clean_json_string(self, json_str: str) -> str:
        """清洗JSON字符串"""
        try:
            # 尝试解析JSON
            parsed = json.loads(json_str)
            
            # 清洗数据
            cleaned = self.clean_json_object(parsed)
            
            # 重新格式化
            return json.dumps(cleaned, ensure_ascii=False, indent=2)
            
        except json.JSONDecodeError as e:
            print(f"❌ JSON解析错误: {e}")
            return self.manual_clean_json_string(json_str)
    
    def manual_clean_json_string(self, json_str: str) -> str:
        """手动清洗JSON字符串"""
        # 移除多余的转义
        cleaned = re.sub(r'\\"', '"', json_str)
        cleaned = re.sub(r'\\\\', r'\\', cleaned)
        cleaned = re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), cleaned)
        
        try:
            parsed = json.loads(cleaned)
            return json.dumps(parsed, ensure_ascii=False, indent=2)
        except json.JSONDecodeError:
            return cleaned
    
    def process_file(self, input_file: str, output_file: str = None) -> bool:
        """处理JSON文件"""
        try:
            with open(input_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            cleaned = self.clean_json_string(content)
            
            if output_file:
                with open(output_file, 'w', encoding='utf-8') as f:
                    f.write(cleaned)
                print(f"✅ 已清洗并保存到: {output_file}")
            else:
                print(cleaned)
            
            return True
            
        except Exception as e:
            print(f"❌ 处理文件错误: {e}")
            return False
    
    def process_string(self, json_str: str) -> str:
        """处理JSON字符串"""
        return self.clean_json_string(json_str)
    
    def get_stats(self) -> Dict[str, int]:
        """获取清洗统计"""
        return self.cleaning_stats


def main():
    """主函数"""
    cleaner = JSONCleaner()
    
    # 示例数据
    sample_data = '''
    {
        "flag": "S",
        "msg": "",
        "results": "{\\"data\\":[{\\"applNo\\":\\"JT2021082500001655\\",\\"contractNo\\":\\"6139960132789870593\\"}],\\"flag\\":\\"S\\"}"
    }
    '''
    
    print("🔧 JSON数据清洗工具")
    print("=" * 50)
    
    if len(sys.argv) > 1:
        # 命令行模式
        input_file = sys.argv[1]
        output_file = sys.argv[2] if len(sys.argv) > 2 else None
        
        if cleaner.process_file(input_file, output_file):
            stats = cleaner.get_stats()
            print(f"📊 清洗统计: {stats}")
    else:
        # 交互模式
        print("📋 示例数据清洗结果:")
        cleaned = cleaner.process_string(sample_data)
        print(cleaned)
        
        print("\n📊 清洗统计:", cleaner.get_stats())


if __name__ == "__main__":
    main()