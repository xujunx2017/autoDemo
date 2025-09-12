# JSON数据比对工具 - autoDemo

这是一个基于Django的JSON数据比对工具，提供前后端完整解决方案。

## 功能特性

- ✅ 用户登录系统：支持用户 xujun/123456 登录
- ✅ 控制台界面：登录后显示左侧工具标签栏
- ✅ JSON数据比对：可视化比较两个 JSON 数据的差异
- ✅ JSON格式化：美化和验证 JSON 数据格式
- ✅ JSON验证：验证 JSON 数据的有效性并分析结构
- ✅ 响应式界面：适配不同设备屏幕
- ✅ 差异可视化：清晰展示 JSON 数据间的差异
- ✅ 标签栏导航：左侧持续维护递增的工具标签栏
- ✅ 默认工具：登录后默认显示 JSON 数据比对工具

## 项目结构

```
autoDemo/
├── autoDemo/           # Django项目配置
│   ├── settings.py     # 项目设置
│   ├── urls.py        # URL路由配置
│   └── ...
├── jsoncompare/        # 主应用
│   ├── views.py       # 视图函数
│   ├── models.py      # 数据模型
│   └── ...
├── templates/         # HTML模板
│   ├── login.html     # 登录页面
│   └── json_compare.html  # JSON比对页面
├── static/           # 静态文件
├── manage.py         # Django管理脚本
└── create_superuser.py  # 创建超级用户脚本
```

## 安装和启动

### 1. 安装依赖
确保已安装Python 3.8+和Django 5.2+：

```bash
pip install django
```

### 2. 数据库迁移
```bash
python manage.py migrate
```

### 3. 创建超级用户（可选）
```bash
python create_superuser.py
```
管理员账号：admin/admin123

### 4. 启动服务器
```bash
python manage.py runserver 0.0.0.0:8000
```

### 5. 访问应用
- 主应用：http://localhost:8000/
- 管理后台：http://localhost:8000/admin/

## 使用说明

### 登录
1. 打开 http://localhost:8000/
2. 使用以下凭据登录：
   - 用户名：xujun
   - 密码：123456

### 控制台界面
登录后显示左侧工具标签栏，默认选中JSON数据比对工具。

### 工具切换
点击左侧标签栏切换不同工具（JSON比对、格式化、验证）。

### JSON比对
1. 在"JSON比对"标签页中，左侧和右侧分别输入需要比对的JSON数据
2. 点击"格式化JSON"按钮可以美化JSON格式
3. 点击"开始比对"按钮查看差异
4. 差异会以不同颜色标识：
   - 黄色：第一个JSON缺失的字段
   - 蓝色：第二个JSON缺失的字段
   - 红色：数值或类型不匹配
   - 绿色：数组长度不一致

### 示例数据
系统提供了示例JSON数据，可以直接用于测试：

**JSON 1：**
```json
{
  "name": "张三",
  "age": 25,
  "address": {
    "city": "北京",
    "street": "朝阳路"
  },
  "hobbies": ["读书", "游泳"]
}
```

**JSON 2：**
```json
{
  "name": "李四",
  "age": 25,
  "address": {
    "city": "上海",
    "street": "南京路"
  },
  "hobbies": ["读书", "游泳", "跑步"],
  "phone": "13800138000"
}
```

## API接口

### POST /api/compare-json/
比较两个JSON数据的差异

**请求格式：**
```json
{
  "json1": "{...}",
  "json2": "{...}"
}
```

**响应格式：**
```json
{
  "success": true,
  "result": [
    {
      "path": "name",
      "type": "value_mismatch",
      "value1": "张三",
      "value2": "李四"
    }
  ]
}
```

### 工具页面路由
- **控制台**：`/` - 登录后的主控制台
- **JSON比对**：`/tools/json-compare/` - JSON数据比对工具
- **JSON格式化**：`/tools/json-formatter/` - JSON格式化工具
- **JSON验证**：`/tools/json-validator/` - JSON验证工具

## 技术栈

- **后端：** Django 5.2, Python 3.8+
- **前端：** HTML5, CSS3, JavaScript (ES6+)
- **编辑器：** CodeMirror (代码高亮和格式化)
- **UI框架：** 原生CSS (响应式设计)

## 开发说明

项目使用Django的标准结构，主要逻辑在：
- `jsoncompare/views.py` - 包含所有视图和API逻辑
- `templates/` - 前端模板文件
- `autoDemo/settings.py` - Django配置

## 注意事项

- 这是一个开发环境，请勿用于生产
- 默认SQLite数据库，如需使用其他数据库请修改settings.py
- 静态文件服务在开发模式下已配置，生产环境需要额外配置

## 许可证

MIT License