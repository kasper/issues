class DataMapper::Validate::ValidationErrors

  def to_json
    @errors.to_hash.to_json
  end

end