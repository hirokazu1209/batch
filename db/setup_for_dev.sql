-- バッチ実行用のユーザーを作成
-- IDENTIFIED BY 'batch' : 接続時のパスワードを設定
CREATE USER IF NOT EXISTS batch_user IDENTIFIED BY 'batch';

-- developmentの環境で使用数るbatch_devのデータベース作成
-- batch_userにbatch_devを使用するための権限を付与している
CREATE DATABASE IF NOT EXISTS batch_dev DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- batch_userへbatch_devへの権限を付与している
GRANT ALL PRIVILEGES on batch_dev.* to batch_user;

CREATE DATABASE IF NOT EXISTS batch_test DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

GRANT ALL PRIVILEGES on batch_test.* to batch_user;
