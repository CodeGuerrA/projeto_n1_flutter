import os, sys, re

root = os.path.dirname(__file__)
checks = {
    'Onboarding screen': 'lib/screens/onboarding/onboarding_screen.dart',
    'Splash screen': 'lib/screens/onboarding/splash_screen.dart',
    'Register screen': 'lib/screens/auth/register_screen.dart',
    'Login screen': 'lib/screens/auth/login_screen.dart',
    'Recovery screen': 'lib/screens/auth/recovery_screen.dart',
    'Tasks list': 'lib/screens/tasks/tasks_list_screen.dart',
    'Task form': 'lib/screens/tasks/task_form_screen.dart',
    'Subtasks': 'lib/screens/tasks/subtasks_screen.dart',
    'Categories list': 'lib/screens/categories/categories_list_screen.dart',
    'Category form': 'lib/screens/categories/category_form_screen.dart',
    'AuthService': 'lib/services/auth_service.dart',
    'DataService': 'lib/services/data_service.dart',
    'AppPrefs': 'lib/services/app_prefs.dart',
}

print('Verificando presença de arquivos principais...')
ok = True
for name, path in checks.items():
    full = os.path.join(root, path)
    exists = os.path.exists(full)
    print(f"- {name:20} : {'OK' if exists else 'MISSING'} {'('+path+')' if exists else ''}")
    if not exists:
        ok = False

# quick content checks
print('\nVerificações de conteúdo (strings esperadas):')
content_checks = [
    ('Pular (skip)', 'Pular'),
    ('Avançar (next)', 'Avançar'),
    ('Senha alternativa', 'Senha alternativa'),
    ('Subtarefas', 'Subtarefas'),
    ('Icon map', 'icon_map.dart'),
]
with open(os.path.join(root, 'pubspec.yaml'), 'r', encoding='utf-8') as f:
    pub = f.read(10000) if os.path.exists(os.path.join(root, 'pubspec.yaml')) else ''

for desc, token in content_checks:
    found = False
    # search in all lib files
    for dp, ds, fs in os.walk(os.path.join(root, 'lib')):
        for fn in fs:
            fp = os.path.join(dp, fn)
            try:
                txt = open(fp,'r',encoding='utf-8',errors='ignore').read()
                if token in txt:
                    found = True
                    break
            except Exception:
                pass
        if found: break
    print(f"- {desc:20} : {'FOUND' if found else 'NOT FOUND'} (token: '{token}')")

print('\nResumo: ' + ('OK - parece cobrir os RFs básicos.' if ok else 'MISSING FILES - verifique o output acima.'))
