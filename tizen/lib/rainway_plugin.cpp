#include <flutter/plugin_registrar.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <memory>
#include <string>
#include <dlog.h>
#include <map>

namespace {

class RainwayPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrar *registrar) {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
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
  bool is_streaming_ = false;
  std::string api_key_;

  bool ValidateApiKey(const flutter::MethodCall<flutter::EncodableValue> &method_call,
                     std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> &result) {
    const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    if (!arguments) {
      result->Error("Invalid arguments", "API key is required");
      return false;
    }

    auto api_key = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
    if (api_key.empty()) {
      result->Error("Invalid API key", "API key cannot be empty");
      return false;
    }

    api_key_ = api_key;
    return true;
  }

  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
    if (method_call.method_name().compare("initialize") == 0) {
      // Initialize Rainway with API key
      if (!ValidateApiKey(method_call, result)) {
        return;
      }
      dlog_print(DLOG_INFO, "RainwayPlugin", "Initializing Rainway with API key");
      result->Success();
    } else if (method_call.method_name().compare("connect") == 0) {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto serverUrl = std::get<std::string>(arguments->at(flutter::EncodableValue("serverUrl")));
        auto apiKey = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        
        if (apiKey != api_key_) {
          result->Error("Authentication failed", "Invalid API key");
          return;
        }

        dlog_print(DLOG_INFO, "RainwayPlugin", "Connecting to server: %s", serverUrl.c_str());
        // Implement connection logic here with API key authentication
        result->Success();
      } else {
        result->Error("Invalid arguments", "Server URL and API key are required");
      }
    } else if (method_call.method_name().compare("startStreaming") == 0) {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto gameId = std::get<std::string>(arguments->at(flutter::EncodableValue("gameId")));
        auto apiKey = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        
        if (apiKey != api_key_) {
          result->Error("Authentication failed", "Invalid API key");
          return;
        }

        dlog_print(DLOG_INFO, "RainwayPlugin", "Starting streaming for game: %s", gameId.c_str());
        is_streaming_ = true;
        // Implement streaming logic here with API key authentication
        result->Success();
      } else {
        result->Error("Invalid arguments", "Game ID and API key are required");
      }
    } else if (method_call.method_name().compare("stopStreaming") == 0) {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto apiKey = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        
        if (apiKey != api_key_) {
          result->Error("Authentication failed", "Invalid API key");
          return;
        }

        dlog_print(DLOG_INFO, "RainwayPlugin", "Stopping streaming");
        is_streaming_ = false;
        // Implement stop streaming logic here with API key authentication
        result->Success();
      } else {
        result->Error("Invalid arguments", "API key is required");
      }
    } else if (method_call.method_name().compare("sendInput") == 0) {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto apiKey = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        
        if (apiKey != api_key_) {
          result->Error("Authentication failed", "Invalid API key");
          return;
        }

        // Handle input events
        dlog_print(DLOG_INFO, "RainwayPlugin", "Sending input event");
        // Implement input handling logic here with API key authentication
        result->Success();
      } else {
        result->Error("Invalid arguments", "Input data and API key are required");
      }
    } else if (method_call.method_name().compare("isStreaming") == 0) {
      const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (arguments) {
        auto apiKey = std::get<std::string>(arguments->at(flutter::EncodableValue("apiKey")));
        
        if (apiKey != api_key_) {
          result->Error("Authentication failed", "Invalid API key");
          return;
        }

        result->Success(flutter::EncodableValue(is_streaming_));
      } else {
        result->Error("Invalid arguments", "API key is required");
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