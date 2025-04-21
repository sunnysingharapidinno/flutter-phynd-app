#include <flutter/plugin_registrar.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <memory>
#include <string>
#include <dlog.h>

namespace {

class RainwayPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrar *registrar) {
    auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
        registrar->messenger(), "com.rainway.sdk",
        &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<RainwayPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result) {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  RainwayPlugin() {}

  virtual ~RainwayPlugin() {}

 private:
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
    dlog_print(DLOG_INFO, "RainwayPlugin", "Method call: %s", method_call.method_name().c_str());

    if (method_call.method_name() == "initialize") {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        dlog_print(DLOG_INFO, "RainwayPlugin", "Initializing with API key: %s", api_key.c_str());
        result->Success();
      } else {
        result->Error("Invalid arguments", "API key is required");
      }
    } else if (method_call.method_name() == "connect") {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto server_url = std::get<std::string>(arguments->at(flutter::EncodableValue("serverUrl")));
        auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        auto game_id = std::get<std::string>(arguments->at(flutter::EncodableValue("gameId")));
        auto external_id = std::get<std::string>(arguments->at(flutter::EncodableValue("externalId")));
        auto availability_zone = std::get<std::string>(arguments->at(flutter::EncodableValue("availabilityZone")));
        
        dlog_print(DLOG_INFO, "RainwayPlugin", "Connecting to server: %s", server_url.c_str());
        result->Success();
      } else {
        result->Error("Invalid arguments", "Missing required parameters");
      }
    } else if (method_call.method_name() == "startStreaming") {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto game_id = std::get<std::string>(arguments->at(flutter::EncodableValue("gameId")));
        auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        
        dlog_print(DLOG_INFO, "RainwayPlugin", "Starting streaming for game: %s", game_id.c_str());
        result->Success();
      } else {
        result->Error("Invalid arguments", "Missing required parameters");
      }
    } else if (method_call.method_name() == "stopStreaming") {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        dlog_print(DLOG_INFO, "RainwayPlugin", "Stopping streaming");
        result->Success();
      } else {
        result->Error("Invalid arguments", "Missing required parameters");
      }
    } else if (method_call.method_name() == "sendInput") {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto input = std::get<flutter::EncodableMap>(arguments->at(flutter::EncodableValue("input")));
        auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        dlog_print(DLOG_INFO, "RainwayPlugin", "Sending input");
        result->Success();
      } else {
        result->Error("Invalid arguments", "Missing required parameters");
      }
    } else if (method_call.method_name() == "isStreaming") {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        result->Success(flutter::EncodableValue(false));
      } else {
        result->Error("Invalid arguments", "Missing required parameters");
      }
    } else {
      result->NotImplemented();
    }
  }
};

}  // namespace

void RainwayPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  RainwayPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrar>(registrar));
} 