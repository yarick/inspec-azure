# frozen_string_literal: true

require 'azurerm_resource'

class AzurermNetworkWatchers < AzurermPluralResource
  name 'azurerm_network_watchers'
  desc 'Verifies settings for Network Watchers'
  example <<-EXAMPLE
    azurerm_network_watchers(resource_group: 'example') do
      it{ should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:names, field: 'name')
             .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group:)
    resp = client.network_watchers(resource_group)
    return if resp.nil? || (resp.is_a?(Hash) && resp.key?('error'))

    @table = resp
  end

  def to_s
    'Network Watchers'
  end
end
