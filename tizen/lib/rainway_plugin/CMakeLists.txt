cmake_minimum_required(VERSION 3.14)
project(rainway_plugin)

set(PLUGIN_NAME "rainway_plugin")

add_library(${PLUGIN_NAME} SHARED
  "rainway_plugin.cpp"
)

target_include_directories(${PLUGIN_NAME} PRIVATE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

target_link_libraries(${PLUGIN_NAME} PRIVATE
  flutter
  flutter_plugin_registrar
  dlog
) 