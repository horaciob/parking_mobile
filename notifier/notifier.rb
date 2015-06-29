#!/usr/bin/env ruby
require "typhoeus"
require "time"
require 'json'

URL =  "http://localhost:3000"
timestamp=(Time.now+3*60*60).strftime("%Y%m%d%H%M")
parkings=JSON.parse(Typhoeus.get("#{URL}/parkings?expires=#{timestamp}&status=allowed").body)

parkings.each do |p|
  puts p["id"].to_s
  Typhoeus.put("http://localhost:3000/parkings/#{p["id"]}",
               headers: {'Content-Type'=> "application/json"},
               body: '{"status":"expired"}'
              )
end
