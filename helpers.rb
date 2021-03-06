module Helpers
  TITLE = "Days Since Last Tech Incident"

  def partial(page, options={})
    erb "_#{page}".to_sym, options.merge!(:layout => false)
  end

  def flash_types
    [:success, :notice, :warning, :error]
  end
end
