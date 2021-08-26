class ItemController < ApplicationController

    def create_item_in_storage 
        new_item = Item.new(item_params)
        new_item.status = 3
        new_item.shopping_list = false
        
        respond_to do |format|
            if new_item.save
                format.html { redirect_to request.referer }
            end
        end
    end

    def change_item_status
        change_target_item_id = params[:item_id]
        change_action_type = params[:change_action_type].to_i

        new_status = return_new_item_status(change_target_item_id, change_action_type)

        if new_status <= 0
            delete_item(change_target_item_id)
        else
            update_item_status(change_target_item_id, new_status)
        end
    end


    private 

    # storong parameter
    def item_params
        params.require(:item).permit(:name, :storage_id)
    end

    ## itemのステータスを渡されたステータスに更新する
    def update_item_status(change_target_item_id, new_status)
        change_target_item = Item.find(change_target_item_id)
        change_target_item.status = new_status

        respond_to do |format|
            if change_target_item.save
                format.html { redirect_to request.referer }
            end
        end
    end

    ## 渡されたIDのitemを削除する。
    def delete_item(delete_item_id)
        delete_item_target = Item.find(delete_item_id)

        respond_to do |format|
            if delete_item_target.destroy
                format.html { redirect_to request.referer }
            end
        end

    end


    # 指定したIDのアイテムの新しいステータスの値を計算して返す
    def return_new_item_status(change_target_item_id, change_action_type)
        current_item_status = Item.find(change_target_item_id).status
        new_item_status = current_item_status
        
        if change_action_type == 1
            if current_item_status < 3
                new_item_status += 1
            end
        elsif change_action_type == -1
            new_item_status -= 1
        else
            new_item_status = 0
        end

        return new_item_status
    end


    




end

