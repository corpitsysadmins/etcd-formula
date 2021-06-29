
{% from "etcd/map.jinja" import etcd with context -%}

etcd-install:
  pkg.installed:
    - pkgs: {{ etcd.pkgs }}

etcd_service_running:
  service.running:
    - name: {{ etcd.service_name }}
    - enable: {{ etcd.service_enabled }}
    - require:
      - etcd-install
    - watch:
      - etcd-install
