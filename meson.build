project('com.github.redoC-A2k.vtodo','vala','c')

executable(
  meson.project_name(),
  'src'/'widgets'/'calendar.vala',
  'src'/'widgets'/'day_in_cal.vala',
  'src'/'window.vala',
  'src'/'main.vala',
  'src'/'builder.vala',
  dependencies:[
    dependency('gtk+-3.0')
  ],
  install:false,
  link_args : '-C'
)

