class StorageController < ApplicationController
    def index
        @new_storage = Storage.new

        @storages = return_storage_ids(current_user.id)
        ## ここ！
        ## privateの関数を使ってストレージ一覧を表示するところから
    end




    
    private 
    
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
