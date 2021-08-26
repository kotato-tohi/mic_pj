class StorageController < ApplicationController
    def index
        @new_storage = Storage.new
        @storage_ids = return_storage_ids(current_user.id)
        @storages = return_storages(@storage_ids)
    end



    def create_storage
        new_storage = Storage.new(storage_params)
        new_storage.owner_id = current_user.id

        respond_to do |format|

            if new_storage.save
                add_link_table_record(current_user.id, new_storage.id)
                format.html { redirect_to request.referer }
            else
                format.html { redirect_to request.referer }
            end
        end
    end


    def delete_storage
        delete_storage_id = params[:storage_id]
        target_storage = Storage.find(delete_storage_id)

        respond_to do |format|
            if target_storage.destroy
                format.html { redirect_to request.referer }
            end
        end
    



    end







    helper_method :return_user_name_from_id




    private 
    
    # # ストレージIDとユーザIDを受け取ってLinkテーブルに紐付けを追加する
    def add_link_table_record(user_id, storage_id)
        link = Link.new(user_id:user_id, storage_id:storage_id)
        
        if user_id == current_user.id
            link.own = true
        else
            link.own = false
        end

        begin
            link.save
        rescue => e
            puts e
        end
    end



    # strong params
    def storage_params
        params.require(:storage).permit(:name)
    end

    # ユーザIDからユーザ名を取得して返すヘルパーメソッド
    def return_user_name_from_id(user_id)
        user_name = User.find(user_id).name
        return user_name
    end


    # ユーザIDがマッチするLinkテーブルのストレージIDのリストを取得する
    def return_storage_ids(user_id)
        storage_ids = Link.where(user_id:user_id).pluck(:storage_id)
        return storage_ids
    end

    # ストレージIDリストにマッチするストレージインスタンスのリストを返す
    def return_storages(storage_ids)
        storages = Storage.where(id:storage_ids)
        return storages
    end


    

    
    
    

end
