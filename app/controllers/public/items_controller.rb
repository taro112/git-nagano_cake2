class Public::ItemsController < ApplicationController
end
@item = Item.new(item_image_params)
        @item.user_id = current_user.id
        @item.save
        redirect_to admin_item_path  