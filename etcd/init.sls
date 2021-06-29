# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "etcd/map.jinja" import etcd with context -%}

include:
  - etcd.install
  {%- if etcd.config is defined %}
  - etcd.conf
  {%- endif %}
