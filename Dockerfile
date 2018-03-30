# ECRから取得するDockerイメージ
FROM 928622159311.dkr.ecr.ap-northeast-1.amazonaws.com/pf-dev-ecr-baseimg:latest

# アップデートと必要なパッケージのインストール
RUN yum -y update ; yum clean all
RUN yum -y install python3
RUN python -m pip -V

# テスト用PHPスクリプトをDockerコンテナ内にコピー(確認用)
COPY index.php /var/www/html/

# extra metadata
MAINTAINER NRI
LABEL version="1.0"
LABEL description="Text API Application Server Image with Dockerfile."

# ソースディレクトリ作成
RUN mkdir -p /usr/src/app && mkdir /log
WORKDIR /usr/src/app

# pythonのライブラリ取得
 COPY . /usr/src/app
 RUN pip install --upgrade pip
 RUN pip install -r requirements.txt

# 80番ポートを外部に公開
EXPOSE 80

# コンテナ実行時にdjango server起動
# CMD ["python","/usr/src/app/manage.py","runserver"]

# Apacheを起動(確認用)
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
