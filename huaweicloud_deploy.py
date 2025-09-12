#!/usr/bin/env python3
"""
华为云部署配置文件
"""
import os
from pathlib import Path

# 构建路径
BASE_DIR = Path(__file__).resolve().parent

# 华为云部署配置
DEPLOY_CONFIG = {
    # 应用配置
    'app_name': 'auto-demo',
    'app_version': '1.0.0',
    'app_port': 8000,
    
    # 运行时配置
    'python_version': '3.9',
    'django_settings_module': 'autoDemo.settings',
    
    # 静态文件配置
    'static_url': '/static/',
    'static_root': str(BASE_DIR / 'staticfiles'),
    
    # 数据库配置（华为云RDS MySQL示例）
    'database': {
        'engine': 'django.db.backends.mysql',
        'name': os.getenv('DB_NAME', 'autodemo'),
        'user': os.getenv('DB_USER', 'root'),
        'password': os.getenv('DB_PASSWORD', ''),
        'host': os.getenv('DB_HOST', 'localhost'),
        'port': os.getenv('DB_PORT', '3306'),
    },
    
    # 安全配置
    'allowed_hosts': ['*'],
    'debug': False,
    'secret_key': os.getenv('SECRET_KEY', 'your-secret-key-here'),
}

# 环境变量配置
def setup_environment():
    """设置华为云环境变量"""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', DEPLOY_CONFIG['django_settings_module'])
    
    # 华为云特定环境变量
    if os.getenv('HUAWEICLOUD_ENV') == 'production':
        # 生产环境配置
        DEPLOY_CONFIG['debug'] = False
        DEPLOY_CONFIG['allowed_hosts'] = [
            '.huaweicloud.com',
            '.myhuaweicloud.com',
            os.getenv('HUAWEICLOUD_APP_DOMAIN', '*')
        ]
    
    return DEPLOY_CONFIG

if __name__ == '__main__':
    config = setup_environment()
    print("华为云部署配置已加载")
    print(f"应用名称: {config['app_name']}")
    print(f"应用端口: {config['app_port']}")
    print(f"调试模式: {config['debug']}")