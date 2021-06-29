
{% from "etcd/map.jinja" import etcd with context -%}
{% from "etcd/config.jinja" import config_data with context -%}

{{ etcd.config_file }}:
  file.managed:
    - source: salt://etcd/generic-etcd.config.jinja
    - template: jinja
    - context:
      content: {{ config_data }}
    - mode: 644
    - user: root
    - group: root