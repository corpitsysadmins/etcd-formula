
{% from "etcd/map.jinja" import etcd with context -%}
{% from "etcd/conf.jinja" import conf_data with context -%}

{{ etcd.config_file }}:
  file.managed:
    - source: salt://etcd/generic-etcd.config.jinja
    - template: jinja
    - context:
      content: {{ conf_data }}
    - mode: 644
    - user: root
    - group: root