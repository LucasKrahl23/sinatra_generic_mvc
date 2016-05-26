require 'sinatra'
require 'tilt'
class Controller < Sinatra::Base
  def config
    @template_cache = Tilt::Cache.new
    @clazz = Kernel.const_get(@entity_name.to_s.capitalize)
  end
  def action env, _response, _action, params
    call!(env)
    @flash = {}
    method(_action).call(params, @flash)
  end
  def render_erb file, opts={}
    opts[:locals] ||= {}
    opts[:locals][:flash] = @flash
    opts[:locals][:title] ||= nil
    opts[:locals][:entity] = @entity_name.to_s
    opts[:locals][:clazz] = @clazz
    opts[:views] = "./views"
    opts[:layout] ||= :layout
    opts_aux = opts.dup
    begin
      erb "/#{@entity_name}/#{file}.html".to_sym, opts
    rescue
      erb "/generic/#{file}.html".to_sym, opts_aux
    end
  end
  def type column
    if column.type == :string
      return "text"
    elsif column.type == :integer
      return "numeric"
    end
    return "text"
  end
  def create params, flash
    render_erb :create
  end
  def edit params, flash
    categoria = @clazz.find(params[:id])
    render_erb :edit, locals: {model: categoria}
  end
  def list params, flash
    models = @clazz.all
    render_erb :list, locals: {list: models}
  end
  def delete params, flash
    begin
      @clazz.delete params[:id]
    rescue
      flash[:error] = "Não foi possível remover!"
      flash[:error] << "<br/>"
      flash[:error] << $!.to_s
    end
  end
  def save params, flash
    begin
      @clazz.create(params)
    rescue
      flash[:error] = "Não foi possível salvar!"
      flash[:error] << "<br/>"
      flash[:error] << $!.to_s
    end
  end
  def update params, flash
    begin
      Categoria.find(params[:id])
      categoria.update_attrs(params)
    rescue
      flash[:error] = "Não foi possível atualizar!"
      flash[:error] << "<br/>"
      flash[:error] << $!.to_s
    end
  end

end
