FROM ghcr.io/saicharan0112/magic_netgen_ci:alpha

RUN apt-get -y update
RUN apt-get -y upgrade
COPY testcases /vezzal/testcases
COPY scripts /vezzal/scripts
ARG key
ENV mail_key $key

ARG emails
ENV mail_list $emails

WORKDIR /vezzal
RUN chmod +x scripts/test_magic.sh
RUN scripts/test_magic.sh $mail_list $mail_key
