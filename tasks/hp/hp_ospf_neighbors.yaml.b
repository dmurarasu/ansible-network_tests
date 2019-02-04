---

- ios_command:
    commands:
      - display ospf peer
  register: output

- name: parse the data
  command_parser:
    file: "{{ role_path }}/parsers/hp_ospf_neighbors.yaml"
    content: "{{output.stdout[0]}}"

- name: display data
  debug: var=my_ospf_neighbors

### for future use when config is managed by ansible or expected data is added
#- name: check ip int status is as defined
#  assert:
#    that: >
#      item.admin_state == ip_interface_facts[item.name].admin_state and
#      item.ip.address.ipv4_address|ipaddr('address')  == ip_interface_facts[item.name].ip
#    msg: "IP tests failed"
#  debug:
#    msg: "{{item.name}}"
#  loop: "{{ interfaces | net_int_filter }}"
#  when: >
#    item.ip is defined and
#    ip_interface_facts[item.name] is defined
