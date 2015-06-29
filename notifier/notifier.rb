#!/usr/bin/env ruby
require 'typhoeus'
require 'time'
require 'json'
require 'logger'

log = Logger.new('/tmp/logger.log',7,50000)
URL = 'http://localhost:3000'
puts log.info Time.now.to_i.to_s

timestamp=(Time.now.utc).strftime("%Y%m%d%H%M")
parkings=JSON.parse(Typhoeus.get("#{URL}/parkings?expires=#{timestamp}&status=allowed").body)

parkings.each do |p|
  log.info "parking id: #{p['id']}   expires_at: #{p['expires_at']}"
  Typhoeus.put("http://localhost:3000/parkings/#{p["id"]}",
               headers: {'Content-Type'=> "application/json"},
               body: '{"status":"expired"}'
              )
end

