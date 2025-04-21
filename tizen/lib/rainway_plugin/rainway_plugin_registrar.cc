#include <flutter/plugin_registrar.h>
#include "rainway_plugin.h"

void RainwayPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  rainway_plugin::RainwayPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrar>(registrar));
} 