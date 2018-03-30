# ECRから取得するDockerイメージ
FROM 928622159311.dkr.ecr.ap-northeast-1.amazonaws.com/pf-dev-ecr-baseimg:latest

# 作成者情報
MAINTAINER NRI

# テスト用PHPスクリプトをDockerコンテナ内にコピー
COPY index.php /var/www/html/

# 80番ポートを外部に公開
EXPOSE 80

# Apacheを起動
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
