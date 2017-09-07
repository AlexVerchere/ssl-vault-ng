# Creates private key file.
#
# Recipe:: private_key_file
# Cookbook:: ssl-vault
# Author:: Greg Albrecht <gba@onbeep.com>
# Copyright:: Copyright 2014 OnBeep, Inc.
# License:: The MIT License (MIT)
# Source:: https://github.com/onbeep-cookbooks/ssl-vault
#


include_recipe 'chef-vault'
include_recipe 'ssl-vault-ng::private_key_directory'


node['ssl-vault']['certificates'].each do |cert_name, info|
    clean_name = cert_name.gsub(
    node['ssl-vault']['data_bag_key_rex'],
    node['ssl-vault']['data_bag_key_replacement_str']
    )
    vault_item = chef_vault_item('ssl-vault', clean_name)

    private_key = if info && info['private_key_file']
        File.join(
        node['ssl-vault']['private_key_directory'],
        info['private_key_file']
        )
    else
        File.join(
        node['ssl-vault']['private_key_directory'],
        [cert_name, 'key'].join('.')
        )
    end

    file private_key do
        content vault_item['key']
        owner 'root'
        group node['ssl-vault']['cert_group']
        mode '0440'
    end
end
