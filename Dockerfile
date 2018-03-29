# DockerHubからAmazon Linux 2のDockerイメージを取得
FROM amazonlinux:2

# 作成者情報
MAINTAINER NRI

# アップデートと必要なパッケージのインストール
RUN yum -y update ; yum clean all
RUN yum -y install httpd php python-pip docker git openssh-clients openssh-server python; yum clean all
# AWS CLIのインストール
RUN pip install awscli
# PHPの時刻を日本時間に
RUN sed -ri 's/;date.timezone =/date.timezone = Asia\/Tokyo/g' /etc/php.ini

# テスト用PHPスクリプトをDockerコンテナ内にコピー(確認用)
COPY index.php /var/www/html/

# pythonイメージからスタート
# FROM python:3.6.4

# extra metadata
MAINTAINER NRI
LABEL version="1.0"
LABEL description="Text API Application Server Image with Dockerfile."

# ソースディレクトリ作成
RUN mkdir -p /usr/src/app && mkdir /log
WORKDIR /usr/src/app

# pythonのライブラリ取得
COPY . /usr/src/app
RUN pip install -r requirements.txt

# 80番ポートを外部に公開
EXPOSE 80

# コンテナ実行時にdjango server起動
# CMD ["python","/usr/src/app/manage.py","runserver"]

# Apacheを起動(確認用)
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
