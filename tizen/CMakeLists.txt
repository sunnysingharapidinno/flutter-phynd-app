cmake_minimum_required(VERSION 3.14)
project(phynd_app)

# Find Flutter
find_package(Flutter REQUIRED)

# Add the Rainway plugin
add_subdirectory(lib/rainway_plugin)

# Flutter-specific settings
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter/ephemeral")
include(${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cmake)

# Application-specific settings
add_executable(${PROJECT_NAME} "main.cc")
target_link_libraries(${PROJECT_NAME} PRIVATE
  flutter
  flutter_plugin_registrar
  rainway_plugin
) 