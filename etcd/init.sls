# -*- coding: utf-8 -*-
# vim: ft=yaml
{% from "etcd/map.jinja" import etcd with context -%}

include:
  - etcd.install
  {%- if (etcd.pkgs is not defined) or not etcd.pkgs|length %}
  - etcd.linuxenv
     {% if etcd.docker.enabled %}
  - etcd.docker.running
     {%- else %}
  - etcd.service

extend:
  etcd_{{ etcd.service_name }}_running:
    service:
      - listen:
           {% if etcd.use_upstream_repo|lower == 'homebrew' %}
        - file: etcd-install
           {% else %}
        - archive: etcd-install
           {% endif %}
      - require:
           {% if etcd.use_upstream_repo|lower == 'homebrew' %}
        - file: etcd-install
           {% else %}
        - archive: etcd-install
           {% endif %}

     {% endif %}
  {%- endif %}