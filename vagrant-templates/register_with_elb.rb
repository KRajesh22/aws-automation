#!/usr/bin/env ruby

require 'aws-sdk'
require 'dotenv'
require 'debugger'
Dotenv.load

AWS.config(access_key_id: ENV["AWS_ID"], secret_access_key: ENV["AWS_KEY"], region: 'us-west-1')
running = AWS.ec2.instances.find_all { |instance| instance.status == :running }
innocuous_instances = running.find_all { |instance| instance.tags.include?("Innocuous") }
raise "Too many instances" if innocuous_instances.count > 1

innocuous_instances.each do |ec2|
  #AWS.elb.load_balancers['Innocuous'].instances.add(ec2.id)
  ec2.associate_elastic_ip("eipalloc-6ff9f20d")
end

#innocuous_53 = AWS.route_53.hosted_zones.find {|hz| hz.name == "innocuous.me." }
#name = "innocuous-prod-#{instance_identifier}"
#innocuous_53.resource_record_sets.create(name, "A", ttl: 300, resource_records: [{}])


