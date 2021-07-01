
{% from "etcd/map.jinja" import etcd with context -%}

etcd-install:
  pkg.installed:
    - pkgs: {{ etcd.pkgs }}
