require 'sinatra'
load 'connection.rb'
path = File.dirname(__FILE__)
Dir.glob("#{path}/models/*.rb") do |rb_file|
  load(rb_file)
end
Dir.glob("#{path}/controllers/*.rb") do |rb_file|
  load(rb_file)
end

class SinatraBase < Sinatra::Base
  def self.resources controller
    get "/#{controller}/new" do
      $controllers[controller].action env, response, :create, params
    end
    get "/#{controller}/:id/edit" do
      $controllers[controller].action env, response, :edit, params
    end
    get "/#{controller}/:id/delete" do
      $controllers[controller].action env, response, :delete, params
      redirect("/#{controller}")
    end
    get "/#{controller}" do
      $controllers[controller].action env, response, :list, params
    end
    post "/#{controller}" do
      $controllers[controller].action env, response, :save, params
      redirect("/#{controller}")
    end
    post "/#{controller}/:id" do
      $controllers[controller].action env, response, :update, params
      redirect("/#{controller}")
    end
  end
  def self.resources_all c
    $controllers = c
    $controllers.each do |k, v|
      resources k
    end
  end
end
