#ifndef RAINWAY_PLUGIN_H_
#define RAINWAY_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _RainwayPlugin RainwayPlugin;
typedef struct {
  GObjectClass parent_class;
} RainwayPluginClass;

FLUTTER_PLUGIN_EXPORT GType rainway_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void rainway_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // RAINWAY_PLUGIN_H_ 