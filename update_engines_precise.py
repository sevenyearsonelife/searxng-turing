import yaml
import sys

# The engines to enable (name and engine fields must match these)
enabled_engines = [
    "google",
    "duckduckgo",
    "brave",
    "360search",
    "baidu",
    "quark"
]

settings_file = 'searxng/settings.yml'

try:
    with open(settings_file, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)
except FileNotFoundError:
    print(f"Error: '{settings_file}' not found.")
    sys.exit(1)
except yaml.YAMLError as e:
    print(f"Error parsing YAML file: {e}")
    sys.exit(1)

if 'engines' in data and isinstance(data['engines'], list):
    for engine_config in data['engines']:
        is_enabled = False
        if 'name' in engine_config and 'engine' in engine_config:
            engine_name = engine_config.get('name', '').lower()
            engine_engine = engine_config.get('engine', '').lower()
            if engine_name in enabled_engines and engine_engine in enabled_engines:
                 is_enabled = True
        
        if is_enabled:
            engine_config['disabled'] = False
        else:
            engine_config['disabled'] = True


with open(settings_file, 'w', encoding='utf-8') as f:
    yaml.dump(data, f, allow_unicode=True, sort_keys=False, indent=2, default_flow_style=False)

print(f"'{settings_file}' has been updated successfully.")