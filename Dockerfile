# DockerHubからAmazon Linux 2のDockerイメージを取得
FROM amazonlinux:2

# 作成者情報
MAINTAINER NRI

# アップデートと必要なパッケージのインストール
RUN yum -y update ; yum clean all
RUN yum -y install httpd php python3 python3-pip docker git openssh-clients openssh-server ; yum clean all
# AWS CLIのインストール
RUN pip3 install awscli
# PHPの時刻を日本時間に
RUN sed -ri 's/;date.timezone =/date.timezone = Asia\/Tokyo/g' /etc/php.ini

# 80番ポートを外部に公開
EXPOSE 80

# Apacheを起動
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]

