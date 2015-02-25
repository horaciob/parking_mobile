class TrafficApi < Sinatra::Application
  get "/parkings/:id" do |id|
     if id.to_i > 0
        ret = Parkings.find(:id => :id)
     else
        ret = Parkings.find(:lic_plate => :id)
     end
     ret.to_json
  end

  post "/parkings" do
      ret=Parkings.insert(params)
      ret.to_json
  end
end
