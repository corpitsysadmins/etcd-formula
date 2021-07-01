
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
    - group: {{ etcd.posix_group }}

{% if (etcd.certs is defined) and etcd.certs|length -%}
{%- for cert_file_name, cert_content in etcd.certs|dictsort %}

{{ cert_file_name }}:
  file.managed:
    - contents: |
        {{ cert_content | indent(8) }}
    - mode: 640
    - user: root
    - group: {{ etcd.posix_group }}
    - require_in:
      - file: {{ etcd.config_file }}

{%- endfor %}
{%- endif %}

etcd_service_running:
  service.running:
    - name: {{ etcd.service_name }}
    - enable: {{ etcd.service_enabled }}
    - require:
      - {{ etcd.config_file }}
    - watch:
      - {{ etcd.config_file }}
