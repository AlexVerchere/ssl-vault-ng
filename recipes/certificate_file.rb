# Creates cerificate file.
#
# Recipe:: certificate_file
# Cookbook:: ssl-vault
# Author:: Greg Albrecht <gba@onbeep.com>
# Copyright:: Copyright 2014 OnBeep, Inc.
# License:: The MIT License (MIT)
# Source:: https://github.com/onbeep-cookbooks/ssl-vault
#


include_recipe 'chef-vault'
include_recipe 'ssl-vault-ng::certificate_directory'


node['ssl-vault']['certificates'].each do |cert_name, info|
    clean_name = cert_name.gsub(
    node['ssl-vault']['data_bag_key_rex'],
    node['ssl-vault']['data_bag_key_replacement_str']
    )
    vault_item = chef_vault_item('ssl-vault', clean_name)

    certificate_file = if info["certificate_file"]
        File.join(
        node['ssl-vault']['certificate_directory'],
        info["certificate_file"]
        )
    else
        File.join(
        node['ssl-vault']['certificate_directory'],
        [cert_name, 'cert'].join('.')
        )
    end

    file certificate_file do
        content vault_item['certificate']
        owner 'root'
        group 'root'
        mode '0644'
    end
end
