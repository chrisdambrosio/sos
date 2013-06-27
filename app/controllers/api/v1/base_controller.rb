class Api::V1::BaseController < ActionController::Base
  responders :json
  respond_to :json
  before_action :get_limit,  only: [:index]
  before_action :get_offset, only: [:index]

  def metadata
    total = controller_name.classify.constantize.count
    if action_name == 'index'
      { meta: { total: total, limit: @limit, offset: @offset } }
    else
      {}
    end
  end

  def get_limit
    limit = params[:limit].to_i

    if limit > 0
      @limit = limit
    else
      @limit = 100
    end
  end

  def get_offset
    @offset = params[:offset].to_i
  end
end
