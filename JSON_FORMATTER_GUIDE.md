# JSON格式化工具使用指南

## 🎯 问题已解决

✅ **已修复的问题：**
- `saveUserInput is not defined` 错误已修复
- 自动去除转义功能已增强
- 支持处理复杂的嵌套JSON转义数据

## 🚀 使用方法

### 1. 访问工具
打开浏览器访问：
```
http://localhost:8000/tools/json-formatter/
```

### 2. 处理转义JSON数据

#### 对于你的数据格式：
```json
{
  "flag": "S",
  "msg": "",
  "results": "{\"data\":[...]}"
}
```

#### 操作步骤：
1. **复制** 你的完整JSON数据到输入框
2. **点击** "自动去除转义" 按钮
3. **查看** 格式化后的结果

### 3. 功能说明

| 按钮 | 功能 |
|------|------|
| **格式化** | 美化JSON格式 |
| **压缩** | 压缩成单行JSON |
| **转义** | 添加转义字符 |
| **自动去除转义** | 🔥 **核心功能** - 自动处理嵌套转义 |
| **清空** | 清空所有内容 |
| **复制当前内容** | 复制结果到剪贴板 |

## 📋 测试数据示例

你可以使用以下测试数据验证功能：

```json
{"flag":"S","msg":"","results":"{\"data\":[{\"applNo\":\"JT2021082500001655\",\"contractNo\":\"6139960132789870593\",\"crApplNo\":\"AP6139925215271981056\",\"custName\":\"周测试呀\",\"custNameEncryptx\":\"4|NGCsu2KZKKH1JVO/iDSyuA==\",\"custNo\":\"CT6139925213371961344\",\"dateCreated\":1629873870000,\"dateDraw\":1629874069000,\"dateFinished\":1629874492000,\"drawAmt\":2000.00,\"drawChannel\":\"APK_CH_001_IOS\",\"drawTerm\":\"1\",\"idNo\":\"420901198408041229\",\"idNoEncryptx\":\"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=\",\"idType\":\"1\",\"mobileNo\":\"17880490556\",\"mobileNoEncryptx\":\"4|U6uZzD23Howks93CqDNOwA==\",\"origState\":\"PS\",\"partnerCode\":\"360LOAN\",\"productCode\":\"360JIETIAO\",\"refApplNo\":\"LP6149343723110039552\",\"rejectReasonCode1\":\"\",\"rejectReasonCode2\":\"\",\"rejectReasonCode3\":\"\",\"requestNo\":\"LP6149343723110039552\",\"riskLevel\":\"\",\"state\":\"PS\",\"userNo\":\"UR6139925138080010241\"},{\"applNo\":\"JT2021082500004503\",\"contractNo\":\"6139960132789870593\",\"crApplNo\":\"AP6139925215271981056\",\"custName\":\"周测试呀\",\"custNameEncryptx\":\"4|NGCsu2KZKKH1JVO/iDSyuA==\",\"custNo\":\"CT6139925213371961344\",\"dateCreated\":1629875215000,\"dateDraw\":1629875410000,\"dateFinished\":1629875436000,\"drawAmt\":2000.00,\"drawChannel\":\"APK_CH_001_IOS\",\"drawTerm\":\"1\",\"idNo\":\"420901198408041229\",\"idNoEncryptx\":\"4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=\",\"idType\":\"1\",\"mobileNo\":\"17880490556\",\"mobileNoEncryptx\":\"4|U6uZzD23Howks93CqDNOwA==\",\"origState\":\"PS\",\"partnerCode\":\"360LOAN\",\"productCode\":\"360JIETIAO\",\"refApplNo\":\"LP6149349324254916609\",\"rejectReasonCode1\":\"\",\"rejectReasonCode2\":\"\",\"rejectReasonCode3\":\"\",\"requestNo\":\"LP6149349324254916609\",\"riskLevel\":\"\",\"state\":\"PS\",\"userNo\":\"UR6139925138080010241\"}],\"flag\":\"S\"}"}"}
```

## ✅ 预期结果

处理后的数据将显示为：

```json
{
  "flag": "S",
  "msg": "",
  "results": {
    "data": [
      {
        "applNo": "JT2021082500001655",
        "contractNo": "6139960132789870593",
        "crApplNo": "AP6139925215271981056",
        "custName": "周测试呀",
        "custNameEncryptx": "4|NGCsu2KZKKH1JVO/iDSyuA==",
        "custNo": "CT6139925213371961344",
        "dateCreated": 1629873870000,
        "dateDraw": 1629874069000,
        "dateFinished": 1629874492000,
        "drawAmt": 2000.00,
        "drawChannel": "APK_CH_001_IOS",
        "drawTerm": "1",
        "idNo": "420901198408041229",
        "idNoEncryptx": "4|yrlHzYmheEPmAgm5KS89L2RjOfLSYiOii3U8nX49HEA=",
        "idType": "1",
        "mobileNo": "17880490556",
        "mobileNoEncryptx": "4|U6uZzD23Howks93CqDNOwA==",
        "origState": "PS",
        "partnerCode": "360LOAN",
        "productCode": "360JIETIAO",
        "refApplNo": "LP6149343723110039552",
        "rejectReasonCode1": "",
        "rejectReasonCode2": "",
        "rejectReasonCode3": "",
        "requestNo": "LP6149343723110039552",
        "riskLevel": "",
        "state": "PS",
        "userNo": "UR6139925138080010241"
      },
      {
        "applNo": "JT2021082500004503",
        ...
      }
    ],
    "flag": "S"
  }
}
```

## 🔍 故障排除

如果遇到问题：

1. **确保服务已启动**：检查 `python manage.py runserver` 是否运行
2. **清除浏览器缓存**：刷新页面或清除缓存
3. **检查数据格式**：确保数据是完整的JSON格式
4. **使用测试数据**：先用提供的测试数据验证功能

## 📞 技术支持

如仍有问题，请检查：
- 浏览器控制台错误信息
- 服务器端日志
- 数据完整性