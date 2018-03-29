
# ECRから取得するDockerイメージ(確認用)
FROM 928622159311.dkr.ecr.ap-northeast-1.amazonaws.com/pf-dev-ecr-baseimg:latest

# テスト用PHPスクリプトをDockerコンテナ内にコピー(確認用)
COPY index.php /var/www/html/
# pythonをダウンロード(確認用)
RUN yum -y install python36u
RUN yum -y install python36u-pip

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
