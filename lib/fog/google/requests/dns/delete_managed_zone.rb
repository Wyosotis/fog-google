module Fog
  module DNS
    class Google
      ##
      # Deletes a previously created Managed Zone.
      #
      # @see https://developers.google.com/cloud-dns/api/v1/managedZones/delete
      class Real
        def delete_managed_zone(name_or_id)
          api_method = @dns.managed_zones.delete
          parameters = {
            "project" => @project,
            "managedZone" => name_or_id
          }

          request(api_method, parameters)
        end
      end

      class Mock
        def delete_managed_zone(name_or_id)
          if data[:managed_zones].key?(name_or_id)
            data[:managed_zones].delete(name_or_id)
          elsif zone = data[:managed_zones].values.detect { |z| z["name"] = name_or_id }
            data[:managed_zones].delete(zone["id"])
          else
            raise Fog::Errors::NotFound, "The 'parameters.managedZone' resource named '#{name_or_id}' does not exist."
          end

          build_excon_response(nil)
        end
      end
    end
  end
end
