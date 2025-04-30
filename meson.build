project('altmngr', 'c',
  version: '0.1.0',
  default_options: [
    'b_ndebug=if-release',
    'werror=true',
    'warning_level=1'])

cc = meson.get_compiler('c')

add_project_arguments(
  ['-D_GNU_SOURCE'],
  language: 'c')

x = executable('altmngr', 'src/altmngr.c', include_directories: 'src')