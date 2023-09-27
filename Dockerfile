FROM registry.access.redhat.com/ubi9-minimal

RUN microdnf install java-17 python3 gcc python3-devel -y && \
    microdnf clean all && \
    python -m ensurepip --upgrade && \
    pip3 install ansible==8.4.0 ansible-rulebook==1.0.2 asyncio aiohttp aiosignal

ENV HOME="/tmp/ansible-eda"
ENV JAVA_HOME="/usr/lib/jvm/jre-17"

WORKDIR /tmp/collections

COPY collections .

ARG ANSIBLE_EDA_COLLECTION="mronconi-ansible_eda-1.0.0.tar.gz"

RUN ansible-galaxy collection install $ANSIBLE_EDA_COLLECTION --verbose --no-cache --collections-path "/tmp/ansible-eda"
RUN mkdir -p /usr/share/ansible && ln -s /tmp/ansible-eda /usr/share/ansible/collections

WORKDIR /tmp/ansible-eda

COPY ansible.cfg .
COPY inventory .
COPY rulebooks .
COPY playbooks .

RUN chgrp -R 0 /tmp/ansible-eda && \
    chmod -R g=u /tmp/ansible-eda

CMD ansible-rulebook --rulebook snow-rulebook.yml -i inventory --env-vars SN_HOST,SN_USERNAME,SN_PASSWORD --verbose
