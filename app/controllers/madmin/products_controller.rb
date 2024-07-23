module Madmin
  class ProductsController < Madmin::ResourceController
    private

    def set_record
      @record = resource.model.find_by!(slug: params[:id])
    end
  end
end
