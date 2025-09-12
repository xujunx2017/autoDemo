from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.clickjacking import xframe_options_exempt
import json
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        # 检查是否是预设的用户名和密码
        if username == 'xujun' and password == '123456':
            # 创建或获取用户
            try:
                user = User.objects.get(username=username)
            except ObjectDoesNotExist:
                user = User.objects.create_user(username=username, password=password)
            
            # 登录用户
            login(request, user)
            return redirect('dashboard')
        else:
            return render(request, 'login.html', {'error': '用户名或密码错误'})
    
    return render(request, 'login.html')

def logout_view(request):
    logout(request)
    return redirect('login')

@login_required
def dashboard_view(request):
    """主控制台页面，显示左侧标签栏"""
    context = {
        'tools': [
            {
                'id': 'json-compare',
                'name': 'JSON数据比对工具',
                'icon': '🔄',
                'url': '/tools/json-compare/',
                'description': '比较两个JSON数据的差异'
            },
            {
                'id': 'json-formatter',
                'name': 'JSON格式化工具',
                'icon': '✨',
                'url': '/tools/json-formatter/',
                'description': '美化和验证JSON数据格式'
            },
            {
                'id': 'json-validator',
                'name': 'JSON验证工具',
                'icon': '✅',
                'url': '/tools/json-validator/',
                'description': '验证JSON数据的有效性'
            }
        ]
    }
    return render(request, 'dashboard.html', context)

@login_required
@xframe_options_exempt
def json_compare_page(request):
    """JSON比对工具页面"""
    return render(request, 'tools/json_compare.html')

@login_required
@xframe_options_exempt
def json_formatter_page(request):
    """JSON格式化工具页面"""
    return render(request, 'tools/json_formatter.html')

@login_required
@xframe_options_exempt
def json_validator_page(request):
    """JSON验证工具页面"""
    return render(request, 'tools/json_validator.html')

@login_required
@csrf_exempt
def compare_json_api(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            json1 = data.get('json1', '')
            json2 = data.get('json2', '')
            
            # 解析JSON
            try:
                obj1 = json.loads(json1) if json1 else {}
                obj2 = json.loads(json2) if json2 else {}
            except json.JSONDecodeError as e:
                return JsonResponse({
                    'success': False,
                    'error': f'JSON格式错误: {str(e)}'
                })
            
            # 比较JSON
            result = compare_json_objects(obj1, obj2)
            
            return JsonResponse({
                'success': True,
                'result': result
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'error': str(e)
            })
    
    return JsonResponse({'success': False, 'error': '只支持POST请求'})

def compare_json_objects(obj1, obj2, path=""):
    """递归比较两个JSON对象"""
    differences = []
    
    # 获取所有键
    all_keys = set(obj1.keys()) if isinstance(obj1, dict) else set()
    if isinstance(obj2, dict):
        all_keys.update(obj2.keys())
    
    if isinstance(obj1, dict) and isinstance(obj2, dict):
        for key in all_keys:
            current_path = f"{path}.{key}" if path else key
            
            if key not in obj1:
                differences.append({
                    'path': current_path,
                    'type': 'missing_in_first',
                    'value2': obj2[key]
                })
            elif key not in obj2:
                differences.append({
                    'path': current_path,
                    'type': 'missing_in_second',
                    'value1': obj1[key]
                })
            else:
                # 递归比较子对象
                val1 = obj1[key]
                val2 = obj2[key]
                
                if type(val1) != type(val2):
                    differences.append({
                        'path': current_path,
                        'type': 'type_mismatch',
                        'value1': val1,
                        'value2': val2
                    })
                elif isinstance(val1, dict):
                    differences.extend(compare_json_objects(val1, val2, current_path))
                elif isinstance(val1, list):
                    if len(val1) != len(val2):
                        differences.append({
                            'path': current_path,
                            'type': 'list_length_mismatch',
                            'value1': len(val1),
                            'value2': len(val2)
                        })
                    else:
                        for i, (v1, v2) in enumerate(zip(val1, val2)):
                            if isinstance(v1, dict) and isinstance(v2, dict):
                                differences.extend(compare_json_objects(v1, v2, f"{current_path}[{i}]"))
                            elif v1 != v2:
                                differences.append({
                                    'path': f"{current_path}[{i}]",
                                    'type': 'value_mismatch',
                                    'value1': v1,
                                    'value2': v2
                                })
                elif val1 != val2:
                    differences.append({
                        'path': current_path,
                        'type': 'value_mismatch',
                        'value1': val1,
                        'value2': val2
                    })
    else:
        if obj1 != obj2:
            differences.append({
                'path': path,
                'type': 'value_mismatch',
                'value1': obj1,
                'value2': obj2
            })
    
    return differences
