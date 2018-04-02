
FROM python:3.6.4-stretch

# extra metadata
MAINTAINER NRI
LABEL version="1.0"
LABEL description="Text API Application Server Image with Dockerfile."

# アップデートと必要なパッケージのインストール
RUN yum -y update ; yum clean all
RUN yum -y install httpd httpd-devel python3 python3-pip python3-devel docker git openssh-clients openssh-server gcc ; yum clean all

# AWS CLIのインストール
RUN pip3 install awscli

# ソースディレクトリ作成
RUN mkdir -p /usr/src/app && mkdir /log
WORKDIR /usr/src/app

#ソースを配置
COPY . /usr/src/app

#TODO ログ出力場所変更時に変更する
#ログ出力場所に書き込み権限がないため、権限変更
RUN chmod 777 /usr/src/app/Search

RUN mkdir /usr/src/app/Search/config/data/pickle
RUN chmod 777 /usr/src/app/Search/config/data/pickle

# pythonライブラリ取得
RUN pip3 install -r requirements.txt

#wisgi設定ファイルを配置
COPY wsgi.conf /etc/httpd/conf.modules.d/
RUN echo -n 'LoadModule wsgi_module '> /etc/httpd/conf.modules.d/mod_wsgi.conf
RUN find / -name '*wsgi*.so' >> /etc/httpd/conf.modules.d/mod_wsgi.conf

# 80番ポートを外部に公開
EXPOSE 80

# Apacheを起動
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
