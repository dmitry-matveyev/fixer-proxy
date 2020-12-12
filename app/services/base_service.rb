class BaseService
  def self.call(*params)
    new(*params).call
  end

  def call
    raise NotImplementedError
  end

  def initialize(*_params)
    raise NotImplementedError
  end
end
