# Requisitos Funcionais - Verificação automática e manual

Este arquivo mapeia cada requisito funcional (RF) para os arquivos/funcionalidades do projeto e o resultado da verificação rápida.

**Observação:** mudanças mínimas foram aplicadas **apenas** para adicionar um atalho de navegação às *Categorias* a partir da tela de Tarefas (AppBar) para garantir que o usuário possa **ir e voltar entre as telas** facilmente.

## Mapeamento (RF -> Implementação)

1. **RF01: Tela inicial com logotipo**    Implementação: `lib/screens/onboarding/splash_screen.dart` (mostra ícone e nome do app).    Status: ✅ Presente.

2. **RF02: Telas de onboarding com informações (gerenciar tarefas, rotinas, categorias)**    Implementação: `lib/screens/onboarding/onboarding_screen.dart` (3 páginas internas).    Status: ✅ Presente.

3. **RF03: Pular onboarding a qualquer momento**    Implementação: `lib/screens/onboarding/onboarding_screen.dart` (botão "Pular").    Status: ✅ Presente.

4. **RF04: Navegar entre telas do onboarding (Avançar / Voltar)**    Implementação: `lib/screens/onboarding/onboarding_screen.dart` (PageView + Avançar/Voltar).    Status: ✅ Presente.

5. **RF05: Criação de conta (usuário e senha)**    Implementação: `lib/screens/auth/register_screen.dart` + `lib/services/auth_service.dart`.    Status: ✅ Presente (registro em memória).

6. **RF06: Login (usuário e senha)**    Implementação: `lib/screens/auth/login_screen.dart` + `lib/services/auth_service.dart`.    Status: ✅ Presente.

7. **RF07: Mensagens de erro em autenticação**    Implementação: `lib/screens/auth/login_screen.dart` (SnackBar) e validações de formulário.    Status: ✅ Presente.

8. **RF08: Recuperação de acesso via senha alternativa (caso biometria falhe)**    Implementação: `lib/screens/auth/recovery_screen.dart` e `AuthService.loginWithAlt`.    Status: ✅ Presente.

9. **RF09–RF16: Gestão de Tarefas (adicionar, data/hora, prioridade, categoria, listar, editar, excluir, subtarefas)**    Implementação: `lib/screens/tasks/*`, `lib/models/task.dart`, `lib/services/data_service.dart` (ValueNotifiers para UI).    Status: ✅ Presente (funcionalidade em memória, sem persistência externa).

10. **RF17–RF20: Categorias (criar, escolher ícone, editar, excluir)**     Implementação: `lib/screens/categories/*`, `lib/models/category.dart`, `lib/ui/icon_map.dart`.     Status: ✅ Presente.

---

## Mudanças realizadas (mínimas)
- Adicionado botão de acesso às **Categorias** na AppBar da `TasksListScreen` para permitir navegação direta entre Tarefas e Categorias (ir e voltar). Arquivo alterado: `lib/screens/tasks/tasks_list_screen.dart`.

## Scripts de verificação
- `verify_rf.py`: script simples que checa a presença dos principais arquivos/strings para confirmar implementação rápida.

---
